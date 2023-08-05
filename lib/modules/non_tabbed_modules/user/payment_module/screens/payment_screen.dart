import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/config/routes/routes.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/user/dashboard_module/data/user_dashboard_repository.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/user/payment_module/bloc/user_payment_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/user/payment_module/data/user_payment_repository.dart';
import 'package:housing_management_mobile/shared/models/payment/shared_payment_method_dummy.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_active.dart';
import 'package:housing_management_mobile/shared/models/shared_payment_calculate.dart';
import 'package:housing_management_mobile/shared/models/shared_payment_request_result.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_payment_card.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/shared/utils/utils_global.dart';
import 'package:housing_management_mobile/themes/color.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/data/payment.dart';
import '../../../../../shared/ui/widgets/widget_appbar.dart';
import '../../../../../shared/ui/widgets/widget_button.dart';
import '../../../../../shared/ui/wrappers/wrapper_page.dart';
import '../../../../../shared/utils/helper/helper_common.dart';
import '../../dashboard_module/bloc/user_dashboard_bloc.dart';

class ModuleUserPayment extends StatefulWidget {
  const ModuleUserPayment({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleUserPayment();
}

class _ModuleUserPayment extends State<ModuleUserPayment> {
  List<Map<String, dynamic>> vaData = [...AppDataPayment().methodDummyVa];
  List<Map<String, dynamic>> ewalletData = [
    ...AppDataPayment().methodDummyEwallet
  ];
  SharedPaymentMethodDummy? selected;
  bool toggleVa = true;
  bool toggleEwallet = true;
  double amount = 35000;
  SharedBillingActive? activeBilling;

  @override
  void initState() {
    super.initState();
  }

  void onVaChange(id, state) {
    // set for va
    for (var e in vaData) {
      if (e['id'] == id) {
        e['checked'] = state;
        if (state) {
          selected = SharedPaymentMethodDummy.fromJson(e);
        } else {
          selected = null;
        }
      } else {
        e['checked'] = false;
      }
    }
    // set ewallet to false
    for (var e in ewalletData) {
      e['checked'] = false;
    }

    setState(() {});
  }

  void onEwalletChange(id, state) {
    // set for ewallet
    for (var e in ewalletData) {
      if (e['id'] == id) {
        e['checked'] = state;
        if (state) {
          selected = SharedPaymentMethodDummy.fromJson(e);
        } else {
          selected = null;
        }
      } else {
        e['checked'] = false;
      }
    }
    // set va to false
    for (var e in vaData) {
      e['checked'] = false;
    }

    setState(() {});
  }

  void toggleViewVa() {
    setState(() {
      toggleVa = !toggleVa;
    });
  }

  void toggleViewEwallet() {
    setState(() {
      toggleEwallet = !toggleEwallet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserPaymentBloc(
            repository: UserPaymentRepository(),
            dashboardRepository: UserDashboardRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => UserDashboardBloc(
            repository: UserDashboardRepository(),
          )..add(UDActiveBillingDataEvent()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserDashboardBloc, UserDashboardState>(
            listener: (context, state) {
              if (state is UDActiveBillingData) {
                setState(() {
                  activeBilling = state.data;
                });
              }
            },
          ),
        ],
        child: WrapperPage(
          safeTop: true,
          hasPadding: false,
          appBar: WidgetAppBar(
            title: 'Payment',
            subtitle: 'Payment for this month',
            isUser: true,
            onTap: () => Navigator.pop(context),
          ),
          bottomNavigationBar: _BottomBar(
            selected: selected,
            amount: amount,
            billingActive: activeBilling,
          ),
          navigationBarColor: AppColors.adminOrange,
          statusBarColor: AppColors.adminOrange.darken(0.01),
          backgroundColor: AppColors.whiteDimm1,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: WidgetCardPayment(
                    data: activeBilling,
                    isPayment: true,
                    onTap: () {},
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _PaymentMethodWrapper(
                    recordList: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
                            onTap: () {
                              // do show hide
                            },
                            child: Row(
                              children: const [
                                Text('Bank Transfer'),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(
                                    BootstrapIcons.caret_up_fill,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //
                        BlocBuilder<UserPaymentBloc, UserPaymentState>(
                          builder: (context, state) {
                            return ListView.builder(
                              padding: const EdgeInsets.only(bottom: 16),
                              addAutomaticKeepAlives: false,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: vaData.length,
                              itemBuilder: (context, index) {
                                SharedPaymentMethodDummy paymentVa =
                                    SharedPaymentMethodDummy.fromJson(
                                  vaData[index],
                                );
                                return _MethodItem(
                                  title: paymentVa.label,
                                  selected: paymentVa.checked,
                                  logo: paymentVa.logo,
                                  isBottom: index == vaData.length - 1,
                                  onTap: () {
                                    onVaChange(
                                      paymentVa.id,
                                      !paymentVa.checked,
                                    );

                                    context.read<UserPaymentBloc>().add(
                                          UserPaymentCalculate(
                                            paymentVa.id.toString(),
                                            activeBilling?.data.price ?? '0',
                                          ),
                                        );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        //
                        //
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
                            onTap: () {
                              // do show hide
                            },
                            child: Row(
                              children: const [
                                Text('E-Wallet'),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(
                                    BootstrapIcons.caret_up_fill,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //
                        BlocBuilder<UserPaymentBloc, UserPaymentState>(
                          builder: (context, state) {
                            return ListView.builder(
                              addAutomaticKeepAlives: false,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: ewalletData.length,
                              itemBuilder: (context, index) {
                                SharedPaymentMethodDummy paymentEwallet =
                                    SharedPaymentMethodDummy.fromJson(
                                  ewalletData[index],
                                );
                                return _MethodItem(
                                  title: paymentEwallet.label,
                                  selected: paymentEwallet.checked,
                                  logo: paymentEwallet.logo,
                                  subtitle: paymentEwallet.message,
                                  isBottom: index == ewalletData.length - 1,
                                  onTap: () {
                                    onEwalletChange(
                                      paymentEwallet.id,
                                      !paymentEwallet.checked,
                                    );

                                    context.read<UserPaymentBloc>().add(
                                          UserPaymentCalculate(
                                            paymentEwallet.id.toString(),
                                            activeBilling?.data.price ?? '0',
                                          ),
                                        );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
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

class _PaymentMethodWrapper extends StatefulWidget {
  final Widget recordList;

  const _PaymentMethodWrapper({required this.recordList});

  @override
  State<StatefulWidget> createState() => _PaymentMethodWrapperState();
}

class _PaymentMethodWrapperState extends State<_PaymentMethodWrapper> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - (345 - 16),
      ),
      child: Container(
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
                  'Choose payment method',
                  style: TextStyle(
                    fontFamily: 'Source Sans 3',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  BootstrapIcons.cash_stack,
                  size: 18,
                  color: AppColors.adminPrimary,
                ),
              ],
            ),
            //
            const Padding(padding: EdgeInsets.only(bottom: 16)),
            //
            widget.recordList,
          ],
        ),
      ),
    );
  }
}

class _MethodItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool selected;
  final String logo;
  final VoidCallback onTap;
  final bool isBottom;

  const _MethodItem({
    required this.title,
    this.subtitle,
    this.selected = false,
    required this.logo,
    required this.onTap,
    this.isBottom = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: !isBottom ? 16 : 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.adminOrange.lighten(0.45),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? AppColors.adminOrange.withOpacity(1)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      logo,
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                  //
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: title,
                          style: const TextStyle(
                            fontFamily: 'Source Sans 3',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                            color: Colors.black,
                          ),
                          children: [
                            if (subtitle != null) ...[
                              TextSpan(
                                text: '\n$subtitle',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //
            Icon(
              selected ? BootstrapIcons.record_circle : BootstrapIcons.circle,
              color: AppColors.adminOrange,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _BottomBar extends StatelessWidget {
  final SharedPaymentMethodDummy? selected;
  final double amount;
  final SharedBillingActive? billingActive;

  _BottomBar({
    this.selected,
    required this.amount,
    this.billingActive,
  });

  NumberFormat currencyFormat = NumberFormat.simpleCurrency(
    locale: 'ID',
    decimalDigits: 0,
  );
  SharedPaymentCalculate? data;

  @override
  Widget build(BuildContext context) {
    double total = 0;
    String ppnTotal = '';
    String ppn = '';

    if (selected != null) {
      if (selected?.ppnPercentage == true) {
        var ppnTemp = ((selected?.ppn) * amount) / 100;
        total = ppnTemp + amount;

        ppn = '${selected?.ppn}%';
        ppnTotal = currencyFormat.format(ppnTemp);
      } else {
        total = amount + selected?.ppn;
        ppnTotal = currencyFormat.format(selected?.ppn);
      }
    }

    return Container(
      color: const Color(0xffF8F8F8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selected != null) ...[
            BlocBuilder<UserPaymentBloc, UserPaymentState>(
              builder: (context, state) {
                if (state is UPCalculateData) {
                  data = state.data;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: [
                      _SummaryItem(
                        left: 'Selected method',
                        right:
                            '${selected?.label}${selected?.labelAbbr != null ? ' (${selected?.labelAbbr})' : ''}',
                        // right: '${selected?.labelAbbr}',
                      ),
                      _SummaryItem(
                        left: (selected?.ppnPercentage ?? false)
                            ? 'ppn (${selected?.ppn}%)'
                            : 'Bank fee',
                        // right: ppnTotal,
                        right: currencyFormat.format(
                          int.parse(data?.data.ppn.toString() ?? '0'),
                        ),
                      ),
                      _SummaryItem(
                        left: 'Bill',
                        // right: currencyFormat.format(amount),
                        right: currencyFormat.format(
                          int.parse(data?.data.baseAmount.toString() ?? '0'),
                        ),
                      ),
                      Divider(
                        color: const Color(0xffF8F8F8).darken(0.05),
                      ),
                      _SummaryItem(
                        left: 'Total',
                        // right: currencyFormat.format(total),
                        right: currencyFormat.format(
                          int.parse((data?.data.amount.toString() ?? '0')),
                        ),
                        boldKey: true,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          //
          BlocConsumer<UserPaymentBloc, UserPaymentState>(
            listener: (context, state) {
              // va
              if (state is UPRequestVaSuccess) {
                // go to success page
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  NamedRoute.moduleUserPaymentProgress,
                  (route) => false,
                  arguments: RoutesArguments(
                    args1: state.data,
                  ),
                ).then((value) {
                  AppUtilsGlobal().reloadUserDashboard.value = true;
                });
                // Navigator.pushNamed(
                //   context,
                //   NamedRoute.moduleUserPaymentProgress,
                //   arguments: RoutesArguments(
                //     args1: state.data,
                //   ),
                // );
              }
              // ewallet
              else if (state is UPRequestEwalletSuccess) {
                SharedPaymentRequestResult? result = state.data;

                Navigator.pushNamed(
                  context,
                  NamedRoute.moduleWebview,
                  arguments: RoutesArguments(
                    args1: result?.data.actions?.checkoutUrl ??
                        'https://google.com',
                  ),
                ).then((value) {
                  AppUtilsGlobal().reloadUserDashboard.value = true;
                });
              }
              // failed
              else if (state is UPRequestFailed) {
                AppHelperCommon().showAlert(
                  context: context,
                  title: 'Error',
                  content:
                      'Cannot use this method, please choose another method',
                  onTapOk: (contextAlert) {},
                );
              }
            },
            builder: (context, state) {
              return WidgetButton(
                fullRounded: false,
                color: AppColors.adminOrange,
                isLoading: state is UPRequestLoading,
                label: selected == null || selected?.isActive == false
                    ? 'Choose Payment Method'
                    : 'Confirm Payment',
                isDisabled: selected == null || selected?.isActive == false,
                onTap: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   NamedRoute.moduleUserPaymentProgress,
                  // );
                  context.read<UserPaymentBloc>().add(
                        UserPaymentRequestEvent(
                          amount: data?.data.amount.toString() ?? '',
                          baseAmount: data?.data.baseAmount.toString() ?? '',
                          billingSessionId: billingActive?.data.id ?? '',
                          paymentMethodId: selected?.id.toString() ?? '',
                          phoneNumber: '',
                        ),
                      );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String left;
  final String right;
  final bool boldKey;

  const _SummaryItem({
    required this.left,
    required this.right,
    this.boldKey = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: const TextStyle(
            fontFamily: 'Source Sans 3',
            fontSize: 12,
          ),
        ),
        Text(
          right,
          style: TextStyle(
            fontFamily: 'Source Sans 3',
            fontSize: 12,
            fontWeight: boldKey ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
