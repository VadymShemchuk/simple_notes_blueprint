import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/app/navigator_status.dart';
import 'package:simple_notes_blueprint/common/repository/auth_repository.dart';
import 'package:simple_notes_blueprint/utils/validator_util.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class _Constants {
  static const commonError = 'Authorization is failed, try again.';
}

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;

  SignUpBloc(this._authRepository) : super(SignUpState.empty()) {
    on<SignUpNameChanged>(_onNameChanged);
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpSibmitted>(_onSubmitted);
    on<SignUpChangeSecure>(_onChangeSecure);
    on<OnSignUpEvent>(_onSignUp);
  }

  void _onNameChanged(
    SignUpNameChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(
      name: event.name,
    ));
  }

  void _onEmailChanged(
    SignUpEmailChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(
      email: event.email,
    ));
  }

  void _onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  void _onChangeSecure(
    SignUpChangeSecure event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(
        changeSecureIcon: state.changeSecureIcon = !state.changeSecureIcon));
  }

  void _onSignUp(
    OnSignUpEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(status: OnSignIn()));
  }

  void _onSubmitted(
    SignUpSibmitted event,
    Emitter<SignUpState> emit,
  ) async {
    bool? isEmailValid = ValidatorUtil.isEmailValid(state.email);
    bool? isPasswordValid = ValidatorUtil.isPasswordValid(state.password);

    if (!isEmailValid || !isPasswordValid) {
      String? emailError = ValidatorUtil.emailError(state.email);
      String? passwordError = ValidatorUtil.passwordError(state.password);

      emit(state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
      ));
    } else {
      emit(state.copyWith(
        status: Progress(),
      ));
      try {
        bool isSignUp = await _authRepository.signUp(
          state.email,
          state.password,
        );
        if (isSignUp) {
          emit(state.copyWith(status: Success()));
        } else {
          emit(
            state.copyWith(
              status: FailureAuth(error: _Constants.commonError),
            ),
          );
        }
      } on RepositoryFailExeption catch (e) {
        emit(
          state.copyWith(
            status: FailureAuth(error: e.message ?? _Constants.commonError),
          ),
        );
      } catch (_) {
        emit(
          state.copyWith(
            status: FailureAuth(error: _Constants.commonError),
          ),
        );
      }
    }
  }
}
