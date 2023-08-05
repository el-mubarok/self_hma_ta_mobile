import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/config/assets.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_active.dart';
import 'package:housing_management_mobile/shared/utils/extension/extension_string_caiptalize.dart';
import 'package:housing_management_mobile/themes/color.dart';
import 'package:intl/intl.dart';

class WidgetCardPayment extends StatefulWidget {
  final VoidCallback onTap;
  final bool isPayment;
  final SharedBillingActive? data;

  const WidgetCardPayment({
    super.key,
    required this.onTap,
    this.isPayment = false,
    this.data,
  });

  @override
  State<StatefulWidget> createState() => _WidgetCardPayment();
}

class _WidgetCardPayment extends State<WidgetCardPayment> {
  NumberFormat currencyFormat = NumberFormat.simpleCurrency(
    locale: 'ID',
    decimalDigits: 0,
  );

  String payBefore(DateTime? from, DateTime? to) {
    // 19 - 20 Oct 2023
    var dFrom = DateFormat('d').format(from ?? DateTime.now());
    var dTo = DateFormat('d').format(to ?? DateTime.now());
    var month = DateFormat('MMM').format(to ?? DateTime.now());
    var year = DateFormat('y').format(to ?? DateTime.now());

    return '$dFrom - $dTo $month $year';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isPayment) {
          widget.onTap();
        }
      },
      child: Container(
        height: 178,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.adminOrange,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffD5482C).withOpacity(0.15),
              offset: const Offset(0, 25),
              blurRadius: 25,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Image.asset(
              AppAsset.paymentMask,
            ),
            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          // text: 'This Month Bill',
                          "${widget.data?.data.name.toCapitalizeEachWordCase()}",
                          maxLines: 2,
                          style: const TextStyle(
                            fontFamily: 'Source Sans 3',
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            height: 1.25,
                            color: Color(0xffFFA796),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          !(widget.data?.data.isPaid ?? false)
                              ? currencyFormat.format(
                                  int.parse(widget.data?.data.price ?? '0'))
                              : 'Bill Paid',
                          style: const TextStyle(
                            fontFamily: 'Source Sans 3',
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!widget.isPayment) ...[
                        const Text(
                          'Tap to pay',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Source Sans 3',
                            color: Colors.white,
                          ),
                        ),
                        const Icon(
                          BootstrapIcons.caret_right_fill,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            //
            Positioned(
              bottom: 16,
              left: 16,
              child: RichText(
                text: TextSpan(
                  text: 'Pay before: ',
                  style: TextStyle(
                    fontFamily: 'Source Sans 3',
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      // text: '19 - 20 Oct 2023',
                      text: payBefore(
                        widget.data?.data.fromDate,
                        widget.data?.data.toDate,
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            const Positioned(
              right: 16,
              top: 16,
              child: Text(
                'Mentari Village',
                style: TextStyle(
                  fontFamily: 'Source Sans 3',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
