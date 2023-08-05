import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/config/assets.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/themes/color.dart';

class WidgetAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isUser;

  const WidgetAppBar({
    super.key,
    required this.title,
    this.subtitle = '',
    this.onTap,
    this.isUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: !isUser ? Colors.transparent : AppColors.adminOrange,
      child: Stack(
        children: [
          if (isUser) ...[
            Positioned(
              right: -10,
              bottom: -60,
              child: Image.asset(
                AppAsset.paymentMask,
                width: 328,
                height: 177.85,
                fit: BoxFit.cover,
              ),
            ),
          ],
          //
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isUser
                          ? AppColors.adminOrange.darken(0.05)
                          : AppColors.adminPrimary2,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      BootstrapIcons.arrow_left_short,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                //
                RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    text: '$title${subtitle.isNotEmpty ? '\n' : ''}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: subtitle,
                        style: const TextStyle(
                          fontFamily: 'Source Sans 3',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
