import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/user_module/bloc/admin_user_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/user_module/data/admin_user_repository.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/user_module/screens/_forms.dart';
import 'package:housing_management_mobile/shared/models/shared_user_data_model.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';

import '../../../../../shared/ui/widgets/widget_appbar.dart';
import '../../../../../shared/ui/widgets/widget_button.dart';
import '../../../../../shared/ui/widgets/widget_loader.dart';
import '../../../../../shared/ui/wrappers/wrapper_page.dart';
import '../../../../../shared/utils/helper/helper_common.dart';
import '../../../../../themes/color.dart';

class ModuleAdminUserForm extends StatefulWidget {
  final bool isEdit;
  final dynamic userId;

  const ModuleAdminUserForm({
    super.key,
    this.isEdit = false,
    this.userId,
  });

  @override
  State<StatefulWidget> createState() => _ModuleAdminUserForm();
}

class _ModuleAdminUserForm extends State<ModuleAdminUserForm> {
  SharedUserData? data;

  void showAlert(
    BuildContext context,
    String title,
    String content,
  ) {
    AppHelperCommon().showAlert(
      context: context,
      title: title,
      content: content,
      okOnly: true,
      onTapOk: (alertContext) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminUserBloc(
        repository: AdminUserRepository(),
      )..add(AdminUserEventUser(widget.userId)),
      child: WrapperPage(
        safeTop: true,
        hasPadding: false,
        statusBarColor: AppColors.adminPrimary.darken(0.01),
        backgroundColor: AppColors.adminPrimary,
        height: MediaQuery.of(context).size.height,
        appBar: WidgetAppBar(
          title: widget.isEdit ? 'Edit User' : 'Add New User',
          onTap: () => Navigator.pop(context),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<AdminUserBloc, AdminUserState>(
            listener: (context, state) {
              if (state is AdminUserDataState) {
                data = state.data;
                setState(() {});
              } else if (state.status.isSubmissionSuccess) {
                showAlert(
                  context,
                  'Success',
                  widget.isEdit ? 'Data updated' : 'User created',
                );
              } else if (state.status.isSubmissionFailure) {
                showAlert(
                  context,
                  'Error',
                  widget.isEdit ? 'Update failed' : 'Failed to create user',
                );
              }
            },
            builder: (context, state) {
              return data?.data.deletedAt == null
                  ? WidgetButton(
                      fullRounded: false,
                      isLoading: state.status.isSubmissionInProgress,
                      isDisabled: !state.status.isValid,
                      color: AppColors.adminLime,
                      label: 'Save',
                      onTap: () {
                        context.read<AdminUserBloc>().add(
                              AdminUserEventSubmit(
                                edit: widget.isEdit,
                                userId: data?.data.id,
                              ),
                            );
                      },
                    )
                  : Container(
                      height: 0,
                    );
            },
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ModuleAdminUserFormForms(
            isEdit: widget.isEdit,
          ),
        ),
      ),
    );
  }
}
