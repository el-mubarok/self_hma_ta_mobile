part of 'user_dashboard_bloc.dart';

abstract class UserDashboardState extends Equatable {
  const UserDashboardState();

  @override
  List<Object?> get props => [];
}

class UserDashboardInitial extends UserDashboardState {}

class UDActiveBillingLoading extends UserDashboardState {}

class UDActiveBillingData extends UserDashboardState {
  final SharedBillingActive? data;
  const UDActiveBillingData(this.data);

  @override
  List<Object?> get props => [data];
}

class UDActivePaymentLoading extends UserDashboardState {}

class UDActivePaymentData extends UserDashboardState {
  final SharedBillingPaymentActive? data;
  const UDActivePaymentData(this.data);

  @override
  List<Object?> get props => [data];
}

class UDCrossCheckedLoading extends UserDashboardState {}

class UDCrossChecked extends UserDashboardState {}

class UDHistoryDataLoading extends UserDashboardState {}

class UDHistoryData extends UserDashboardState {
  final SharedPaymentUserHistory? data;

  const UDHistoryData(this.data);

  @override
  List<Object?> get props => [data];
}
