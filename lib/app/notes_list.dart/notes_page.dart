import 'package:flutter/material.dart';
import 'package:simple_notes_blueprint/app/navigator_status.dart';
import 'package:simple_notes_blueprint/app/note_item.dart/note_item_page.dart';
import 'package:simple_notes_blueprint/app/notes_list.dart/bloc/notes_bloc.dart';
import 'package:simple_notes_blueprint/app/notes_list.dart/notes_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/utils/loader_util.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({Key? key}) : super(key: key);

  static const route = '/notes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: BlocConsumer<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoaded) {
            return NotesListView(
              notes: state.notes,
            );
          } else if (state is NotesLoading) {
            context.read<NotesBloc>().add(UploadNotes());
            return LoaderUtil.buildLoader();
          } else {
            return LoaderUtil.buildLoader();
          }
        },
        listener: (_, state) {
          if (state is NotesLoading) {
          } else if (state is NotesLoaded) {
            if (state.status is OnNoteDetailed) {
              Navigator.of(context).pushNamed(NoteItemPage.route);
            } else if (state.status is FailureAuth) {
              String? error = (state.status as FailureAuth).error;
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(error)));
            }
          }
        },
      ),
    );
  }
}
