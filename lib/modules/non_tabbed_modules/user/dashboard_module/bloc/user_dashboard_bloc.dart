// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_active.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_payment_active.dart';
import 'package:housing_management_mobile/shared/models/shared_payment_user_history.dart';

import '../data/user_dashboard_repository.dart';

part 'user_dashboard_event.dart';
part 'user_dashboard_state.dart';

class UserDashboardBloc extends Bloc<UserDashboardEvent, UserDashboardState> {
  final UserDashboardRepository repository;

  UserDashboardBloc({
    required this.repository,
  }) : super(UserDashboardInitial()) {
    on<UDActiveBillingDataEvent>(_uDActiveBillingDataEvent);
    on<UDActivePaymentDataEvent>(_uDActivePaymentDataEvent);
    on<UDCrossCheckEvent>(_uDCrossCheckEvent);
    on<UDHistoryList>(_uDHistoryList);
  }

  void _uDHistoryList(
    UDHistoryList event,
    Emitter<UserDashboardState> emit,
  ) async {
    emit(UDHistoryDataLoading());

    SharedPaymentUserHistory? data = await repository.getHistory();

    emit(UDHistoryData(data));
  }

  void _uDCrossCheckEvent(
    UDCrossCheckEvent event,
    Emitter<UserDashboardState> emit,
  ) async {
    emit(UDCrossCheckedLoading());

    await Future.delayed(const Duration(seconds: 2));

    emit(UDCrossChecked());
  }

  void _uDActiveBillingDataEvent(
    UDActiveBillingDataEvent event,
    Emitter<UserDashboardState> emit,
  ) async {
    emit(UDActiveBillingLoading());

    SharedBillingActive? data = await repository.getActiveSession();

    emit(UDActiveBillingData(data));
  }

  void _uDActivePaymentDataEvent(
    UDActivePaymentDataEvent event,
    Emitter<UserDashboardState> emit,
  ) async {
    emit(UDActivePaymentLoading());

    SharedBillingPaymentActive? data = await repository.getActivePayment();

    emit(UDActivePaymentData(data));
  }
}
