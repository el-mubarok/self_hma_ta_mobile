import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/shared/bloc/notification/data/notification_repository.dart';

import 'config/routes/route_names.dart';
import 'config/routes/routes.dart';
import 'shared/bloc/notification/bloc/notification_bloc.dart';
import 'shared/utils/utils_global.dart';
import 'themes/color.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const MyApp myApp = MyApp();
  runApp(myApp);
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NotificationBloc(
            repository: NotificationRepository(),
          )..add(NotificationEventInitialize()),
        )
      ],
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return MaterialApp(
            scaffoldMessengerKey: AppUtilsGlobal().snackbarKey,
            onGenerateRoute: Routes.generatedRoute,
            initialRoute: NamedRoute.moduleSplash,
            theme: ThemeData(
              fontFamily: 'Inter',
              primaryColor: AppColors.primary,
              useMaterial3: true,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: AppColors.secondary,
              ),
            ),
            darkTheme: ThemeData(
              fontFamily: 'Inter',
              primaryColor: AppColors.primary,
              useMaterial3: true,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: AppColors.secondary,
              ),
            ),
          );
        },
      ),
    );
  }
}
