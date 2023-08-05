import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../utils.dart';

class AppHelperIO {
  String offlinePath = "/temp/offline";
  String metaOfflinePath = "/temp/meta";

  Future<void> clearOfflineData(
    List<String> fileNames, [
    bool isMeta = false,
  ]) async {
    Directory? appDir = await getExternalStorageDirectory();
    String path = "";

    if (appDir != null) {
      try {
        if (!isMeta) {
          path = "${appDir.path}$offlinePath";
        } else {
          path = "${appDir.path}$metaOfflinePath";
        }

        if (fileNames.isNotEmpty) {
          for (var fileName in fileNames) {
            String fullPath = "$path/$fileName";
            File file = File(fullPath);

            // begin file deletion
            file.deleteSync();
          }
        }
      } catch (e) {
        AppUtils.logD("[clearOfflineData()]: dir not found");
      }
    }
  }
}
