import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/report_module/bloc/admin_report_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/report_module/data/admin_setting_repository.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/setting_module/bloc/admin_setting_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/setting_module/data/admin_setting_repository.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_list_data.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_appbar.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_button.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_input.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_item_card.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/themes/color.dart';

import '../../../../../shared/ui/wrappers/wrapper_page.dart';

class ModuleAdminReport extends StatefulWidget {
  const ModuleAdminReport({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleAdminReport();
}

class _ModuleAdminReport extends State<ModuleAdminReport> {
  SharedBillingListData? billingListData;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // report
        BlocProvider(
          create: (context) => AdminReportBloc(
            repository: AdminReportRepository(),
          ),
        ),
        // setting
        BlocProvider(
          create: (context) => AdminSettingBloc(
            repository: AdminSettingRepository(),
          )..add(const AdminSettingSessionList()),
        ),
      ],
      child: WrapperPage(
        safeTop: true,
        hasPadding: false,
        statusBarColor: AppColors.adminPrimary.darken(0.01),
        backgroundColor: AppColors.adminPrimary,
        height: MediaQuery.of(context).size.height,
        appBar: WidgetAppBar(
          title: 'Payment History',
          onTap: () => Navigator.pop(context),
        ),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(
            top: 8,
            right: 16,
            bottom: 16,
            left: 16,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: WidgetInput(
                  hint: 'Filter by date',
                  hasPadding: false,
                  hasBorder: false,
                  suffixIcon: BootstrapIcons.calendar2_week,
                  fillColor: AppColors.adminPrimary2,
                  type: TextInputType.text,
                  onChanged: (v) => {},
                ),
              ),
              //
              BlocConsumer<AdminSettingBloc, AdminSettingState>(
                listener: (context, state) {
                  if (state is ASListState) {
                    billingListData = state.data;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: billingListData?.data.length ?? 0,
                    addAutomaticKeepAlives: false,
                    itemBuilder: (context, index) {
                      return WidgetItemCard(
                        title: 'Sun, 20 Jan 2023',
                        subtitle: 'Completion 100% - two years ago',
                        imageText: '100%',
                        smallImageText: true,
                        hasStatus: false,
                        // statusText: 'Finished',
                        // statusColor: AppColors.adminLime,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            NamedRoute.moduleAdminReportDetail,
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
    );
  }
}
