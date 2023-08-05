import 'package:housing_management_mobile/config/assets.dart';

class AppConfigConstant {
  // storage
  static const String sessionBox = 'box_session';
  static const String sessionUserData = 'user_data_session';
  static const String sessionSync = 'app_sync_session';
  static const String sessionAttendance = 'app_attendance_session';
  //
  static const String everyFiveMinutes = '*/5 * * * *';
  //
  static const int roleForeman = 2;
  static const int roleAssistant = 1;
  //
  static const openMorning = [600, 2359]; // [0000, 600]; //[600, 1059];
  static const openMorningMessage =
      'MORNING session only start from 06:00 AM until 10:59 AM.';
  //
  static const openLate = [1100, 1159];
  static const openLateMessage =
      'MORNING LATE session only start from 11:00 AM until 11:59 AM.';
  //
  static const openEvening = [1600, 2359];
  static const openEveningMessage =
      'EVENING session only start from 04:00 PM until 11:59 PM.';

  // id's
  static const onesginalAppId = '25cb7e7c-7b91-45d8-bdc0-b283744bf441';
  //
  static const Map<String, dynamic> paymentLogo = {
    'BCA': AppAsset.paymentVaBcaSm,
    'BNI': AppAsset.paymentVaBniSm,
    'BRI': AppAsset.paymentVaBriSm,
    'BSI': AppAsset.paymentVaBsiSm,
    'CIMB': AppAsset.paymentVaCimbSm,
    'MANDIRI': AppAsset.paymentVaMandiriSm,
    'PERMATA': AppAsset.paymentVaPermataSm,
    'ID_OVO': AppAsset.paymentEwalletOvoSm,
    'ID_DANA': AppAsset.paymentEwalletDanaSm,
    'ID_LINKAJA': AppAsset.paymentEwalletLaSm,
    'ID_SHOPEEPAY': AppAsset.paymentEwalletSpSm,
  };
  static const String successUrl =
      'https://el-mubarok.github.io/self-success-page/?bg=#DF3526&color=#fff';
}
