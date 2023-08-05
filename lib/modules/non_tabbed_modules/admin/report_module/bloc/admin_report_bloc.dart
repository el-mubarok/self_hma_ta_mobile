// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/admin_setting_repository.dart';

part 'admin_report_event.dart';
part 'admin_report_state.dart';

class AdminReportBloc extends Bloc<AdminReportEvent, AdminReportState> {
  final AdminReportRepository repository;

  AdminReportBloc({
    required this.repository,
  }) : super(AdminReportInitial()) {}
}
