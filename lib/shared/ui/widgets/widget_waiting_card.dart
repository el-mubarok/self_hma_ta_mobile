import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/config/constants.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_date_countdown.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:housing_management_mobile/themes/color.dart';
import 'package:intl/intl.dart';

import '../../models/shared_billing_payment_active.dart';

// ignore: must_be_immutable
class WidgetCardWaiting extends StatefulWidget {
  final SharedBillingPaymentActive? data;
  final VoidCallback onDone;

  WidgetCardWaiting({
    super.key,
    this.data,
    required this.onDone,
  });

  @override
  State<StatefulWidget> createState() => _WidgetCardWaiting();
}

class _WidgetCardWaiting extends State<WidgetCardWaiting> {
  NumberFormat currencyFormat = NumberFormat.simpleCurrency(
    locale: 'ID',
    decimalDigits: 0,
  );
  bool isExpired = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isExpired) ...[
          Container(
            height: 98,
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            decoration: const BoxDecoration(
              color: AppColors.adminYellowDark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.data?.data.statusVa != null) ...[
                  const Text(
                    'VA number',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${widget.data?.data.vaNumber}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Source Code Pro',
                      color: Colors.white,
                    ),
                  ),
                ],
                if (widget.data?.data.statusEwallet != null) ...[
                  const Text(
                    'Tap to pay',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
        //
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.adminYellow,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // left
              Row(
                children: [
                  // bank image
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: Image.asset(
                      AppConfigConstant
                          .paymentLogo[widget.data?.data.methodCode ?? 'BNI'],
                      width: 48,
                      height: 48,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Menunggu  pembayaran',
                      style: const TextStyle(
                        fontFamily: 'Source Sans 3',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              '\n${currencyFormat.format(int.parse(widget.data?.data.grandTotal ?? '0'))}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // right
              if (widget.data?.data.expiryDate != null) ...[
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.adminOrange,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  // child: const Text(
                  //   '00 Day, 20:23:11',
                  //   style: TextStyle(
                  //     fontSize: 9,
                  //     fontWeight: FontWeight.w700,
                  //     fontFamily: 'Source Code Pro',
                  //     color: Colors.white,
                  //   ),
                  // ),
                  child: WidgetCountDownText(
                    due: DateTime.parse(
                        widget.data?.data.expiryDate?.toIso8601String() ??
                            "2050-01-01 00:00:00"),
                    finishedText: "Expired",
                    showLabel: true,
                    longDateName: true,
                    daysTextLong: "Day, ",
                    hoursTextLong: ":",
                    minutesTextLong: ":",
                    secondsTextLong: "S",
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Source Code Pro',
                      color: Colors.white,
                    ),
                    onDone: () {
                      widget.onDone();
                      setState(() {
                        isExpired = true;
                      });
                      AppUtils.logD("Payment is expired");
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
