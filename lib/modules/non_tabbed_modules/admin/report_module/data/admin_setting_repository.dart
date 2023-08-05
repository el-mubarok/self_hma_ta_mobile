import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_data.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_list_data.dart';
import 'package:housing_management_mobile/shared/models/shared_list_user_data.dart';
import 'package:housing_management_mobile/shared/models/shared_user_data_model.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:housing_management_mobile/shared/utils/utils_global.dart';

import '../../../../../shared/data/api_route.dart';
import '../../../../../shared/utils/helper/helper_http.dart';

class AdminReportRepository {
  Dio http = AppHelperHttp().http();

  Future<SharedBillingListData?> getListBilling() async {
    String path = AppApiRoutes.pathGetBilling;
    SharedBillingListData userList;

    try {
      Response response = await http.get(path);
      userList = SharedBillingListData.fromJson(response.data);

      return userList;
    } on DioException catch (err) {
      // http error
      AppUtils.logE(err.message.toString());
      return null;
    } catch (err) {
      // unknown error
      AppUtils.logE(err.toString());
      return null;
    }
  }

  Future<SharedBillingData?> getBilling(dynamic id) async {
    String path = '${AppApiRoutes.pathGetBilling}/$id';
    SharedBillingData user;

    try {
      Response response = await http.get(path);
      user = SharedBillingData.fromJson(response.data);

      return user;
    } on DioException catch (err) {
      // http error
      AppUtils.logE(err.message.toString());
      return null;
    } catch (err) {
      // unknown error
      AppUtils.logE(err.toString());
      return null;
    }
  }

  Future<bool> submitCreateSession(SubmitParams params,
      [bool isEdit = false, dynamic sessionId]) async {
    String path =
        !isEdit ? AppApiRoutes.pathCreateBilling : AppApiRoutes.pathEditBilling;

    try {
      Map<String, dynamic> mapData = {
        'name': params.name,
        'description': params.description,
        'from_date': params.fromDate,
        'to_date': params.toDate,
        'price': params.price,
      };

      if (!isEdit) {
        mapData.addAll({'admin_id': params.adminId});
      }

      if (isEdit) {
        mapData.addAll({'id': sessionId});
      }

      AppUtils.logD(mapData.toString());

      FormData postData = FormData.fromMap(mapData);

      Response response = !isEdit
          ? await http.post(
              path,
              data: postData,
            )
          : await http.patch(
              path,
              data: mapData,
              options: Options(
                contentType: Headers.formUrlEncodedContentType,
                receiveDataWhenStatusError: true,
              ),
            );

      if (response.data['code'] == 200) {
        return true;
      }

      return false;
    } on DioException catch (err) {
      // http error
      AppUtils.logE('Http error: ${err.requestOptions.method}');
      // debugPrint('Http error: ${err.response?.data}', wrapWidth: 4000);
      return false;
    } catch (err) {
      // unknown error
      AppUtils.logE('Unknown error: ${err.toString()}');
      return false;
    }
  }

  Future<bool> submitCreateSessionTime(List<SubmitTimeParams> params,
      [bool isEdit = false, dynamic timeId]) async {
    String path = !isEdit
        ? AppApiRoutes.pathCreateBillingTime
        : AppApiRoutes.pathEditBillingTIme;

    try {
      Map<String, dynamic> mapData = {};

      for (var i = 0; i < params.length; i++) {
        if (!isEdit) {
          mapData.addAll({'billing_session_id': params[0].billingSessionId});
          mapData.addAll({'admin_id': params[0].adminId});
          mapData.addAll({
            'time_stamp': params[0].timeStamp,
          });
        }

        if (isEdit) {
          mapData.addAll({
            'time_stamp[$i]': params[i].timeStamp,
          });
          mapData.addAll({'id[$i]': params[i].timeId});
        }
      }

      AppUtils.logD(mapData.toString());

      FormData postData = FormData.fromMap(mapData);

      Response response = !isEdit
          ? await http.post(
              path,
              data: postData,
            )
          : await http.patch(
              path,
              data: mapData,
              options: Options(
                contentType: Headers.formUrlEncodedContentType,
                receiveDataWhenStatusError: true,
              ),
            );

      if (response.data['code'] == 200) {
        return true;
      }

      return false;
    } on DioException catch (err) {
      // http error
      AppUtils.logE('Http error: ${err}');
      // debugPrint('Http error: ${err.response?.data}', wrapWidth: 4000);
      return false;
    } catch (err) {
      // unknown error
      AppUtils.logE('Unknown error: ${err.toString()}');
      return false;
    }
  }

  Future<bool> deleteSessionTime(dynamic id) async {
    String path = '${AppApiRoutes.pathDeleteBillingTime}/$id';

    try {
      Response response = await http.delete(path);
      dynamic data = response.data;

      if (data['code'] == 200) {
        return true;
      }

      return false;
    } on DioException catch (err) {
      // http error
      AppUtils.logE(err.message.toString());
      return false;
    } catch (err) {
      // unknown error
      AppUtils.logE(err.toString());
      return false;
    }
  }
}

class SubmitParams {
  final String adminId;
  final String name;
  final String description;
  final String fromDate;
  final String toDate;
  final String? price;

  SubmitParams({
    required this.adminId,
    required this.name,
    required this.description,
    required this.fromDate,
    required this.toDate,
    this.price,
  });
}

class SubmitTimeParams {
  final String billingSessionId;
  final String adminId;
  final String timeStamp;
  final dynamic timeId;

  SubmitTimeParams({
    required this.billingSessionId,
    required this.adminId,
    required this.timeStamp,
    this.timeId,
  });
}
