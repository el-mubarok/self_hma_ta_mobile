part of 'admin_setting_bloc.dart';

abstract class AdminSettingState extends Equatable {
  const AdminSettingState();

  @override
  List<Object?> get props => [];
}

class AdminSettingInitial extends AdminSettingState {}

class ASListLoadingState extends AdminSettingState {}

class ASUpdateLoadingState extends AdminSettingState {}

class ASUpdateSuccess extends AdminSettingState {}

class ASUpdateFailed extends AdminSettingState {}

class ASListState extends AdminSettingState {
  final SharedBillingListData? data;

  const ASListState(this.data);

  @override
  List<Object?> get props => [data];
}

class ASBillingState extends AdminSettingState {
  final SharedBillingData? data;

  const ASBillingState(this.data);

  @override
  List<Object?> get props => [data];
}

class ASSessionTimeLoadingState extends AdminSettingState {}

class ASSessionTimeUpdateSuccess extends AdminSettingState {}

class ASSessionTimeUpdateFailed extends AdminSettingState {}

class ASSessionTimeCreateSuccess extends AdminSettingState {}

class ASSessionTimeCreateFailed extends AdminSettingState {}

class ASSessionTimeDeleteLoadingState extends AdminSettingState {}

class ASSessionTimeDeleteSuccess extends AdminSettingState {}

class ASSessionTimeDeleteFailed extends AdminSettingState {}

class ASCreateSessionLoading extends AdminSettingState {}

class ASCreateSessionSuccess extends AdminSettingState {}

class ASCreateSessionFailed extends AdminSettingState {}
