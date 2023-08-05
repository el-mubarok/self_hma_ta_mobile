import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:housing_management_mobile/shared/data/api_route.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_payment_active.dart';
import 'package:housing_management_mobile/shared/models/shared_payment_calculate.dart';
import 'package:housing_management_mobile/shared/models/shared_payment_request_result.dart';
import 'package:housing_management_mobile/shared/models/shared_user_data_model.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:housing_management_mobile/shared/utils/utils_global.dart';

import '../../../../../shared/utils/helper/helper_http.dart';

class UserPaymentRepository {
  Dio http = AppHelperHttp().http();
  SharedUserData? user = AppUtilsGlobal().userData.value;

  Future<SharedPaymentCalculate?> calculatePayment(
    String code,
    String price,
  ) async {
    String path = AppApiRoutes.pathCalculatePayment;
    SharedPaymentCalculate? data;

    try {
      FormData formData = FormData.fromMap({
        'payment_method_id': code,
        'base_amount': price,
      });
      Response response = await http.post(
        path,
        data: formData,
      );
      data = SharedPaymentCalculate.fromJson(response.data);

      AppUtils.logD(json.encode(response.data));

      return data;
    } on DioException catch (err) {
      // http error
      AppUtils.logE("http error: ${err.message}");
      return null;
    } catch (err) {
      // unknown error
      AppUtils.logE("unknown error: $err");
      return null;
    }
  }

  Future<SharedPaymentRequestResult?> requestPayment(
    RequestParams params,
  ) async {
    String path = AppApiRoutes.pathRequestPayment;
    SharedPaymentRequestResult? data;

    try {
      Map<String, dynamic> vaNumberMap = {
        "1": user?.data.accountBca,
        "2": user?.data.accountBni,
        "3": user?.data.accountBri,
        "4": user?.data.accountBsi,
        // "1": user?.data.account,
        "6": user?.data.accountMandiri,
        "7": user?.data.accountPermata,
      };

      Map<String, dynamic> formMap = {
        'user_id': user?.data.id,
        'va_number': vaNumberMap[params.paymentMethodId],
        'billing_session_id': params.billingSessionId,
        'payment_method_id': params.paymentMethodId,
        'base_amount': params.baseAmount,
        'amount': params.amount,
        'phone_number': params.phoneNumber,
      };
      FormData formData = FormData.fromMap(formMap);

      AppUtils.logD(json.encode(formMap));

      // return null;

      Response response = await http.post(
        path,
        data: formData,
      );
      data = SharedPaymentRequestResult.fromJson(response.data);

      AppUtils.logD(json.encode(response.data));
      AppUtilsGlobal().reloadUserDashboard.value = true;

      return data;
    } on DioException catch (err) {
      // http error
      AppUtils.logE("http error: ${err.message}");
      return null;
    } catch (err) {
      // unknown error
      AppUtils.logE("unknown error: $err");
      return null;
    }
  }

  Future<SharedBillingPaymentActive?> getPaymentDetails(
    dynamic paymentId,
  ) async {
    String path = '${AppApiRoutes.pathGetPaymentDetails}/$paymentId';
    SharedBillingPaymentActive? data;

    try {
      Response response = await http.get(path);
      data = SharedBillingPaymentActive.fromJson(response.data);

      return data;
    } on DioException catch (err) {
      // http error
      AppUtils.logE("http error: ${err.message}");
      return null;
    } catch (err) {
      // unknown error
      AppUtils.logE("unknown error: $err");
      return null;
    }
  }
}

class RequestParams {
  final String billingSessionId;
  final String paymentMethodId;
  final String baseAmount;
  final String amount;
  final String? phoneNumber;

  RequestParams({
    required this.billingSessionId,
    required this.paymentMethodId,
    required this.baseAmount,
    required this.amount,
    this.phoneNumber,
  });
}
