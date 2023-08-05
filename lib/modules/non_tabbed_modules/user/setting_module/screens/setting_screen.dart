import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/themes/color.dart';

import '../../../../../shared/ui/widgets/widget_appbar.dart';
import '../../../../../shared/ui/wrappers/wrapper_page.dart';
import '../../../../../shared/utils/helper/helper_storage.dart';

class ModuleUserSetting extends StatefulWidget {
  const ModuleUserSetting({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleUserSetting();
}

class _ModuleUserSetting extends State<ModuleUserSetting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      safeTop: true,
      hasPadding: false,
      appBar: WidgetAppBar(
        title: 'Settings',
        // subtitle: 'Payment for this month',
        isUser: true,
        onTap: () => Navigator.pop(context),
      ),
      navigationBarColor: AppColors.adminOrange,
      statusBarColor: AppColors.adminOrange.darken(0.01),
      backgroundColor: AppColors.whiteDimm1,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          // _Item(
          //   title: 'Logout',
          //   onTap: () {},
          // ),
          //
          const _Separator(title: 'Account'),
          //
          GestureDetector(
            onTap: () {
              AppHelperStorage().clear().then((value) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  NamedRoute.moduleLogin,
                  (route) => false,
                );
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.adminOrange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily: 'Source Sans 3',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    BootstrapIcons.box_arrow_left,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  final String title;

  const _Separator({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 8,
        top: 24,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final VoidCallback onTap;

  const _Item({
    required this.title,
    this.subtitle,
    this.subtitleColor = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.adminPrimary1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: title,
                    style: const TextStyle(
                      fontFamily: 'Source Sans 3',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    children: [
                      if (subtitle != null) ...[
                        TextSpan(
                          text: '\n$subtitle',
                          style: TextStyle(
                            fontSize: 14,
                            color: subtitleColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            //
            const Icon(
              BootstrapIcons.chevron_right,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
