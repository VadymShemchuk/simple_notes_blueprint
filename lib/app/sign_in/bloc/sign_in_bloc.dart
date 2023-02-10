import 'package:flutter/material.dart';
import 'package:simple_notes_blueprint/app/navigator_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/common/repository/auth_repository.dart';
import 'package:simple_notes_blueprint/utils/validator_util.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class _Constants {
  static const commonError = 'Something went wront, try again.';
}

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _authRepository;

  SignInBloc(this._authRepository) : super(SignInState.empty()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInSubmitted>(_onSubmitted);
    on<SignInChangeSecure>(_onChangeSecure);
    on<OnSignUpEvent>(_onChangeState);
  }

  void _onEmailChanged(
    SignInEmailChanged event,
    Emitter<SignInState> emit,
  ) {
    String? email = event.email;
    emit(state.copyWith(
      email: email,
    ));
  }

  void _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onChangeSecure(
    SignInChangeSecure event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(
        changeSecureIcon: state.changeSecureIcon = !state.changeSecureIcon));
  }

  void _onChangeState(
    OnSignUpEvent event,
    Emitter<SignInState> emit,
  ) {
    emit(
      state.copyWith(
        status: OnSignUp(),
      ),
    );
    emit(
      state.copyWith(
        status: const InitialNavigatorStatus(),
      ),
    );
  }

  void _onSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    bool? isEmailValid = ValidatorUtil.isEmailValid(state.email);
    bool? isPasswordValid = ValidatorUtil.isPasswordValid(state.password);
    if (!isEmailValid || !isPasswordValid) {
      String? emailError = ValidatorUtil.emailError(state.email);
      String? passwordError = ValidatorUtil.passwordError(state.password);

      emit(
        state.copyWith(
          emailError: emailError,
          passwordError: passwordError,
          isEmailValid: isEmailValid,
          isPasswordValid: isPasswordValid,
        ),
      );
    } else {
      emit(state.copyWith(
        status: Progress(),
      ));
      try {
        final isSignIn = await _authRepository.signIn(
          state.email,
          state.password,
        );
        if (isSignIn) {
          emit(
            state.copyWith(
              status: Success(),
            ),
          );
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
            status: FailureAuth(
              error: e.message ?? _Constants.commonError,
            ),
          ),
        );
      } catch (_) {
        emit(
          state.copyWith(
            status: FailureAuth(
              error: _Constants.commonError,
            ),
          ),
        );
      }
    }
  }
}
