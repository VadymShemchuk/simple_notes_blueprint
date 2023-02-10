import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/app/note_item.dart/bloc/note_item_bloc.dart';
import 'package:simple_notes_blueprint/app/notes_app.dart';
import 'package:simple_notes_blueprint/app/notes_list.dart/bloc/notes_bloc.dart';
import 'package:simple_notes_blueprint/app/root/bloc/root_bloc.dart';

import '../common/service_locator.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => RootBloc(
          serviceLocator(),
        ),
      ),
      BlocProvider(
        create: (context) => NotesBloc(
          serviceLocator(),
        ),
      ),
      BlocProvider(
          create: (context) => NoteItemBloc(
                serviceLocator(),
                context.read(),
              ))
    ], child: const NotesApp());
  }
}
