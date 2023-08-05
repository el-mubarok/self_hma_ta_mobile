import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import '../../config/constants.dart';
import '../models/shared_interface_storage.dart';
import 'utils.dart';

class AppUtilsStorage {
  Future<String?> read(String key) async {
    try {
      await Hive.initFlutter();
      Box box = await Hive.openBox(
        AppConfigConstant.sessionBox,
      );
      return await box.get(key);
    } catch (e) {
      return null;
    }
  }

  Future<void> write(SharedInterfaceStorage item) async {
    try {
      await Hive.initFlutter();
      Box box = await Hive.openBox(AppConfigConstant.sessionBox);
      await box.put(item.key, item.value);
    } catch (e) {
      if (kDebugMode) {
        print("write session error $e");
      }
    }
  }

  Future<void> delete(String key) async {
    try {
      await Hive.initFlutter();
      Box box = await Hive.openBox(AppConfigConstant.sessionBox);
      await box.delete(key);
    } catch (e) {
      if (kDebugMode) {
        print("delete session error $e");
      }
    }
  }

  Future<void> deleteAll() async {
    try {
      await Hive.initFlutter();
      Box box = await Hive.openBox(AppConfigConstant.sessionBox);
      int result = await box.clear();
      AppUtils.logD("clearing result: $result");
    } catch (e) {
      if (kDebugMode) {
        print("clear session error $e");
      }
    }
  }

  Future<bool> checkKeyExists(String key) async {
    try {
      await Hive.initFlutter();
      Box box = await Hive.openBox(AppConfigConstant.sessionBox);
      return box.containsKey(key);
    } catch (e) {
      if (kDebugMode) {
        print("write session error $e");
      }
      return false;
    }
  }
}
