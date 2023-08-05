import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static logD(String content) {
    if (kDebugMode) {
      print("[DEBUG] $content");
    }
  }

  static logE(String content) {
    if (kDebugMode) {
      print("[ERROR] $content");
    }
  }

  static logW(String content) {
    if (kDebugMode) {
      print("[WARNING] $content");
    }
  }

  static getAbbrString(String str, [String delimiter = ' ']) {
    var strArr = str.split(delimiter);
    var charStart = strArr[0][0];
    var charEnd = '';

    if (strArr.length > 2) {
      charEnd = strArr[strArr.length - 1][0];
    } else if (strArr.length == 2) {
      charEnd = strArr[1][0];
    } else {
      charEnd = strArr[0][1];
    }

    return '$charStart$charEnd'.toUpperCase();
  }

  static getScheduleTimeRemoveAlertText(String? time, int index) {
    return 'Remove Time ${index + 1} (${DateFormat.jm().format(DateTime.parse('2020-12-12 $time'))})?';
  }
}
