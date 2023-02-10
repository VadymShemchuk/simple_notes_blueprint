// ignore_for_file: must_be_immutable

part of 'sign_in_bloc.dart';

class SignInState {
  final String email;
  final String password;
  final String emailError;
  final String passwordError;
  bool changeSecureIcon;
  bool isEmailValid;
  bool isPasswordValid;
  final NavigatorStatus status;

  SignInState._({
    required this.email,
    required this.password,
    required this.emailError,
    required this.passwordError,
    required this.changeSecureIcon,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.status,
  });

  SignInState.empty()
      : this._(
          email: '',
          password: '',
          emailError: '',
          passwordError: '',
          changeSecureIcon: true,
          isEmailValid: true,
          isPasswordValid: true,
          status: const InitialNavigatorStatus(),
        );

  SignInState copyWith({
    String? emailError,
    String? passwordError,
    String? email,
    String? password,
    bool? changeSecureIcon,
    bool? isEmailValid,
    bool? isPasswordValid,
    NavigatorStatus? status,
  }) {
    return SignInState._(
        email: email ?? this.email,
        password: password ?? this.password,
        emailError: emailError ?? this.emailError,
        passwordError: passwordError ?? this.passwordError,
        changeSecureIcon: changeSecureIcon ?? this.changeSecureIcon,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        status: status ?? this.status);
  }
}
