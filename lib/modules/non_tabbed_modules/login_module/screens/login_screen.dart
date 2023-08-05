import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:housing_management_mobile/config/assets.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/login_module/data/login_repository.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/login_module/screens/_forms.dart';
import 'package:housing_management_mobile/shared/utils/helper/helper_common.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:housing_management_mobile/themes/color.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../shared/ui/wrappers/wrapper_page.dart';
import '../bloc/login_bloc.dart';

class ModuleLogin extends StatefulWidget {
  const ModuleLogin({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleLogin();
}

class _ModuleLogin extends State<ModuleLogin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showFailedAlert(BuildContext context) {
    AppHelperCommon().showAlert(
      context: context,
      okOnly: true,
      title: 'Error',
      subtitle: 'Login failed',
      content: 'Please re check your username/password',
      onTapOk: (alertContext) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        repository: LoginRepository(),
      ),
      child: WrapperPage(
        safeTop: false,
        hasPadding: false,
        statusBarColor: Colors.transparent,
        backgroundImage: const DecorationImage(
          image: AssetImage(AppAsset.bgLogin),
          fit: BoxFit.cover,
        ),
        height: MediaQuery.of(context).size.height,
        child: Container(
          color: AppColors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 64,
                  left: 64,
                  right: 64,
                ),
                child: Image.asset(AppAsset.logo),
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginStateSuccess) {
                    if (state.code == 200) {
                      AppUtils.logD("Code 200");
                      if (state.user?.data.type == 'admin') {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          NamedRoute.moduleAdminDashboard,
                          (route) => false,
                        );
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          NamedRoute.moduleUserDashboard,
                          (route) => false,
                        );
                      }
                    } else if (state.code == 400) {
                      AppUtils.logD("Error 400");
                      showFailedAlert(context);
                    } else {
                      AppUtils.logD("Error 0");
                      showFailedAlert(context);
                    }
                  } else if (state is LoginStateFailed) {
                    showFailedAlert(context);
                  }
                },
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: 'Welcome to\n',
                          children: [
                            TextSpan(
                              text: 'Mentari Village Billing App',
                            ),
                          ],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: ModuleLoginForms(),
                      ),
                    ],
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'App version ',
                  children: [
                    TextSpan(
                      text: '1.0.0 build 1',
                    ),
                  ],
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
