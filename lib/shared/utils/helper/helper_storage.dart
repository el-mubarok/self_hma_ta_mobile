import 'dart:convert';

import '../../../config/constants.dart';
import '../../models/shared_interface_storage.dart';
import '../../models/shared_user_data_model.dart';
import '../utils.dart';
import '../utils_global.dart';
import '../utils_storage.dart';

class AppHelperStorage {
  Future<void> storeUserData(SharedUserData data) async {
    await AppUtilsStorage().write(
      SharedInterfaceStorage(
        AppConfigConstant.sessionUserData,
        sharedUserDataToJson(data),
      ),
    );
    // then load to active state
    await loadUserDataToState();
  }

  Future<SharedUserData?> loadUserDataToState() async {
    String? loadedString = await AppUtilsStorage().read(
      AppConfigConstant.sessionUserData,
    );

    if (loadedString != null) {
      Map<String, dynamic> loadedMap = jsonDecode(
        loadedString,
      );
      SharedUserData? data = SharedUserData.fromJson(
        loadedMap,
      );

      AppUtilsGlobal().userData.value = data;

      return data;
    }
  }

  Future<bool> checkIsExists(String key) async {
    return await AppUtilsStorage().checkKeyExists(key);
  }

  Future<void> clear() async {
    return await AppUtilsStorage().deleteAll();
  }
}
