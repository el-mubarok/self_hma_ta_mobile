part of 'admin_dashboard_bloc.dart';

abstract class AdminDashboardState extends Equatable {
  const AdminDashboardState();

  @override
  List<Object?> get props => [];
}

class AdminDashboardInitial extends AdminDashboardState {}

class ADSummaryDataLoading extends AdminDashboardState {}

class ADSummaryData extends AdminDashboardState {
  final SharedBillingActive? data;

  const ADSummaryData(this.data);

  @override
  List<Object?> get props => [data];
}

class ADSummaryUserData extends AdminDashboardState {
  final Map<String, dynamic>? data;

  const ADSummaryUserData(this.data);

  @override
  List<Object?> get props => [data];
}

class ADSummaryDataFailed extends AdminDashboardState {}
