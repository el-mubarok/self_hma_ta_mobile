import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/dashboard_module/bloc/admin_dashboard_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/dashboard_module/data/admin_dashboard_repository.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/dashboard_module/screens/_part_card.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/dashboard_module/screens/_part_card_active.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/dashboard_module/screens/_part_header.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_active.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/themes/color.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/ui/wrappers/wrapper_page.dart';

class ModuleAdminDashboard extends StatefulWidget {
  const ModuleAdminDashboard({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleAdminDashboard();
}

class _ModuleAdminDashboard extends State<ModuleAdminDashboard> {
  SharedBillingActive? summaryData;
  Map<String, dynamic>? summaryUser;
  DateFormat df = DateFormat('d MMM y').add_jm();

  String getLastUpdate() {
    var d = "";

    if (summaryUser?['last_update'] != null) {
      d = df.format(
        DateTime.parse(
          summaryUser?['last_update'] ?? '2023-02-20 12:00:00',
        ),
      );
    } else {
      d = 'no data';
    }

    return d;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminDashboardBloc(
        repository: AdminDashboardRepository(),
      )
        ..add(ADSummaryDataEvent())
        ..add(ADSummaryUserEvent()),
      child: WrapperPage(
        safeTop: true,
        hasPadding: false,
        statusBarColor: AppColors.adminPrimary.darken(0.01),
        backgroundColor: AppColors.adminPrimary,
        height: MediaQuery.of(context).size.height,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 16,
                ),
                child: ModuleAdminDashboardHeader(),
              ),
              //
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: BlocConsumer<AdminDashboardBloc, AdminDashboardState>(
                  listener: (context, state) {
                    if (state is ADSummaryData) {
                      setState(() {
                        summaryData = state.data;
                      });
                    }
                    if (state is ADSummaryUserData) {
                      setState(() {
                        summaryUser = state.data;
                      });
                    }
                  },
                  builder: (context, state) {
                    return summaryData != null
                        ? ModuleAdminDashCardActive(
                            data: summaryData,
                          )
                        : Container();
                  },
                ),
              ),
              //
              BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.adminBlue.darken(0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: ModuleAdminDashCard(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(
                            NamedRoute.moduleAdminUser,
                          )
                              .then((value) {
                            context.read<AdminDashboardBloc>().add(
                                  ADSummaryDataEvent(),
                                );
                            context.read<AdminDashboardBloc>().add(
                                  ADSummaryUserEvent(),
                                );
                          });
                        },
                        icon: BootstrapIcons.people,
                        backgroundIcon: BootstrapIcons.people_fill,
                        textTitle: 'Users',
                        textSubtitle: 'Registered',
                        textSubtitleValue:
                            summaryUser?['total'].toString().padLeft(2, '0') ??
                                '',
                        // textLastUpdate: 'Last update, 20 Oct 2023 12:22 AM',
                        textLastUpdate: 'Last update, ${getLastUpdate()}',
                      ),
                    ),
                  );
                },
              ),
              //
              // Container(
              //   margin: const EdgeInsets.only(bottom: 16),
              //   decoration: BoxDecoration(
              //     color: AppColors.adminPrimary2.darken(0.1),
              //     borderRadius: BorderRadius.circular(40),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 16),
              //     child: ModuleAdminDashCard(
              //       onTap: () {
              //         Navigator.of(context).pushNamed(
              //           NamedRoute.moduleAdminReport,
              //         );
              //       },
              //       background: AppColors.adminPrimary2,
              //       backgroundIcon: BootstrapIcons.clock_history,
              //       icon: BootstrapIcons.clock_history,
              //       textTitle: 'Payment history',
              //       textSubtitle: 'Recorded',
              //       textSubtitleValue: '21',
              //       textLastUpdate: 'Last record, 20 Oct 2023 12:22 AM',
              //     ),
              //   ),
              // ),
              //
              BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.adminPrimary1.darken(0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ModuleAdminDashCard(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(
                            NamedRoute.moduleAdminSetting,
                          )
                              .then((value) {
                            context.read<AdminDashboardBloc>().add(
                                  ADSummaryDataEvent(),
                                );
                            context.read<AdminDashboardBloc>().add(
                                  ADSummaryUserEvent(),
                                );
                          });
                        },
                        background: AppColors.adminPrimary1,
                        icon: BootstrapIcons.gear,
                        backgroundIcon: BootstrapIcons.gear_fill,
                        textTitle: 'Settings',
                        textSubtitle: 'Set payment reminder, logout from app',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
