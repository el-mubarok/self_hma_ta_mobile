import 'package:flutter/material.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/shared/utils/helper/helper_common.dart';
import 'package:housing_management_mobile/themes/color.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';

class ModuleAdminDashCard extends StatefulWidget {
  final Color background;
  final IconData icon;
  final IconData backgroundIcon;
  final String textTitle;
  final String textSubtitle;
  final String? textSubtitleValue;
  final String? textLastUpdate;
  final VoidCallback onTap;

  const ModuleAdminDashCard({
    super.key,
    this.background = AppColors.adminBlue,
    required this.icon,
    required this.backgroundIcon,
    required this.textTitle,
    required this.textSubtitle,
    this.textSubtitleValue,
    this.textLastUpdate,
    required this.onTap,
  });

  @override
  State<StatefulWidget> createState() => _ModuleAdminDashCard();
}

class _ModuleAdminDashCard extends State<ModuleAdminDashCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 208,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: widget.background,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -12,
              right: -4,
              child: Transform.rotate(
                angle: 24.9,
                child: Icon(
                  widget.backgroundIcon,
                  size: 140,
                  color: widget.background.darken(0.05),
                ),
              ),
            ),
            //
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CornerIcon(
                        background: widget.background,
                        color: Colors.white,
                        icon: widget.icon,
                      ),
                      //
                      _DetailIcon(background: widget.background),
                    ],
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                    left: 24,
                    right: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          widget.textTitle,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: widget.textSubtitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          children: [
                            if (widget.textSubtitleValue != null) ...[
                              TextSpan(
                                text: ' ${widget.textSubtitleValue}\n',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                            if (widget.textLastUpdate != null) ...[
                              TextSpan(
                                text: widget.textLastUpdate,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CornerIcon extends StatelessWidget {
  final Color background;
  final Color color;
  final IconData icon;

  const _CornerIcon({
    required this.background,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: background.darken(0.06),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 18,
          color: AppHelperCommon().getColor(background.darken(0.06)),
        ),
      ),
    );
  }
}

class _DetailIcon extends StatelessWidget {
  final Color background;

  const _DetailIcon({required this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Icon(
          BootstrapIcons.arrow_right_short,
          color: AppHelperCommon().getColor(background),
          size: 32,
        ),
      ),
    );
  }
}
