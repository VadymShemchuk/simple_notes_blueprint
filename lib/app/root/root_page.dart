import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/app/notes_list.dart/notes_page.dart';
import 'package:simple_notes_blueprint/app/root/bloc/root_bloc.dart';
import 'package:simple_notes_blueprint/app/sign_in/sign_in_page.dart';
import 'package:simple_notes_blueprint/common/service_locator.dart';
import 'package:simple_notes_blueprint/utils/loader_util.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => RootBloc(
          serviceLocator(),
        )..add(UnknownAuthorization()),
        child: BlocConsumer<RootBloc, RootState>(
          builder: (_, state) => LoaderUtil.buildLoader(),
          listener: (_, state) {
            if (state is Authenticated) {
              Navigator.of(context).pushReplacementNamed(NotesListPage.route);
            } else if (state is AuthenticationRequired) {
              Navigator.of(context).pushReplacementNamed(SignInPage.route);
            }
          },
        ),
      ),
    );
  }
}
