import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/app/sign_up/bloc/sign_up_bloc.dart';
import 'package:simple_notes_blueprint/utils/button_util.dart';
import 'package:simple_notes_blueprint/utils/logo_util.dart';
import 'package:simple_notes_blueprint/utils/text_field_util.dart';

class SignUpView extends StatelessWidget {
  final String emailError;
  final String passwordError;
  final bool changeSecureIcon;
  final bool isEmailValid;
  final bool isPasswordValid;

  const SignUpView(
      {Key? key,
      required this.emailError,
      required this.passwordError,
      required this.changeSecureIcon,
      required this.isEmailValid,
      required this.isPasswordValid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 40,
                child: GestureDetector(
                  onTap: () => context.read<SignUpBloc>().add(OnSignUpEvent()),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoUtil.buildLogo(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextFieldUtil.buildCustomTextField(
                        type: TextFieldType.email,
                        errorText: isEmailValid ? null : emailError,
                        onTextFieldChanged: (email) => context
                            .read<SignUpBloc>()
                            .add(SignUpEmailChanged(email)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextFieldUtil.buildCustomTextField(
                        type: TextFieldType.password,
                        errorText: isPasswordValid ? null : passwordError,
                        onTextFieldChanged: (password) => context
                            .read<SignUpBloc>()
                            .add(SignUpPasswordChanged(password)),
                        onSecurePressed: () => context
                            .read<SignUpBloc>()
                            .add(SignUpChangeSecure()),
                        changeSecureIcon: changeSecureIcon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ButtonUtil.buildCommonButton(
                        context,
                        onPressed: () =>
                            context.read<SignUpBloc>().add(SignUpSibmitted()),
                        buttonText: 'Sign Up',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
