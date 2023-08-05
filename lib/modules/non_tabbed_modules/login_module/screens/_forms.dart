import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/login_module/bloc/login_bloc.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_button.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_input.dart';

import '../../../../shared/utils/utils.dart';

class ModuleLoginForms extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModuleLoginForms();
}

class _ModuleLoginForms extends State<ModuleLoginForms> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return WidgetInput(
                label: 'Email',
                hint: 'yourmail@mail.com',
                type: TextInputType.text,
                textInputAction: TextInputAction.next,
                hasBottomMargin: false,
                hasPadding: false,
                hasClearButton: true,
                textController: username,
                onClearButton: () {
                  username.clear();
                  context.read<LoginBloc>().add(
                        const LoginEventUsernameChanged(''),
                      );
                },
                onChanged: (value) => {
                  context.read<LoginBloc>().add(
                        LoginEventUsernameChanged(username.text),
                      ),
                },
              );
            },
          ),
          const Padding(padding: EdgeInsets.only(bottom: 4)),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return WidgetInput(
                label: 'Password',
                hint: 'your password',
                type: TextInputType.text,
                textInputAction: TextInputAction.done,
                isPassword: true,
                hasBottomMargin: false,
                hasPadding: false,
                hasClearButton: true,
                textController: password,
                onClearButton: () {
                  password.clear();
                  context.read<LoginBloc>().add(
                        const LoginEventPasswordChanged(''),
                      );
                },
                onChanged: (value) => {
                  context.read<LoginBloc>().add(
                        LoginEventPasswordChanged(password.text),
                      ),
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginStateSuccess) {
                  username.clear();
                  password.clear();
                } else if (state is LoginStateFailed) {
                  username.clear();
                  password.clear();
                }
              },
              builder: (context, state) {
                return WidgetButton(
                  label: 'Login',
                  fullRounded: false,
                  isLoading: state.status.isSubmissionInProgress,
                  isDisabled: !state.status.isValid,
                  onTap: () {
                    context.read<LoginBloc>().add(LoginEventSubmitLogin());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
