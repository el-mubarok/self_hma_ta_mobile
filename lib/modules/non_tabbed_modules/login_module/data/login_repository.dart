import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../config/constants.dart';
import '../../../../shared/data/api_route.dart';
import '../../../../shared/models/shared_user_data_model.dart';
import '../../../../shared/utils/helper/helper_http.dart';
import '../../../../shared/utils/helper/helper_storage.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/utils/utils_global.dart';

class LoginData {
  final bool isLoggedIn;
  final String? type;

  LoginData({required this.isLoggedIn, this.type});
}

class LoginRepository {
  Future<SharedUserData?> submitLogin(String username, String password) async {
    Dio http = AppHelperHttp().http();
    String path = AppApiRoutes.pathLogin;
    SharedUserData? data;

    AppUtils.logD(path);

    try {
      FormData postData = FormData.fromMap({
        "username": username,
        "password": password,
        "play_id": (await OneSignal.shared.getDeviceState())?.userId ?? ''
      });

      AppUtils.logD({
        "username": username,
        "password": password,
      }.toString());

      Response response = await http.post(
        path,
        data: postData,
      );
      data = SharedUserData.fromJson(response.data);

      await Future.delayed(const Duration(seconds: 1));

      if (response.statusCode == 200) {
        AppUtils.logD(data.data.type);
        return data;
      } else {
        return null;
      }
    } on DioException catch (err) {
      // http error
      /**
       * code:
       * 402 -> wrong password
       * 403 -> wrong username/password
       * 404 -> max attempt reached
       */
      if (kDebugMode) {
        print("submitLogin(): http error at: $err");
        print("submitLogin(): http error at: ${err.message.toString()}");
      }
      // data = SharedUserData.fromJson(err.response?.data);
      return null;
    } catch (err) {
      // unknown error
      if (kDebugMode) {
        print("submitLogin(): unknwon error at: $err");
      }
      return null;
    }
  }

  Future<LoginData> checkIsLoggedIn() async {
    bool isExists = await AppHelperStorage().checkIsExists(
      AppConfigConstant.sessionUserData,
    );

    if (isExists) {
      // get latest user info
      await reloadUserData();

      // load userdata to active state
      var user = await AppHelperStorage().loadUserDataToState();
      return LoginData(
        isLoggedIn: isExists,
        type: user?.data.type,
      );
    }

    return LoginData(isLoggedIn: isExists);
  }

  Future<bool> reloadUserData() async {
    Dio http = AppHelperHttp().http();
    SharedUserData? user = AppUtilsGlobal().userData.value;
    String? userId = user?.data.id;
    String path = '';
    SharedUserData? data;

    if (user?.data.type == 'admin') {
      path = '${AppApiRoutes.pathGetAdmin}/$userId';
    } else {
      path = '${AppApiRoutes.pathGetUser}/$userId';
    }

    try {
      Response response = await http.get(path);

      data = SharedUserData.fromJson(response.data);

      await AppHelperStorage().storeUserData(data);

      return true;
    } on DioException catch (err) {
      // http error
      AppUtils.logD("reloadUserData(): net error at: $err");
      return false;
    } catch (err) {
      // unknown error
      AppUtils.logD("reloadUserData(): unknown error at: $err");
      return false;
    }
  }
}
