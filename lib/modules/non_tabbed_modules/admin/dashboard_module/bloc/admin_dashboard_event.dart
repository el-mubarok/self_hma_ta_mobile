part of 'admin_dashboard_bloc.dart';

abstract class AdminDashboardEvent extends Equatable {
  const AdminDashboardEvent();

  @override
  List<Object> get props => [];
}

class ADSummaryDataEvent extends AdminDashboardEvent {}

class ADSummaryUserEvent extends AdminDashboardEvent {}
