// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/dashboard_module/data/admin_dashboard_repository.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';

import '../../../../../shared/models/shared_billing_active.dart';

part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  final AdminDashboardRepository repository;
  AdminDashboardBloc({
    required this.repository,
  }) : super(AdminDashboardInitial()) {
    on<ADSummaryDataEvent>(_aDSummaryDataEvent);
    on<ADSummaryUserEvent>(_aDSummaryUserEvent);
  }

  void _aDSummaryDataEvent(
    ADSummaryDataEvent event,
    Emitter<AdminDashboardState> emit,
  ) async {
    emit(ADSummaryDataLoading());

    SharedBillingActive? data = await repository.getActiveBilling();

    AppUtils.logD("UWYWYWYYWY: ${data?.data.name}");

    emit(ADSummaryData(data));
  }

  void _aDSummaryUserEvent(
    ADSummaryUserEvent event,
    Emitter<AdminDashboardState> emit,
  ) async {
    emit(ADSummaryDataLoading());

    Map<String, dynamic>? data = await repository.getUserTotal();

    emit(ADSummaryUserData(data));
  }
}
