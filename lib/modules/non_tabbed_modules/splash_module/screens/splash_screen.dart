import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_management_mobile/config/assets.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/login_module/bloc/login_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/login_module/data/login_repository.dart';
import 'package:housing_management_mobile/themes/color.dart';

import '../../../../shared/ui/wrappers/wrapper_page.dart';

class ModuleSplash extends StatefulWidget {
  const ModuleSplash({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleSplash();
}

class _ModuleSplash extends State<ModuleSplash> {
  String loadingText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      safeTop: false,
      hasPadding: false,
      statusBarColor: Colors.transparent,
      backgroundImage: const DecorationImage(
        image: AssetImage(AppAsset.bgLogin),
        fit: BoxFit.cover,
      ),
      height: MediaQuery.of(context).size.height,
      child: BlocProvider(
        create: (context) => LoginBloc(
          repository: LoginRepository(),
        )..add(LoginEventCheckLoggedIn()),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginStateLoading) {
              // set loading information
              setState(() {
                loadingText = 'Checking login info';
              });
            } else if (state is LoginStateLoggedIn) {
              // go to dashboard
              setState(() {
                loadingText = 'Going to dashboard page';
              });
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  if (state.role == 'admin') {
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
                },
              );
            } else if (state is LoginStateNotLoggedIn) {
              // go to login
              setState(() {
                loadingText = 'Going to login page';
              });
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    NamedRoute.moduleLogin,
                    (route) => false,
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return Container(
              color: AppColors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAsset.logo,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      '$loadingText...',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Source Code Pro',
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
