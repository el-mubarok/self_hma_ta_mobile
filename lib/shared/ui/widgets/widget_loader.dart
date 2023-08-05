import 'package:flutter/material.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/themes/color.dart';

class WidgetLoader extends StatelessWidget {
  final Color backgroundColor;
  final Color strokeColor;
  final double width;
  final double height;
  final double strokeWidth;

  const WidgetLoader({
    super.key,
    this.backgroundColor = AppColors.adminPrimary2,
    this.strokeColor = AppColors.adminOrange,
    this.width = 24,
    this.height = 24,
    this.strokeWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation(
          strokeColor,
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
