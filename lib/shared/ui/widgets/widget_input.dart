import 'dart:ui';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:housing_management_mobile/shared/utils/helper/helper_common.dart';

import '../../../themes/color.dart';

class WidgetInput extends StatefulWidget {
  WidgetInput({
    Key? key,
    required this.hint,
    this.label,
    this.labelColor = Colors.black,
    required this.type,
    required this.onChanged,
    VoidCallback? onFocused,
    this.readOnly = false,
    this.hasError = false,
    this.errorMessage = "",
    this.hasPadding = true,
    this.isPrice = false,
    this.isTextArea = false,
    this.initialValue,
    this.textController,
    this.keyValue,
    this.icon,
    this.suffixIcon,
    this.hasClearButton = false,
    this.onClearButton,
    this.isRequired = false,
    this.isPassword = false,
    this.textInputAction,
    this.fillColor = AppColors.white,
    this.hasBottomMargin = true,
    this.hasBorder = true,
    this.notes,
    this.notesColor = Colors.black,
  })  : onFocused = onFocused ?? (() {}),
        super(key: key);

  final String hint;
  final String? label;
  final Color? labelColor;
  final TextInputType type;
  final ValueChanged<String> onChanged;
  final VoidCallback onFocused;
  final bool readOnly;
  final bool hasError;
  final String errorMessage;
  final bool hasPadding;
  final bool isPrice;
  final bool isTextArea;
  final String? initialValue;
  final TextEditingController? textController;
  final String? keyValue;
  final HeroIcons? icon;
  final IconData? suffixIcon;
  final bool hasClearButton;
  final VoidCallback? onClearButton;
  final bool isRequired;
  final bool isPassword;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final bool hasBottomMargin;
  final bool hasBorder;
  final String? notes;
  final Color notesColor;

  @override
  State<StatefulWidget> createState() => _WidgetInput();
}

class _WidgetInput extends State<WidgetInput> {
  TextEditingController textController = TextEditingController();
  bool isError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.hasPadding
          ? const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            )
          : null,
      margin: EdgeInsets.only(bottom: widget.hasBottomMargin ? 16 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.label != null
              ? Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    "${widget.label}${widget.isRequired ? '*' : ''}",
                    style: TextStyle(
                      color: widget.isRequired &&
                              (widget.textController?.text ?? "").isEmpty
                          ? AppColors.primary
                          : widget.labelColor,
                      fontSize: 16,
                    ),
                  ),
                )
              : Container(),
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: AppColors.primary,
              ),
              textSelectionTheme: const TextSelectionThemeData(
                selectionColor: AppColors.adminBlue,
                selectionHandleColor: AppColors.adminBlue,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  // height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: widget.fillColor,
                    ),
                  ),
                ),
                TextFormField(
                  controller: widget.textController,
                  textInputAction: widget.isTextArea
                      ? TextInputAction.newline
                      : widget.textInputAction,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: AppHelperCommon().getColor(
                      widget.fillColor ?? AppColors.adminPrimary,
                    ),
                  ),
                  validator: (value) {
                    return widget.isRequired
                        ? (value == null || value.isEmpty ? "" : null)
                        : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: widget.isTextArea ? 16 : 12,
                      horizontal: widget.hasClearButton ? 16 : 16,
                    ),
                    labelText: widget.hint,
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      // color: Colors.black45,
                      color: AppHelperCommon()
                          .getColor(
                            widget.fillColor ?? AppColors.adminPrimary,
                          )
                          .withOpacity(0.55),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      // color: Colors.black45,
                      color: AppHelperCommon().getColor(
                        widget.fillColor ?? AppColors.adminPrimary,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: widget.hasBorder
                            ? Color(0xffC6C6C6)
                            : Colors.transparent,
                      ),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: widget.hasBorder
                            ? Color(0xffC6C6C6)
                            : Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: widget.hasBorder
                            ? Color(0xffC6C6C6)
                            : Colors.transparent,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    errorStyle: const TextStyle(
                      height: 0,
                    ),
                    fillColor: widget.fillColor ?? AppColors.adminPrimary,
                    prefixIcon: widget.icon != null
                        ? Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                            ),
                            child: HeroIcon(
                              widget.icon ?? HeroIcons.academicCap,
                              size: 28,
                              style: HeroIconStyle.solid,
                              color: AppColors.black,
                            ),
                          )
                        : null,
                    prefixIconConstraints: const BoxConstraints(
                      minHeight: 16,
                    ),
                    // xCircle
                    suffixIcon: widget.hasClearButton
                        ? GestureDetector(
                            onTap: () {
                              widget.textController?.clear();
                              widget.onClearButton!();
                            },
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColors.transparent,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              margin: const EdgeInsets.only(
                                left: 0,
                                right: 8,
                              ),
                              child: const HeroIcon(
                                HeroIcons.xCircle,
                                size: 28,
                                style: HeroIconStyle.solid,
                                color: AppColors.black,
                              ),
                            ),
                          )
                        : widget.suffixIcon != null
                            ? Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: AppColors.transparent,
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                margin: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                child: Icon(
                                  widget.suffixIcon ?? BootstrapIcons.activity,
                                  size: 18,
                                  color: AppHelperCommon().getColor(
                                    widget.fillColor ?? AppColors.adminPrimary,
                                  ),
                                ),
                              )
                            : null,
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 16,
                    ),
                  ),
                  keyboardType: widget.type,
                  minLines: widget.isTextArea ? 2 : 1,
                  maxLines: widget.isTextArea ? 8 : 1,
                  onChanged: (String value) {
                    // widget.onChanged(value);
                    EasyDebounce.debounce(
                      widget.keyValue ?? "text-input-tag",
                      const Duration(milliseconds: 0),
                      () {
                        widget.onChanged(value);
                      },
                    );
                  },
                  readOnly: widget.readOnly,
                  showCursor: widget.readOnly ? false : true,
                  cursorColor: AppColors.adminBlue,
                  obscureText: widget.isPassword,
                  onTap: () {
                    widget.onFocused();
                  },
                ),
              ],
            ),
          ),
          //
          if (widget.hasError) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 14,
                    color: Colors.red,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                  ),
                  Text(
                    widget.errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
          //
          if (widget.notes != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    BootstrapIcons.info_circle,
                    size: 14,
                    color: widget.notesColor,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                  ),
                  Text(
                    widget.notes ?? '',
                    style: TextStyle(
                      color: widget.notesColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
