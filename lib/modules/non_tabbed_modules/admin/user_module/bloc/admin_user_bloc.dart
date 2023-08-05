// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/user_module/data/admin_user_repository.dart';
import 'package:housing_management_mobile/shared/models/input/input_text_model.dart';
import 'package:housing_management_mobile/shared/models/shared_list_user_data.dart';
import 'package:housing_management_mobile/shared/models/shared_user_data_model.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';

part 'admin_user_event.dart';
part 'admin_user_state.dart';

class AdminUserBloc extends Bloc<AdminUserEvent, AdminUserState> {
  final AdminUserRepository repository;

  AdminUserBloc({
    required this.repository,
  }) : super(AdminUserInitial()) {
    on<AdminUserEventListUser>(_adminUserEventListUser);
    on<AdminUserEventUser>(_adminUserEventUser);
    on<AdminUserEventDelete>(_adminUserEventDelete);
    on<AdminUserEventRetrieve>(_adminUserEventRetrieve);
    on<AdminUserEventSubmit>(_adminUserEventSubmit);
    //
    on<AUEventFullNameChanged>(_aUEventFullNameChanged);
    on<AUEventPhoneNumberChanged>(_aUEventPhoneNumberChanged);
    on<AUEventEmailChanged>(_aUEventEmailChanged);
    on<AUEventPasswordChanged>(_aUEventPasswordChanged);
    on<AUEventHouseBlokChanged>(_aUEventHouseBlokChanged);
    on<AUEventHouseNumberChanged>(_aUEventHouseNumberChanged);
  }

  void _adminUserEventUser(
    AdminUserEventUser event,
    Emitter<AdminUserState> emit,
  ) async {
    if (event.id != null) {
      emit(AdminUserEditLoadingState());

      SharedUserData? data = await repository.getUser(event.id);

      AppUtils.logD('get specific user data: ${data?.code}');

      // await Future.delayed(const Duration(seconds: 3));

      emit(AdminUserDataState(data));
    }
  }

  void _adminUserEventDelete(
    AdminUserEventDelete event,
    Emitter<AdminUserState> emit,
  ) async {
    if (event.id != null) {
      emit(AdminUserDeleteLoadingState());

      bool result = await repository.deleteUser(event.id);

      if (result) {
        emit(AdminUserDeleteSuccess());
      } else {
        emit(AdminUserDeleteFailed());
      }
    }
  }

  void _adminUserEventRetrieve(
    AdminUserEventRetrieve event,
    Emitter<AdminUserState> emit,
  ) async {
    if (event.id != null) {
      emit(AdminUserDeleteLoadingState());

      bool result = await repository.retrieveUser(event.id);

      if (result) {
        emit(AdminUserDeleteSuccess());
      } else {
        emit(AdminUserDeleteFailed());
      }
    }
  }

  void _adminUserEventSubmit(
    AdminUserEventSubmit event,
    Emitter<AdminUserState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    SubmitParams params = SubmitParams(
      fullName: state.fullName.value,
      phoneNumber: state.phoneNumber.value,
      email: state.email.value,
      password: state.password.value,
      houseBlok: state.houseBlok.value,
      houseNumber: state.houseNumber.value,
    );
    bool result = await repository.submitCreateUser(
      params,
      event.edit,
      event.userId,
    );

    if (result) {
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
      ));
    } else {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }

  // #region input changes
  void _adminUserEventListUser(
    AdminUserEventListUser event,
    Emitter<AdminUserState> emit,
  ) async {
    emit(AdminUserLoadingState());
    // load user list
    SharedUserListData? data = await repository.getListUser();

    emit(AdminUserListState(data));
  }

  void _aUEventFullNameChanged(
    AUEventFullNameChanged event,
    Emitter<AdminUserState> emit,
  ) async {
    final InputText value = InputText.dirty(event.value);
    emit(
      state.copyWith(
        fullName: value,
        status: Formz.validate([
          value,
          state.phoneNumber,
          state.email,
          // state.password,
          state.houseBlok,
          state.houseNumber
        ]),
      ),
    );
  }

  void _aUEventPhoneNumberChanged(
    AUEventPhoneNumberChanged event,
    Emitter<AdminUserState> emit,
  ) async {
    final InputText value = InputText.dirty(event.value);
    emit(
      state.copyWith(
        phoneNumber: value,
        status: Formz.validate([
          state.fullName,
          value,
          state.email,
          // state.password,
          state.houseBlok,
          state.houseNumber
        ]),
      ),
    );
  }

  void _aUEventEmailChanged(
    AUEventEmailChanged event,
    Emitter<AdminUserState> emit,
  ) async {
    final InputText value = InputText.dirty(event.value);
    emit(
      state.copyWith(
        email: value,
        status: Formz.validate([
          state.fullName,
          state.phoneNumber,
          value,
          // state.password,
          state.houseBlok,
          state.houseNumber
        ]),
      ),
    );
  }

  void _aUEventPasswordChanged(
    AUEventPasswordChanged event,
    Emitter<AdminUserState> emit,
  ) async {
    final InputText value = InputText.dirty(event.value);
    emit(
      state.copyWith(
        password: value,
        status: Formz.validate([
          state.fullName,
          state.phoneNumber,
          state.email,
          // value,
          state.houseBlok,
          state.houseNumber
        ]),
      ),
    );
  }

  void _aUEventHouseBlokChanged(
    AUEventHouseBlokChanged event,
    Emitter<AdminUserState> emit,
  ) async {
    final InputText value = InputText.dirty(event.value);
    emit(
      state.copyWith(
        houseBlok: value,
        status: Formz.validate([
          state.fullName,
          state.phoneNumber,
          state.email,
          // state.password,
          value,
          state.houseNumber
        ]),
      ),
    );
  }

  void _aUEventHouseNumberChanged(
    AUEventHouseNumberChanged event,
    Emitter<AdminUserState> emit,
  ) async {
    final InputText value = InputText.dirty(event.value);
    emit(
      state.copyWith(
        houseNumber: value,
        status: Formz.validate([
          state.fullName,
          state.phoneNumber,
          state.email,
          // state.password,
          state.houseBlok,
          value
        ]),
      ),
    );
  }
  // #endregion
}
