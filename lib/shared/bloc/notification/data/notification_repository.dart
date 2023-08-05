import 'package:housing_management_mobile/config/constants.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationRepository {
  void initializeNotification() {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(AppConfigConstant.onesginalAppId);

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      AppUtils.logD("Accepted permission: $accepted");
    });

    OneSignal.shared.setNotificationOpenedHandler((
      OSNotificationOpenedResult result,
    ) {
      // Will be called whenever a notification is opened/button pressed.
      AppUtils.logD(result.notification.title.toString());
      AppUtils.logD(result.notification.body.toString());
    });
  }
}
