import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_active.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/themes/color.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/utils/helper/helper_common.dart';

class ModuleAdminDashCardActive extends StatefulWidget {
  final SharedBillingActive? data;

  const ModuleAdminDashCardActive({
    super.key,
    this.data,
  });

  @override
  State<StatefulWidget> createState() => _ModuleAdminDashCardActive();
}

class _ModuleAdminDashCardActive extends State<ModuleAdminDashCardActive> {
  DateFormat df = DateFormat('d MMMM y');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 208,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.adminLime,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _CornerIcon(
                background: AppColors.adminLime,
                icon: BootstrapIcons.cash,
              ),
              Text(
                // 'Since yesterday',
                'Since ${AppHelperCommon().getTimeago(
                  widget.data?.data.fromDate,
                )}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.adminPrimary,
                ),
              ),
            ],
          ),
          //
          _CenterContent(
            data: widget.data,
          ),
          //
          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'End: ',
                    style: const TextStyle(
                      color: AppColors.adminPrimary,
                    ),
                    children: [
                      TextSpan(
                        // text: '20 Oct 2023',
                        text: df.format(
                          widget.data?.data.toDate ?? DateTime.now(),
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                //
                // const Icon(
                //   BootstrapIcons.arrow_right,
                //   size: 28,
                //   color: AppColors.adminPrimary,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CornerIcon extends StatelessWidget {
  final Color background;
  final IconData icon;

  const _CornerIcon({
    required this.background,
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

class _CenterContent extends StatelessWidget {
  final SharedBillingActive? data;

  const _CenterContent({this.data});

  String getProgress() {
    return "${data?.data.paymentProgress}% ";
  }

  String getProgressRest() {
    dynamic progress = data?.data.paymentProgress ?? 0;
    dynamic rest = 100 - progress;
    return "$rest%";
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        // text: '20% ',
        text: getProgress(),
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.adminPrimary,
        ),
        children: [
          const TextSpan(
            text: 'have paid\n',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: '${getProgressRest()} users have not paid',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
