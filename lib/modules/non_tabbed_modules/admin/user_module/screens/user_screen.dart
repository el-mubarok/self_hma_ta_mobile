import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/config/routes/routes.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/user_module/bloc/admin_user_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/user_module/data/admin_user_repository.dart';
import 'package:housing_management_mobile/shared/models/shared_list_user_data.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_appbar.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_button.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_input.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_item_card.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/shared/utils/extension/extension_string_caiptalize.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:housing_management_mobile/themes/color.dart';

import '../../../../../shared/ui/wrappers/wrapper_page.dart';

class ModuleAdminUser extends StatefulWidget {
  const ModuleAdminUser({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleAdminUser();
}

class _ModuleAdminUser extends State<ModuleAdminUser> {
  SharedUserListData? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminUserBloc(
        repository: AdminUserRepository(),
      )..add(AdminUserEventListUser()),
      child: WrapperPage(
        safeTop: true,
        hasPadding: false,
        statusBarColor: AppColors.adminPrimary.darken(0.01),
        backgroundColor: AppColors.adminPrimary,
        height: MediaQuery.of(context).size.height,
        appBar: WidgetAppBar(
          title: 'Manage Users',
          // subtitle: 'Add/remove/edit user data',
          onTap: () => Navigator.pop(context),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AdminUserBloc, AdminUserState>(
            builder: (context, state) {
              return WidgetButton(
                fullRounded: false,
                color: AppColors.adminOrange,
                label: 'Create a New User',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    NamedRoute.moduleAdminUserForm,
                  ).then((value) {
                    AppUtils.logD("back to user screen");
                    context.read<AdminUserBloc>().add(
                          AdminUserEventListUser(),
                        );
                  });
                },
              );
            },
          ),
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
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 0),
              //   child: WidgetInput(
              //     hint: 'Search for user',
              //     hasPadding: false,
              //     hasBorder: false,
              //     suffixIcon: BootstrapIcons.search,
              //     fillColor: AppColors.adminPrimary2,
              //     type: TextInputType.text,
              //     onChanged: (v) => {},
              //   ),
              // ),
              //
              BlocConsumer<AdminUserBloc, AdminUserState>(
                listener: (context, state) {
                  if (state is AdminUserListState) {
                    data = state.data;
                    AppUtils.logD('AdminUserListState');
                    setState(() {});
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data?.data.length ?? 0,
                    itemBuilder: (context, i) {
                      var d = data?.data[i];
                      var name = d?.fullName ?? '';
                      var subtitle =
                          'Blok ${d?.houseBlock}, No. ${d?.houseNumber} (${d?.phoneNumber})';
                      return WidgetItemCard(
                        title: name.toCapitalizeEachWordCase(),
                        subtitle: subtitle,
                        imageText: AppUtils.getAbbrString(name),
                        statusText: d?.deletedAt == null ? 'Active' : 'Deleted',
                        statusColor: d?.deletedAt == null
                            ? AppColors.adminLime
                            : AppColors.adminPrimary,
                        disabled: d?.deletedAt != null,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            NamedRoute.moduleAdminUserForm,
                            arguments: RoutesArguments(
                              // is edit true
                              args1: true,
                              args2: d?.id,
                            ),
                          ).then((value) {
                            context.read<AdminUserBloc>().add(
                                  AdminUserEventListUser(),
                                );
                          });
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
