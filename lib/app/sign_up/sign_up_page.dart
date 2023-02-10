import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/app/navigator_status.dart';
import 'package:simple_notes_blueprint/app/notes_list.dart/notes_page.dart';
import 'package:simple_notes_blueprint/app/sign_up/bloc/sign_up_bloc.dart';
import 'package:simple_notes_blueprint/app/sign_up/sign_up_view.dart';
import 'package:simple_notes_blueprint/common/service_locator.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const route = '/SignUp';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(
        serviceLocator(),
      ),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        builder: (_, state) => SignUpView(
          emailError: state.emailError,
          passwordError: state.passwordError,
          changeSecureIcon: state.changeSecureIcon,
          isEmailValid: state.isEmailValid,
          isPasswordValid: state.isPasswordValid,
        ),
        listenWhen: (previous, current) => previous.status is! FailureAuth,
        listener: (_, state) {
          if (state.status is Success) {
            Navigator.of(context).pushReplacementNamed(NotesListPage.route);
          } else if (state.status is FailureAuth) {
            String error = (state.status as FailureAuth).error;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(error)));
          } else if (state.status is OnSignIn) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
