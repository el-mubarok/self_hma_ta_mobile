import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housing_management_mobile/config/assets.dart';
import 'package:housing_management_mobile/config/constants.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_payment_active.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/ui/widgets/widget_button.dart';
import '../../../../../shared/ui/wrappers/wrapper_page.dart';
import '../../../../../shared/utils/helper/helper_common.dart';
import '../../../../../themes/color.dart';

class ModuleUserPaymentProgress extends StatefulWidget {
  final SharedBillingPaymentActive? details;

  const ModuleUserPaymentProgress({
    super.key,
    this.details,
  });

  @override
  State<StatefulWidget> createState() => _ModuleUserPaymentProgress();
}

class _ModuleUserPaymentProgress extends State<ModuleUserPaymentProgress> {
  NumberFormat currencyFormat = NumberFormat.simpleCurrency(
    locale: 'ID',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      safeTop: true,
      hasPadding: false,
      statusBarColor: AppColors.adminOrange.darken(0.01),
      backgroundColor: AppColors.adminOrange,
      navigationBarColor: AppColors.adminOrange,
      height: MediaQuery.of(context).size.height,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -30,
              right: -350,
              child: Image.asset(AppAsset.paymentMaskRaw),
            ),
            Positioned(
              bottom: 100,
              left: -200,
              child: Image.asset(AppAsset.paymentMaskRaw),
            ),
            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(bottom: 24),
                          child: Icon(
                            BootstrapIcons.patch_check_fill,
                            color: Colors.white,
                            size: 92,
                          ),
                        ),
                        Text(
                          'Payment has been requested',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            fontFamily: 'Source Sans 3',
                          ),
                        ),
                      ],
                    ),
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: widget.details?.data.methodName ?? '',
                          style: const TextStyle(
                            fontFamily: 'Source Sans 3',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.05,
                            color: Colors.white,
                          ),
                          children: const [
                            TextSpan(
                              text: '\nVirtual Account',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Image.asset(
                          // AppAsset.paymentVaBcaSm,
                          AppConfigConstant.paymentLogo[
                              widget.details?.data.methodCode ?? 'BCA'],
                        ),
                      ),
                    ],
                  ),
                  //
                  const Padding(padding: EdgeInsets.only(bottom: 24)),
                  //
                  _Item(
                    itemKey: 'VA number',
                    itemValue: '${widget.details?.data.vaNumber}',
                    hasCopy: true,
                  ),
                  _Item(
                    itemKey: 'Total payment',
                    itemValue: currencyFormat.format(
                      int.parse(widget.details?.data.grandTotal ?? '0'),
                    ),
                  ),
                  _Item(
                    itemKey: 'Please pay before',
                    // itemValue: 'Sun, 20 Oct 2023 11:20:03',
                    itemValue: DateFormat().format(
                      DateTime.parse(
                        widget.details?.data.expiryDate?.toIso8601String() ??
                            DateTime.now()
                                .add(const Duration(days: 1))
                                .toIso8601String(),
                      ),
                    ),
                  ),
                  //
                  const Padding(padding: EdgeInsets.only(bottom: 24)),
                  //
                  WidgetButton(
                    fullRounded: false,
                    color: AppColors.adminOrange,
                    icon: BootstrapIcons.arrow_left_short,
                    label: 'Back to Home',
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        NamedRoute.moduleUserDashboard,
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String itemKey;
  final String itemValue;
  final bool hasCopy;

  const _Item({
    required this.itemKey,
    required this.itemValue,
    this.hasCopy = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (hasCopy) {
          Clipboard.setData(ClipboardData(text: itemValue)).then((value) {
            AppHelperCommon().showAlert(
              context: context,
              title: 'Copy info',
              content: '$itemKey copied!',
              okOnly: true,
              onTapOk: (c) {},
            );
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: itemKey,
                style: const TextStyle(
                  fontFamily: 'Source Sans 3',
                  fontSize: 16,
                  height: 1.25,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: '\n$itemValue',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // copy
            if (hasCopy) ...[
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(
                      BootstrapIcons.files,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Copy',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
