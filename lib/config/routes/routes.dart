import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/user_module/screens/user_screen.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/user/setting_module/screens/setting_screen.dart';

import '../../modules/non_tabbed_modules/admin/dashboard_module/screens/dashboard_screen.dart';
import '../../modules/non_tabbed_modules/admin/report_module/screens/detail_screen.dart';
import '../../modules/non_tabbed_modules/admin/report_module/screens/report_screen.dart';
import '../../modules/non_tabbed_modules/admin/setting_module/screens/schedule_screen.dart';
import '../../modules/non_tabbed_modules/admin/setting_module/screens/setting_screen.dart';
import '../../modules/non_tabbed_modules/admin/user_module/screens/form_screen.dart';
import '../../modules/non_tabbed_modules/login_module/screens/login_screen.dart';
import '../../modules/non_tabbed_modules/splash_module/screens/splash_screen.dart';
import '../../modules/non_tabbed_modules/user/dashboard_module/screens/dashboard_screen.dart';
import '../../modules/non_tabbed_modules/user/payment_module/screens/payment_screen.dart';
import '../../modules/non_tabbed_modules/user/payment_module/screens/progress_payment_screen.dart';
import '../../modules/non_tabbed_modules/webview_module/screens/webview_screen.dart';
import 'route_names.dart';

class Routes {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      //
      case NamedRoute.moduleSplash:
        return MaterialPageRoute(
          builder: (_) => const ModuleSplash(),
        );
      //
      case NamedRoute.moduleLogin:
        return MaterialPageRoute(
          builder: (_) => const ModuleLogin(),
        );
      case NamedRoute.moduleWebview:
        final args = settings.arguments != null
            ? settings.arguments as RoutesArguments
            : null;
        return MaterialPageRoute(
          builder: (_) => WebViewModule(
            url: args?.args1 ?? false,
          ),
        );
      // //
      // case NamedRoute.moduleHome:
      //   return MaterialPageRoute(
      //     builder: (_) => const ModuleHome(),
      //   );

      // admin
      case NamedRoute.moduleAdminDashboard:
        return MaterialPageRoute(
          builder: (_) => const ModuleAdminDashboard(),
        );
      case NamedRoute.moduleAdminUser:
        return MaterialPageRoute(
          builder: (_) => const ModuleAdminUser(),
        );
      case NamedRoute.moduleAdminUserForm:
        final args = settings.arguments != null
            ? settings.arguments as RoutesArguments
            : null;
        return MaterialPageRoute(
          builder: (_) => ModuleAdminUserForm(
            isEdit: args?.args1 ?? false,
            userId: args?.args2,
          ),
        );
      case NamedRoute.moduleAdminReport:
        return MaterialPageRoute(
          builder: (_) => const ModuleAdminReport(),
        );
      case NamedRoute.moduleAdminReportDetail:
        return MaterialPageRoute(
          builder: (_) => const ModuleAdminReportDetail(),
        );
      case NamedRoute.moduleAdminSetting:
        return MaterialPageRoute(
          builder: (_) => const ModuleAdminSetting(),
        );
      case NamedRoute.moduleAdminSettingSchedule:
        return MaterialPageRoute(
          builder: (_) => const ModuleAdminSettingSchedule(),
        );

      // user
      case NamedRoute.moduleUserDashboard:
        return MaterialPageRoute(
          builder: (_) => const ModuleUserDashboard(),
        );
      case NamedRoute.moduleUserPayment:
        return MaterialPageRoute(
          builder: (_) => const ModuleUserPayment(),
        );
      case NamedRoute.moduleUserPaymentProgress:
        final args = settings.arguments != null
            ? settings.arguments as RoutesArguments
            : null;
        return MaterialPageRoute(
          builder: (_) => ModuleUserPaymentProgress(
            details: args?.args1,
          ),
        );
      case NamedRoute.moduleUserSetting:
        return MaterialPageRoute(
          builder: (_) => const ModuleUserSetting(),
        );

      // default page not found
      default:
        return CupertinoPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page is under development...'),
            ),
          ),
        );
    }
  }
}

class RoutesArguments {
  final dynamic args1;
  final dynamic args2;

  RoutesArguments({
    this.args1,
    this.args2,
  });
}
