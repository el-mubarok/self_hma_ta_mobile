import 'package:dio/dio.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_active.dart';

import '../../../../../shared/data/api_route.dart';
import '../../../../../shared/utils/helper/helper_http.dart';
import '../../../../../shared/utils/utils.dart';

class AdminDashboardRepository {
  Dio http = AppHelperHttp().http();

  Future<SharedBillingActive?> getActiveBilling() async {
    String path = AppApiRoutes.pathGetActiveBilling;
    SharedBillingActive userList;

    try {
      Response response = await http.get(path);
      AppUtils.logD("UWYWYWYYWY: ${response.data.toString()}");
      userList = SharedBillingActive.fromJson(response.data);

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

  Future<Map<String, dynamic>?> getUserTotal() async {
    String path = '${AppApiRoutes.pathGetUser}/total';
    Map<String, dynamic>? user;

    try {
      Response response = await http.get(path);
      user = response.data['data'];

      AppUtils.logD("UWYWYWYYWY: ${response.data.toString()}");

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
}
