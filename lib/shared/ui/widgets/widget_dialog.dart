import 'package:flutter/material.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';

import '../../../themes/color.dart';

class WidgetDialog extends StatefulWidget {
  const WidgetDialog({
    super.key,
    this.title,
    this.subtitle,
    this.content,
    this.onOk,
    this.okOnly = false,
  });

  final String? title;
  final String? subtitle;
  final String? content;
  final VoidCallback? onOk;
  final bool okOnly;

  @override
  State<StatefulWidget> createState() => _WidgetDialog();
}

class _WidgetDialog extends State<WidgetDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 100,
            maxHeight: 500,
          ),
          child: Container(
            clipBehavior: Clip.hardEdge,
            width: MediaQuery.of(context).size.width - 64,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // header
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.title ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      //
                      if (widget.subtitle != null)
                        Text(
                          widget.subtitle ?? "",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                    //
                  ),
                ),
                //
                const Divider(
                  color: AppColors.secondary,
                  thickness: 0.75,
                ),
                //
                // content
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.content ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                //
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!widget.okOnly)
                        _AlerButtonItem(
                          text: "Cancel",
                          onTap: () {
                            Navigator.pop(context);
                          },
                          darken: true,
                        ),
                      _AlerButtonItem(
                        text: "OK",
                        onTap: () {
                          widget.onOk!();
                          Navigator.pop(context);
                        },
                      ),
                    ],
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

class _AlerButtonItem extends StatelessWidget {
  const _AlerButtonItem({
    super.key,
    required this.text,
    required this.onTap,
    this.darken = false,
  });

  final String text;
  final VoidCallback onTap;
  final bool? darken;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            color: darken! ? AppColors.secondary.darken() : AppColors.secondary,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
