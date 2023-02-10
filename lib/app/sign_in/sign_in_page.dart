import 'package:flutter/material.dart';
import 'package:simple_notes_blueprint/app/navigator_status.dart';
import 'package:simple_notes_blueprint/app/notes_list.dart/notes_page.dart';
import 'package:simple_notes_blueprint/app/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/app/sign_in/sign_in_view.dart';
import 'package:simple_notes_blueprint/app/sign_up/sign_up_page.dart';
import 'package:simple_notes_blueprint/common/service_locator.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  static const route = '/signIn';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(
        serviceLocator(),
      ),
      child: BlocConsumer<SignInBloc, SignInState>(
        builder: (context, state) => SignInView(
          emailError: state.emailError,
          passwordError: state.passwordError,
          changeSecureIcon: state.changeSecureIcon,
          isEmailValid: state.isEmailValid,
          isPasswordValid: state.isPasswordValid,
          status: state.status,
        ),
        listenWhen: (previous, current) =>
            previous.status is! FailureAuth || current.status is OnSignUp,
        listener: (_, state) {
          if (state.status is Success) {
            Navigator.of(context).pushNamed(NotesListPage.route);
          } else if (state.status is FailureAuth) {
            String error = (state.status as FailureAuth).error;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(error)));
          } else if (state.status is OnSignUp) {
            Navigator.of(context).pushNamed(SignUpPage.route);
          }
        },
      ),
    );
  }
}
