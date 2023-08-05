// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../shared/models/input/input_text_model.dart';
import '../../../../shared/models/shared_user_data_model.dart';
import '../../../../shared/utils/helper/helper_storage.dart';
import '../data/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({
    required this.repository,
  }) : super(LoginInitial()) {
    on<LoginEventCheckLoggedIn>(_loginEventCheckLoggedIn);
    on<LoginEventSubmitLogin>(_loginEventSubmitLogin);
    on<LoginEventUsernameChanged>(_loginEventUsernameChanged);
    on<LoginEventPasswordChanged>(_loginEventPasswordChanged);
    on<LoginEventUsernameDeviceChanged>(_loginEventUsernameDeviceChanged);
  }

  void _loginEventCheckLoggedIn(
    LoginEventCheckLoggedIn event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginStateLoading());

    LoginData result = await repository.checkIsLoggedIn();

    if (result.isLoggedIn) {
      emit(LoginStateLoggedIn(result.type ?? ''));
    } else {
      emit(LoginStateNotLoggedIn());
    }
  }

  void _loginEventSubmitLogin(
    LoginEventSubmitLogin event,
    Emitter<LoginState> emit,
  ) async {
    // emit(LoginStateLoading());
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    // do login
    SharedUserData? result = await repository.submitLogin(
      state.username.value,
      state.password.value,
    );

    if (result != null) {
      await AppHelperStorage().storeUserData(result);

      emit(LoginStateSuccess(
        result.code.toInt(),
        'Logged in',
        result,
      ));
    } else {
      emit(const LoginStateFailed(
        0,
        "unknown error, please look into log for details",
      ));
    }
  }

  void _loginEventUsernameChanged(
    LoginEventUsernameChanged event,
    Emitter<LoginState> emit,
  ) async {
    final InputText username = InputText.dirty(
      event.username,
    );
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([
          username,
          state.password,
        ]),
      ),
    );
  }

  void _loginEventPasswordChanged(
    LoginEventPasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    final InputText password = InputText.dirty(
      event.password,
    );
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          state.username,
          password,
        ]),
      ),
    );
  }

  void _loginEventUsernameDeviceChanged(
    LoginEventUsernameDeviceChanged event,
    Emitter<LoginState> emit,
  ) async {
    final InputText username = InputText.dirty(
      event.username,
    );
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([
          username,
        ]),
      ),
    );
  }
}
