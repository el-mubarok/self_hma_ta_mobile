import 'package:dio/dio.dart';
import 'package:housing_management_mobile/shared/data/api_route.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_active.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_payment_active.dart';
import 'package:housing_management_mobile/shared/models/shared_user_data_model.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:housing_management_mobile/shared/utils/utils_global.dart';

import '../../../../../shared/models/shared_payment_user_history.dart';
import '../../../../../shared/utils/helper/helper_http.dart';

class UserDashboardRepository {
  Dio http = AppHelperHttp().http();
  SharedUserData? user = AppUtilsGlobal().userData.value;

  Future<SharedBillingActive?> getActiveSession() async {
    String path = '${AppApiRoutes.pathGetActiveBilling}/${user?.data.id}';
    SharedBillingActive? data;

    try {
      Response response = await http.get(path);
      data = SharedBillingActive.fromJson(response.data);

      AppUtils.logD("check active session");

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

  Future<SharedBillingPaymentActive?> getActivePayment() async {
    String path = AppApiRoutes.pathGetActivePayment;
    SharedBillingPaymentActive? data;

    try {
      Response response = await http.get(
        path,
        queryParameters: {
          'user_id': user?.data.id,
        },
      );
      data = SharedBillingPaymentActive.fromJson(response.data);

      return data;
    } on DioException catch (err) {
      // http error
      AppUtils.logE("payment active http error: ${err.message}");
      return null;
    } catch (err) {
      // unknown error
      AppUtils.logE("payment active unknown error: $err");
      return null;
    }
  }

  Future<SharedPaymentUserHistory?> getHistory() async {
    String path = '${AppApiRoutes.pathGetPaymentHistory}/${user?.data.id}';
    SharedPaymentUserHistory? data;

    try {
      Response response = await http.get(path);
      data = SharedPaymentUserHistory.fromJson(response.data);

      AppUtils.logD("user payment history");

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
