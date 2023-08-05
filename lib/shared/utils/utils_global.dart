import 'package:flutter/material.dart';
import '../models/shared_user_data_model.dart';

class AppUtilsGlobal {
  static final AppUtilsGlobal instance = AppUtilsGlobal.internal();
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  factory AppUtilsGlobal() => instance;

  AppUtilsGlobal.internal();

  final darkMode = ValueNotifier<bool>(false);
  final userData = ValueNotifier<SharedUserData?>(null);
  final cronStatus = ValueNotifier<bool>(false);
  final cronSyncStatus = ValueNotifier<String>('');
  final cronSyncRunStatus = ValueNotifier<bool>(false);
  final cronSyncFileLeft = ValueNotifier<int>(0);
  final cronSyncNeeded = ValueNotifier<bool>(false);
  // final cronSyncRunDate = ValueNotifier<DateTime>(DateTime.now());
  final cronSyncRunDate = ValueNotifier<DateTime?>(null);
  final syncLocationServiceStatus = ValueNotifier<bool>(false);
  // final syncLocation = ValueNotifier<Position?>(null);
  final syncLocationAllowed = ValueNotifier<bool>(false);
  final syncLocationText = ValueNotifier<String>('');
  final syncLocationTextName = ValueNotifier<String>('');
  final deviceInfo = ValueNotifier<String>('');
  final sessionExpired = ValueNotifier<bool>(false);
  final isCameraCaptured = ValueNotifier<bool>(false);
  final isDeviceRegistered = ValueNotifier<bool>(false);
  final deviceId = ValueNotifier<String>('');
  final greeting = ValueNotifier<String>('...');
  //
  final networkState = ValueNotifier<bool>(false);
  final internetState = ValueNotifier<bool>(false);
  final reloadUserDashboard = ValueNotifier<bool>(false);
}
