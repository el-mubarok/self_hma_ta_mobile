import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_appbar.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_input.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_item_card.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/themes/color.dart';

import '../../../../../shared/ui/wrappers/wrapper_page.dart';

class ModuleAdminReportDetail extends StatefulWidget {
  const ModuleAdminReportDetail({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleAdminReportDetail();
}

class _ModuleAdminReportDetail extends State<ModuleAdminReportDetail> {
  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      safeTop: true,
      hasPadding: false,
      statusBarColor: AppColors.adminPrimary.darken(0.01),
      backgroundColor: AppColors.adminPrimary,
      height: MediaQuery.of(context).size.height,
      appBar: WidgetAppBar(
        title: 'Payment Details',
        subtitle: 'Sub, 20 Jan 2023',
        onTap: () => Navigator.pop(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _InfoItem(label: 'Fee amount', value: 'Rp 3.000'),
                _InfoItem(label: 'Number of users', value: '30 of 30'),
                _InfoItem(label: 'Fees collected', value: 'Rp 90.000'),
              ],
            ),
          ),
          // list of record
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - (101 + 80),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height - (101 + 80),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Payment Records',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '30',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.adminBlue,
                        ),
                      ),
                    ],
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 16),
                    child: WidgetInput(
                      hint: 'Search for user',
                      hasPadding: false,
                      hasBorder: false,
                      hasBottomMargin: false,
                      suffixIcon: BootstrapIcons.search,
                      fillColor: AppColors.adminPrimary2,
                      type: TextInputType.text,
                      onChanged: (v) => {},
                    ),
                  ),
                  //
                  const _RecordItem(
                    name: 'Adriana Hufferboard',
                    date: '20 Jan 2023 12:22:10 - a month ago',
                    paymentMethod: 'BCA',
                  ),
                  const _RecordItem(
                    name: 'Josh Gruffman',
                    date: '13 Oct 2023 08:11:09 - yesterday',
                    paymentMethod: 'DANA',
                    hasBottomBorder: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  double fontSize = 16;

  _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Source Sans 3',
            fontSize: fontSize,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: 'Source Sans 3',
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}

class _RecordItem extends StatelessWidget {
  final String name;
  final String date;
  final String paymentMethod;
  final bool hasBottomBorder;

  const _RecordItem({
    required this.name,
    required this.date,
    required this.paymentMethod,
    this.hasBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: hasBottomBorder
              ? const BorderSide(
                  color: Color(0xffDFDFDF),
                  width: 0.5,
                )
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              RichText(
                text: TextSpan(
                  text: '$name\n',
                  style: const TextStyle(
                    fontFamily: 'Source Sans 3',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.adminPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: date,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6D6D6D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            paymentMethod,
            style: const TextStyle(
              fontFamily: 'Source Sans 3',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.adminPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
