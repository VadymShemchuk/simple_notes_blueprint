import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/app/navigator_status.dart';
import 'package:simple_notes_blueprint/app/sign_in/bloc/sign_in_bloc.dart';
import 'package:simple_notes_blueprint/utils/button_util.dart';
import 'package:simple_notes_blueprint/utils/loader_util.dart';
import 'package:simple_notes_blueprint/utils/logo_util.dart';
import 'package:simple_notes_blueprint/utils/text_field_util.dart';

class _Constants {
  static const signInText = 'Sign In';
  static const signUpText = 'Sign Up';
  static const noAccountText = 'No account?';
}

class SignInView extends StatelessWidget {
  const SignInView(
      {Key? key,
      required this.emailError,
      required this.passwordError,
      required this.changeSecureIcon,
      required this.isEmailValid,
      required this.isPasswordValid,
      required this.status})
      : super(key: key);

  final String emailError;
  final String passwordError;
  final bool changeSecureIcon;
  final bool isEmailValid;
  final bool isPasswordValid;
  final NavigatorStatus status;

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: LogoUtil.buildLogo(),
            ),
            TextFieldUtil.buildCustomTextField(
                type: TextFieldType.email,
                errorText: isEmailValid ? null : emailError,
                onTextFieldChanged: (email) =>
                    context.read<SignInBloc>().add(SignInEmailChanged(email))),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextFieldUtil.buildCustomTextField(
                type: TextFieldType.password,
                errorText: isPasswordValid ? null : passwordError,
                onTextFieldChanged: (password) => context
                    .read<SignInBloc>()
                    .add(SignInPasswordChanged(password)),
                changeSecureIcon: changeSecureIcon,
                onSecurePressed: () =>
                    context.read<SignInBloc>().add(SignInChangeSecure()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: status is Progress
                  ? LoaderUtil.buildLoader()
                  : ButtonUtil.buildCommonButton(
                      context,
                      onPressed: () =>
                          context.read<SignInBloc>().add(SignInSubmitted()),
                      buttonText: _Constants.signInText,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ButtonUtil.buildTextButton(
                onPressed: () =>
                    context.read<SignInBloc>().add(OnSignUpEvent()),
                prefixLabel: _Constants.noAccountText,
                buttonLabel: _Constants.signUpText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
