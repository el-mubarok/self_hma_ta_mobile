import 'package:flutter/material.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/shared/utils/helper/helper_common.dart';
import 'package:housing_management_mobile/themes/color.dart';

class WidgetItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? image;
  final String? imageText;
  final bool smallImageText;
  final String? statusText;
  final Color statusColor;
  final bool disabled;
  final VoidCallback? onTap;
  final bool hasAvatar;
  final bool hasStatus;

  const WidgetItemCard({
    super.key,
    this.title = '',
    this.subtitle = '',
    this.image,
    this.imageText,
    this.smallImageText = false,
    this.statusText,
    this.statusColor = AppColors.adminLime,
    this.disabled = false,
    this.onTap,
    this.hasAvatar = true,
    this.hasStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Opacity(
        opacity: disabled ? 0.5 : 1,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(
            top: 16,
            right: 16,
            bottom: 16,
            left: 10,
          ),
          decoration: BoxDecoration(
            color: AppColors.adminPrimary1,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              // avatar
              if (image != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    image!,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ] else ...[
                if (hasAvatar) ...[
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        imageText ?? '',
                        style: TextStyle(
                          fontSize: !smallImageText ? 22 : 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
              //
              const Padding(padding: EdgeInsets.only(right: 16)),
              // title & subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Source Sans 3',
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Source Sans 3',
                        fontWeight: FontWeight.normal,
                        height: 1.25,
                        overflow: TextOverflow.fade,
                      ),
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
              // status
              if (hasStatus) ...[
                SizedBox(
                  height: 48,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Text(
                          statusText ?? '',
                          style: TextStyle(
                            fontFamily: 'Source Sans 3',
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppHelperCommon().getColor(statusColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
