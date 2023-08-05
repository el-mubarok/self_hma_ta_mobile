import 'dart:ui';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../../../themes/color.dart';
import '../../../themes/themes.dart';
import '../../utils/helper/helper_common.dart';

class WidgetButton extends StatefulWidget {
  const WidgetButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isBigButton = false,
    this.width = double.infinity,
    this.height = AppTheme.buttonHeight,
    this.color = AppColors.primary,
    this.suffixIcon,
    this.prefixIcon,
    this.isDisabled = false,
    this.isLoading = false,
    this.iconOnly = false,
    this.icon,
    this.iconSize,
    this.fullRounded = true,
    this.fontSize,
    this.border,
  });

  final String label;
  final VoidCallback onTap;
  final bool isBigButton;
  final double width;
  final double? height;
  final Color color;
  final HeroIcons? suffixIcon;
  final HeroIcons? prefixIcon;
  final bool isDisabled;
  final bool isLoading;
  final bool iconOnly;
  final IconData? icon;
  final double? iconSize;
  final bool fullRounded;
  final double? fontSize;
  final BoxBorder? border;

  @override
  State<StatefulWidget> createState() => _WidgetButton();
}

class _WidgetButton extends State<WidgetButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: !widget.isBigButton ? widget.height : null,
      decoration: BoxDecoration(
        color: !widget.isDisabled && !widget.isLoading
            ? (widget.color).withOpacity(1)
            : (const Color(0xffD4D4D4)).withOpacity(1),
        borderRadius: BorderRadius.circular(
          // !widget.isBigButton ? AppTheme.inputButtonRadius : 64,
          !widget.isBigButton ? (widget.fullRounded ? 100 : 14) : 64,
        ),
        border: widget.border,
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: !widget.isDisabled && !widget.isLoading
            ? (widget.color).withOpacity(1)
            : (const Color(0xffD4D4D4)).withOpacity(1),
        borderRadius: BorderRadius.circular(
          // !widget.isBigButton ? AppTheme.inputButtonRadius : 64,
          !widget.isBigButton ? (widget.fullRounded ? 100 : 14) : 64,
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          highlightColor: !widget.isDisabled && !widget.isLoading
              ? null
              : AppColors.transparent,
          splashFactory: !widget.isDisabled && !widget.isLoading
              ? null
              : NoSplash.splashFactory,
          splashColor: widget.color, //const Color(0xffaffd7e),
          onTap: () {
            if (!widget.isDisabled) {
              widget.onTap();
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: !widget.isBigButton
                  ? AppTheme.buttonPaddingHorizontal
                  : AppTheme.defaultPadding,
              vertical: !widget.isBigButton
                  ? AppTheme.buttonPaddingVertical
                  : AppTheme.defaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //
                if (widget.isLoading)
                  Padding(
                    padding: EdgeInsets.only(right: widget.iconOnly ? 0 : 16),
                    child: SizedBox(
                      width: !widget.iconOnly ? 10 : widget.width / 2,
                      height: !widget.iconOnly ? 10 : widget.width / 2,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: !widget.iconOnly
                            ? 3
                            : widget.width - (widget.width - 6),
                        valueColor: AlwaysStoppedAnimation(
                          (widget.color).computeLuminance() >= 0.5
                              ? AppColors.black
                              : AppColors.white,
                        ),
                      ),
                    ),
                  ),

                if (widget.prefixIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                    ),
                    child: HeroIcon(
                      widget.prefixIcon ?? HeroIcons.academicCap,
                      color: (widget.color).computeLuminance() >= 0.5
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),

                if (widget.iconOnly) ...[
                  if (!widget.isLoading)
                    Icon(
                      widget.icon ?? BootstrapIcons.activity,
                      color:
                          AppHelperCommon().getColor(widget.color).withOpacity(
                                widget.isDisabled ? 0.5 : 1,
                              ),
                      size: widget.width / 2,
                    ),
                ] else ...[
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: (widget.color).computeLuminance() >= 0.5
                          ? (widget.isDisabled || widget.isLoading
                              ? AppColors.black.withOpacity(0.5)
                              : AppColors.black)
                          : AppColors.white,
                      fontSize:
                          !widget.isBigButton ? widget.fontSize ?? 16 : 16,
                    ),
                  ),
                ],
                //
                if (widget.suffixIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: HeroIcon(
                      widget.suffixIcon ?? HeroIcons.academicCap,
                      color: (widget.color).computeLuminance() >= 0.5
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
