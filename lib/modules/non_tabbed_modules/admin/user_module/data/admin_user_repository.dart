import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/shared/models/shared_list_user_data.dart';
import 'package:housing_management_mobile/shared/models/shared_user_data_model.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';

import '../../../../../shared/data/api_route.dart';
import '../../../../../shared/utils/helper/helper_http.dart';

class AdminUserRepository {
  Dio http = AppHelperHttp().http();

  Future<SharedUserListData?> getListUser() async {
    String path = AppApiRoutes.pathGetUser;
    SharedUserListData userList;

    try {
      Response response = await http.get(path);
      userList = SharedUserListData.fromJson(response.data);

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

  Future<SharedUserData?> getUser(dynamic id) async {
    String path = '${AppApiRoutes.pathGetUser}/$id';
    SharedUserData user;

    try {
      Response response = await http.get(path);
      user = SharedUserData.fromJson(response.data);

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

  Future<bool> deleteUser(dynamic id) async {
    String path = '${AppApiRoutes.pathDeleteUser}/$id';

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

  Future<bool> retrieveUser(dynamic id) async {
    String path = '${AppApiRoutes.pathRetrieveUser}/$id';

    try {
      Response response = await http.patch(path);
      dynamic data = response.data;

      if (data['code'] == 200) {
        return true;
      }

      return false;
    } on DioException catch (err) {
      // http error
      AppUtils.logE(err.message.toString().toString());
      return false;
    } catch (err) {
      // unknown error
      AppUtils.logE(err.toString());
      return false;
    }
  }

  Future<bool> submitCreateUser(SubmitParams params,
      [bool isEdit = false, dynamic userId]) async {
    String path =
        !isEdit ? AppApiRoutes.pathAddUser : AppApiRoutes.pathEditUser;

    try {
      Map<String, dynamic> mapData = {
        'email': params.email,
        'full_name': params.fullName,
        'phone_number': params.phoneNumber,
        'house_number': params.houseNumber,
        'house_block': params.houseBlok,
      };

      if (isEdit) {
        mapData.addAll({'user_id': userId});
      }

      if (params.password.isNotEmpty) {
        mapData.addAll({
          'password': params.password,
        });
      } else {
        mapData.addAll({
          'password': params.phoneNumber,
        });
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
}

class SubmitParams {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;
  final String houseBlok;
  final String houseNumber;

  SubmitParams({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.houseBlok,
    required this.houseNumber,
  });
}
