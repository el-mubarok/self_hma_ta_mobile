part of 'user_dashboard_bloc.dart';

abstract class UserDashboardEvent extends Equatable {
  const UserDashboardEvent();

  @override
  List<Object> get props => [];
}

class UDActiveBillingDataEvent extends UserDashboardEvent {}

class UDActivePaymentDataEvent extends UserDashboardEvent {}

class UDCrossCheckEvent extends UserDashboardEvent {}

class UDHistoryList extends UserDashboardEvent {}
