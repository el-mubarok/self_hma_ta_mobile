import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/config/routes/routes.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/user/dashboard_module/bloc/user_dashboard_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/user/dashboard_module/data/user_dashboard_repository.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_active.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_payment_active.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_payment_card.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/shared/utils/extension/extension_string_caiptalize.dart';
import 'package:housing_management_mobile/shared/utils/helper/helper_common.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:housing_management_mobile/shared/utils/utils_global.dart';
import 'package:housing_management_mobile/themes/color.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../shared/models/shared_payment_user_history.dart';
import '../../../../../shared/ui/widgets/widget_waiting_card.dart';
import '../../../../../shared/ui/wrappers/wrapper_page.dart';
import '_part_header.dart';

class ModuleUserDashboard extends StatefulWidget {
  const ModuleUserDashboard({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleUserDashboard();
}

class _ModuleUserDashboard extends State<ModuleUserDashboard> {
  SharedBillingActive? activeBilling;
  SharedBillingPaymentActive? activePayment;
  SharedPaymentUserHistory? historyData;

  NumberFormat currencyFormat = NumberFormat.simpleCurrency(
    locale: 'ID',
    decimalDigits: 0,
  );
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    AppUtils.logD("init state");
    activeBilling = null;
  }

  void reloadData(BuildContext context) {
    context.read<UserDashboardBloc>()
      ..add(UDActiveBillingDataEvent())
      ..add(UDActivePaymentDataEvent())
      ..add(UDHistoryList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDashboardBloc(
        repository: UserDashboardRepository(),
      )
        ..add(UDActiveBillingDataEvent())
        ..add(UDActivePaymentDataEvent())
        ..add(UDHistoryList()),
      child: WrapperPage(
        safeTop: true,
        hasPadding: false,
        scrollable: false,
        statusBarColor: AppColors.whiteDimm1.darken(0.01),
        navigationBarColor: AppColors.whiteDimm1.darken(0.01),
        backgroundColor: AppColors.whiteDimm1,
        height: MediaQuery.of(context).size.height,
        child: SmartRefresher(
          enablePullDown: true,
          header: const MaterialClassicHeader(),
          controller: refreshController,
          onRefresh: () async {
            AppUtilsGlobal().reloadUserDashboard.value = true;
          },
          // child: Container(
          //   padding: const EdgeInsets.only(
          //     top: 16,
          //   ),
          //   child:
          // ),
          child: ListView(
            children: [
              Column(
                children: [
                  BlocBuilder<UserDashboardBloc, UserDashboardState>(
                    builder: (context, state) {
                      return ValueListenableBuilder(
                        valueListenable: AppUtilsGlobal().reloadUserDashboard,
                        builder: (context, value, child) {
                          if (value) {
                            AppUtils.logD("dashboard reload: $value");
                            reloadData(context);
                            AppUtilsGlobal().reloadUserDashboard.value = false;
                          }
                          return Container();
                        },
                      );
                    },
                  ),
                  //
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: ModuleUserDashboardHeader(),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 16,
                    ),
                    child: BlocConsumer<UserDashboardBloc, UserDashboardState>(
                      listener: (context, state) {
                        if (state is UDActiveBillingData) {
                          setState(() {
                            activeBilling = state.data;
                          });
                          refreshController.refreshCompleted();
                        }

                        if (state is UDCrossChecked) {
                          AppHelperCommon().showAlert(
                            context: context,
                            title: 'Reload data..',
                            onTapOk: () {},
                          );
                        }
                      },
                      builder: (context, state) {
                        return WidgetCardPayment(
                          data: activeBilling,
                          isPayment: activePayment != null ||
                              (activeBilling?.data.isPaid ?? false),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              NamedRoute.moduleUserPayment,
                            ).then((value) {
                              reloadData(context);
                            });
                          },
                        );
                      },
                    ),
                  ),
                  //
                  // WidgetButton(
                  //   label: 'Test Webview',
                  //   fullRounded: false,
                  //   onTap: () {
                  //     Navigator.pushNamed(
                  //       context,
                  //       NamedRoute.moduleWebview,
                  //       arguments: RoutesArguments(
                  //         args1: AppConfigConstant.successUrl,
                  //       ),
                  //     );
                  //   },
                  // ),
                  //
                  BlocConsumer<UserDashboardBloc, UserDashboardState>(
                    listener: (context, state) {
                      if (state is UDActivePaymentData) {
                        setState(() {
                          activePayment = state.data;
                        });
                      }
                    },
                    builder: (context, state) {
                      return activePayment != null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 16,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (activePayment?.data.paymentActions !=
                                      null) {
                                    switch (activePayment?.data.methodCode) {
                                      case 'ID_DANA':
                                        Navigator.pushNamed(
                                          context,
                                          NamedRoute.moduleWebview,
                                          arguments: RoutesArguments(
                                            args1: activePayment
                                                    ?.data
                                                    .paymentActions
                                                    ?.mobileWebCheckoutUrl ??
                                                'https://google.com',
                                          ),
                                        ).then((value) {
                                          reloadData(context);
                                        });
                                        break;
                                      case 'ID_OVO':
                                        Navigator.pushNamed(
                                          context,
                                          NamedRoute.moduleWebview,
                                          arguments: RoutesArguments(
                                            args1: activePayment
                                                    ?.data
                                                    .paymentActions
                                                    ?.mobileWebCheckoutUrl ??
                                                'https://google.com',
                                          ),
                                        );
                                        break;
                                      case 'ID_LINKAJA':
                                        Navigator.pushNamed(
                                          context,
                                          NamedRoute.moduleWebview,
                                          arguments: RoutesArguments(
                                            args1: activePayment
                                                    ?.data
                                                    .paymentActions
                                                    ?.mobileWebCheckoutUrl ??
                                                'https://google.com',
                                          ),
                                        ).then((value) {
                                          reloadData(context);
                                        });
                                        break;
                                    }
                                  }
                                },
                                child: WidgetCardWaiting(
                                  data: activePayment,
                                ),
                              ),
                            )
                          : Container();
                    },
                  ),
                  //
                  BlocConsumer<UserDashboardBloc, UserDashboardState>(
                    listener: (context, state) {
                      if (state is UDHistoryData) {
                        setState(() {
                          historyData = state.data;
                        });
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: _RecordWrapper(
                          recordList: Column(
                            children: [
                              ListView.builder(
                                addAutomaticKeepAlives: false,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: historyData?.data.length ?? 0,
                                itemBuilder: (context, index) {
                                  var d = historyData?.data[index];
                                  var time = DateFormat().format(
                                    d?.updatedAt ?? DateTime.now(),
                                  );
                                  var p = currencyFormat.format(
                                    int.parse(
                                      d?.grandTotal ?? '0',
                                    ),
                                  );
                                  return _RecordItem(
                                    title: d?.name
                                            .toString()
                                            .toCapitalizeEachWordCase() ??
                                        '',
                                    subtitle: time,
                                    rightValue: p,
                                  );
                                },
                              ),
                              // _RecordItem(
                              //   title: 'Monthly bill',
                              //   subtitle: 'Sun, 19 Nov 2023 08:01:22',
                              //   rightValue: 'Rp35.000',
                              // ),
                              // _RecordItem(
                              //   title: 'Monthly bill',
                              //   subtitle: 'Sun, 19 Nov 2023 08:01:22',
                              //   rightValue: 'Rp35.000',
                              // ),
                              // _RecordItem(
                              //   title: 'Monthly bill',
                              //   subtitle: 'Sun, 19 Nov 2023 08:01:22',
                              //   rightValue: 'Rp35.000',
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecordWrapper extends StatefulWidget {
  final Widget recordList;

  const _RecordWrapper({required this.recordList});

  @override
  State<StatefulWidget> createState() => _RecordWrapperState();
}

class _RecordWrapperState extends State<_RecordWrapper> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - (345 - 16) - 1,
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
                  'Payment history',
                  style: TextStyle(
                    fontFamily: 'Source Sans 3',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  BootstrapIcons.clock_history,
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

class _RecordItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String rightValue;

  const _RecordItem({
    required this.title,
    required this.subtitle,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF4F4F4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                    TextSpan(
                      text: '\n$subtitle',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //
          Text(
            rightValue,
            style: const TextStyle(
              color: AppColors.adminOrange,
              fontFamily: 'Source Sans 3',
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
