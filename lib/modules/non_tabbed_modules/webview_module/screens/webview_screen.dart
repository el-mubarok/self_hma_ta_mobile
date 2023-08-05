import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:housing_management_mobile/config/constants.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/user/dashboard_module/bloc/user_dashboard_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/user/dashboard_module/data/user_dashboard_repository.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/user/payment_module/bloc/user_payment_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/user/payment_module/data/user_payment_repository.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:housing_management_mobile/themes/color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/ui/wrappers/wrapper_page.dart';

class WebViewModule extends StatefulWidget {
  final String url;

  const WebViewModule({
    super.key,
    required this.url,
  });

  @override
  State<StatefulWidget> createState() => _WebViewModule();
}

class _WebViewModule extends State<WebViewModule> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
  );

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      var uri = Uri.parse(widget.url);
      webViewController?.loadUrl(urlRequest: URLRequest(url: uri));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDashboardBloc(
        repository: UserDashboardRepository(),
      ),
      child: WrapperPage(
        safeTop: true,
        hasPadding: false,
        backgroundColor: Colors.white,
        statusBarColor: AppColors.adminOrange,
        height: MediaQuery.of(context).size.height,
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: BlocBuilder<UserDashboardBloc, UserDashboardState>(
            builder: (context, state) {
              return InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: Uri.parse("")),
                initialOptions: options,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {},
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT,
                  );
                },
                onLoadStop: (controller, url) async {
                  String currentUrl = url.toString();
                  Uri targetUrl = Uri.parse(AppConfigConstant.successUrl);

                  if (currentUrl == targetUrl.toString()) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        NamedRoute.moduleUserDashboard,
                        (route) => false,
                        arguments: {
                          'reload': true,
                        },
                      ).then((value) {
                        context.read<UserDashboardBloc>().add(
                              UDCrossCheckEvent(),
                            );
                      });
                    });
                  }
                },
                onLoadError: (controller, url, code, message) {},
                onProgressChanged: (controller, progress) {},
                onUpdateVisitedHistory: (controller, url, androidIsReload) {},
                onConsoleMessage: (controller, consoleMessage) {},
              );
            },
          ),
        ),
      ),
    );
  }
}
