// ignore_for_file: must_be_immutable

part of 'sign_up_bloc.dart';

class SignUpState {
  final String email;
  final String password;
  final String emailError;
  final String passwordError;
  bool changeSecureIcon;
  bool isEmailValid;
  bool isPasswordValid;
  NavigatorStatus status;

  SignUpState._({
    required this.email,
    required this.password,
    required this.emailError,
    required this.passwordError,
    required this.changeSecureIcon,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.status,
  });

  SignUpState.empty()
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

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? changeSecureIcon,
    bool? isEmailValid,
    bool? isPasswordValid,
    NavigatorStatus? status,
  }) {
    return SignUpState._(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      changeSecureIcon: changeSecureIcon ?? this.changeSecureIcon,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      status: status ?? this.status,
    );
  }
}
