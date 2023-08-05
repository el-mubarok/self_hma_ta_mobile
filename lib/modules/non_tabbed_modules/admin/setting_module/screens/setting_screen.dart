import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_appbar.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/themes/color.dart';

import '../../../../../shared/ui/wrappers/wrapper_page.dart';
import '../../../../../shared/utils/helper/helper_storage.dart';

class ModuleAdminSetting extends StatefulWidget {
  const ModuleAdminSetting({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleAdminSetting();
}

class _ModuleAdminSetting extends State<ModuleAdminSetting> {
  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      safeTop: true,
      hasPadding: false,
      statusBarColor: AppColors.adminPrimary.darken(0.01),
      backgroundColor: AppColors.adminPrimary,
      height: MediaQuery.of(context).size.height,
      appBar: WidgetAppBar(
        title: 'Settings',
        onTap: () => Navigator.pop(context),
      ),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: Column(
          children: [
            _Item(
              title: 'Billing Schedule',
              subtitle: 'Manage billing schedule time',
              // subtitle: 'Every 14th - 16th',
              subtitleColor: AppColors.adminLime,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  NamedRoute.moduleAdminSettingSchedule,
                );
              },
            ),
            //
            GestureDetector(
              onTap: () async {
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
