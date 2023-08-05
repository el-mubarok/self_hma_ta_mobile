import 'dart:convert';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:heroicons/heroicons.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/user_module/bloc/admin_user_bloc.dart';
import 'package:housing_management_mobile/shared/models/shared_user_data_model.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_input.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_loader.dart';
import 'package:housing_management_mobile/shared/utils/helper/helper_common.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:housing_management_mobile/themes/color.dart';

import '../../../../../shared/ui/widgets/widget_button.dart';

class ModuleAdminUserFormForms extends StatefulWidget {
  final bool isEdit;

  const ModuleAdminUserFormForms({
    super.key,
    required this.isEdit,
  });

  @override
  State<StatefulWidget> createState() => _ModuleAdminUserFormForms();
}

class _ModuleAdminUserFormForms extends State<ModuleAdminUserFormForms> {
  Map<String, dynamic> formNames = {
    'full_name': 'fullName',
    'phone_number': 'phoneNumber',
    'email': 'email',
    'password': 'password',
    'house_block': 'houseBlok',
    'house_number': 'houseNumber',
  };
  Map<String, TextEditingController> textController = {};
  SharedUserData? userData;
  bool isLoading = false;

  @override
  void initState() {
    // init input controller
    formNames.forEach((key, value) {
      var tempTextController = TextEditingController();
      textController.putIfAbsent(value, () => tempTextController);
    });

    super.initState();
  }

  @override
  void dispose() {
    textController.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  void clearInput() {
    textController.forEach((key, value) {
      value.clear();
    });
  }

  // load user data to form state
  void loadEditData(BuildContext context, SharedUserData? data) {
    context
        .read<AdminUserBloc>()
        .add(AUEventFullNameChanged(data?.data.fullName ?? ''));
    context
        .read<AdminUserBloc>()
        .add(AUEventPhoneNumberChanged(data?.data.phoneNumber ?? ''));
    context
        .read<AdminUserBloc>()
        .add(AUEventEmailChanged(data?.data.email ?? ''));
    context
        .read<AdminUserBloc>()
        .add(AUEventPasswordChanged(data?.data.defaultPassword ?? ''));
    context
        .read<AdminUserBloc>()
        .add(AUEventHouseBlokChanged(data?.data.houseBlock ?? ''));
    context
        .read<AdminUserBloc>()
        .add(AUEventHouseNumberChanged(data?.data.houseNumber ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // empty child listener
        BlocListener<AdminUserBloc, AdminUserState>(
          listener: (context, state) {
            if (state is AdminUserDataState) {
              setState(() {});
              userData = state.data;
              isLoading = false;

              AppUtils.logD('${userData?.data}');

              // apply data
              if (userData != null) {
                var jsonData = json.decode(
                  sharedUserDataToJson(state.data!),
                );
                formNames.forEach((key, value) {
                  if (jsonData['data'][key] != null) {
                    AppUtils.logD(jsonData['data'][key]);
                    if (textController[value] != null) {
                      textController[value]!.text = jsonData['data'][key];
                    }
                  }
                });
                //
                loadEditData(context, userData);
              }
            } else if (state is AdminUserEditLoadingState) {
              setState(() {
                isLoading = true;
              });
            } else if (state is AdminUserDeleteSuccess) {
              context
                  .read<AdminUserBloc>()
                  .add(AdminUserEventUser(userData?.data.id));
              context.read<AdminUserBloc>().add(AdminUserEventListUser());
            } else if (state.status.isSubmissionSuccess) {
              if (!widget.isEdit) {
                clearInput();
              }
            } else {
              setState(() {
                isLoading = false;
              });
            }
          },
          child: Container(),
        ),

        if (isLoading) ...[
          const WidgetLoader(),
        ] else ...[
          //
          if (widget.isEdit) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: BlocBuilder<AdminUserBloc, AdminUserState>(
                builder: (context, state) {
                  return WidgetButton(
                    fullRounded: false,
                    isLoading: state is AdminUserDeleteLoadingState,
                    color: userData?.data.deletedAt != null
                        ? AppColors.primary
                        : AppColors.danger,
                    label: userData?.data.deletedAt != null
                        ? 'Retrieve this user'
                        : 'Delete this user',
                    prefixIcon: userData?.data.deletedAt != null
                        ? HeroIcons.arrowUpOnSquare
                        : HeroIcons.trash,
                    onTap: () {
                      AppHelperCommon().showAlert(
                        context: context,
                        title: userData?.data.deletedAt != null
                            ? 'Retrieving User'
                            : 'Deleting User',
                        content:
                            'Are you sure to ${userData?.data.deletedAt != null ? 'retrieve' : 'delete'} this user?',
                        onTapOk: (alertContext) {
                          // user is already deleted
                          if (userData?.data.deletedAt != null) {
                            context
                                .read<AdminUserBloc>()
                                .add(AdminUserEventRetrieve(userData?.data.id));
                          } else {
                            context
                                .read<AdminUserBloc>()
                                .add(AdminUserEventDelete(userData?.data.id));
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
          //
          if (userData?.data.deletedAt == null) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.adminPrimary1,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    BootstrapIcons.info_circle_fill,
                    color: Colors.white,
                    size: 18,
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                  Text(
                    'All field is required',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Source Sans 3',
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
          // inputs
          BlocBuilder<AdminUserBloc, AdminUserState>(
            builder: (context, state) {
              return WidgetInput(
                label: 'Full Name',
                labelColor: Colors.white,
                hint: 'type user full name',
                type: TextInputType.text,
                textController: textController['fullName'],
                fillColor: AppColors.adminPrimary2,
                hasBorder: false,
                hasPadding: false,
                readOnly: userData?.data.deletedAt != null,
                onChanged: (v) {
                  context.read<AdminUserBloc>().add(
                        AUEventFullNameChanged(
                          textController['fullName']!.text,
                        ),
                      );
                },
              );
            },
          ),

          if (userData?.data.deletedAt == null) ...[
            BlocBuilder<AdminUserBloc, AdminUserState>(
              builder: (context, state) {
                return WidgetInput(
                  label: 'Phone Number',
                  labelColor: Colors.white,
                  hint: 'type user phone number',
                  type: TextInputType.number,
                  textController: textController['phoneNumber'],
                  fillColor: AppColors.adminPrimary2,
                  hasBorder: false,
                  hasPadding: false,
                  onChanged: (v) {
                    context.read<AdminUserBloc>().add(
                          AUEventPhoneNumberChanged(
                            textController['phoneNumber']!.text,
                          ),
                        );
                  },
                );
              },
            ),
            BlocBuilder<AdminUserBloc, AdminUserState>(
              builder: (context, state) {
                return WidgetInput(
                  label: 'Email',
                  labelColor: Colors.white,
                  hint: 'type user email',
                  type: TextInputType.emailAddress,
                  textController: textController['email'],
                  fillColor: AppColors.adminPrimary2,
                  hasBorder: false,
                  hasPadding: false,
                  onChanged: (v) {
                    context.read<AdminUserBloc>().add(
                          AUEventEmailChanged(
                            textController['email']!.text,
                          ),
                        );
                  },
                );
              },
            ),
            BlocBuilder<AdminUserBloc, AdminUserState>(
              builder: (context, state) {
                return WidgetInput(
                  label: 'Password (optional)',
                  labelColor: Colors.white,
                  hint: 'user password',
                  notes: '*The default password is same as phone number',
                  notesColor: Colors.white,
                  type: TextInputType.text,
                  textController: textController['password'],
                  isPassword: true,
                  fillColor: AppColors.adminPrimary2,
                  hasBorder: false,
                  hasPadding: false,
                  onChanged: (v) {
                    context.read<AdminUserBloc>().add(
                          AUEventPasswordChanged(
                            textController['password']!.text,
                          ),
                        );
                  },
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<AdminUserBloc, AdminUserState>(
                    builder: (context, state) {
                      return WidgetInput(
                        label: 'House Blok',
                        labelColor: Colors.white,
                        hint: 'eg: C-3',
                        type: TextInputType.text,
                        textController: textController['houseBlok'],
                        fillColor: AppColors.adminPrimary2,
                        hasBorder: false,
                        hasPadding: false,
                        onChanged: (v) {
                          context.read<AdminUserBloc>().add(
                                AUEventHouseBlokChanged(
                                  textController['houseBlok']!.text,
                                ),
                              );
                        },
                      );
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                Expanded(
                  child: BlocBuilder<AdminUserBloc, AdminUserState>(
                    builder: (context, state) {
                      return WidgetInput(
                        label: 'House Number',
                        labelColor: Colors.white,
                        hint: 'eg: 2',
                        type: TextInputType.number,
                        textController: textController['houseNumber'],
                        fillColor: AppColors.adminPrimary2,
                        hasBorder: false,
                        hasPadding: false,
                        onChanged: (v) {
                          context.read<AdminUserBloc>().add(
                                AUEventHouseNumberChanged(
                                  textController['houseNumber']!.text,
                                ),
                              );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ],
    );
  }
}
