part of 'admin_user_bloc.dart';

class AdminUserState extends Equatable {
  final FormzStatus status;
  final InputText fullName;
  final InputText phoneNumber;
  final InputText email;
  final InputText password;
  final InputText houseBlok;
  final InputText houseNumber;

  const AdminUserState({
    this.status = FormzStatus.pure,
    this.fullName = const InputText.pure(),
    this.phoneNumber = const InputText.pure(),
    this.email = const InputText.pure(),
    this.password = const InputText.pure(),
    this.houseBlok = const InputText.pure(),
    this.houseNumber = const InputText.pure(),
  });

  AdminUserState copyWith({
    FormzStatus? status,
    InputText? fullName,
    InputText? phoneNumber,
    InputText? email,
    InputText? password,
    InputText? houseBlok,
    InputText? houseNumber,
  }) {
    return AdminUserState(
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      houseBlok: houseBlok ?? this.houseBlok,
      houseNumber: houseNumber ?? this.houseNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        fullName,
        phoneNumber,
        email,
        password,
        houseBlok,
        houseNumber,
      ];
}

class AdminUserInitial extends AdminUserState {}

class AdminUserLoadingState extends AdminUserState {}

class AdminUserEditLoadingState extends AdminUserState {}

// delete or retrieve
class AdminUserDeleteLoadingState extends AdminUserState {}

class AdminUserDeleteSuccess extends AdminUserState {}

class AdminUserDeleteFailed extends AdminUserState {}

class AdminUserListState extends AdminUserState {
  final SharedUserListData? data;

  const AdminUserListState(this.data);

  @override
  List<Object?> get props => [data];
}

class AdminUserDataState extends AdminUserState {
  final SharedUserData? data;

  const AdminUserDataState(this.data);

  @override
  List<Object?> get props => [data];
}
