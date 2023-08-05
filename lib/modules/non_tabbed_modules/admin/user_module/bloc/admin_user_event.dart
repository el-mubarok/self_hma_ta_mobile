part of 'admin_user_bloc.dart';

abstract class AdminUserEvent extends Equatable {
  const AdminUserEvent();

  @override
  List<Object> get props => [];
}

class AdminUserEventListUser extends AdminUserEvent {}

class AdminUserEventUser extends AdminUserEvent {
  final dynamic id;

  const AdminUserEventUser(this.id);

  @override
  List<Object> get props => [id];
}

class AdminUserEventDelete extends AdminUserEvent {
  final dynamic id;

  const AdminUserEventDelete(this.id);

  @override
  List<Object> get props => [id];
}

class AdminUserEventRetrieve extends AdminUserEvent {
  final dynamic id;

  const AdminUserEventRetrieve(this.id);

  @override
  List<Object> get props => [id];
}

class AdminUserEventSubmit extends AdminUserEvent {
  final bool edit;
  final dynamic userId;

  const AdminUserEventSubmit({this.edit = false, this.userId});

  @override
  List<Object> get props => [edit, userId];
}

// #region input changes event
class AUEventFullNameChanged extends AdminUserEvent {
  final String value;
  const AUEventFullNameChanged(this.value);
  @override
  List<Object> get props => [value];
}

class AUEventPhoneNumberChanged extends AdminUserEvent {
  final String value;
  const AUEventPhoneNumberChanged(this.value);
  @override
  List<Object> get props => [value];
}

class AUEventEmailChanged extends AdminUserEvent {
  final String value;
  const AUEventEmailChanged(this.value);
  @override
  List<Object> get props => [value];
}

class AUEventPasswordChanged extends AdminUserEvent {
  final String value;
  const AUEventPasswordChanged(this.value);
  @override
  List<Object> get props => [value];
}

class AUEventHouseBlokChanged extends AdminUserEvent {
  final String value;
  const AUEventHouseBlokChanged(this.value);
  @override
  List<Object> get props => [value];
}

class AUEventHouseNumberChanged extends AdminUserEvent {
  final String value;
  const AUEventHouseNumberChanged(this.value);
  @override
  List<Object> get props => [value];
}
// #endregion
