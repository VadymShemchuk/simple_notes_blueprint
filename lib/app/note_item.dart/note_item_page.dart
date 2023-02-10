import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/app/navigator_status.dart';
import 'package:simple_notes_blueprint/app/note_item.dart/bloc/note_item_bloc.dart';
import 'package:simple_notes_blueprint/app/note_item.dart/note_item_view.dart';

class _Constants {
  static const errorNote = 'Make some note, and than save it.';
  static const errorPhoto = 'Photo, not added.';
}

class NoteItemPage extends StatelessWidget {
  const NoteItemPage({Key? key}) : super(key: key);

  static const route = '/note_item';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteItemBloc, NoteItemState>(
      builder: (context, state) => NoteItemView(
        image: state.photo,
        status: state.status,
      ),
      listener: (_, state) {
        if (state.status is OnNotesList) {
          Navigator.of(context).pop();
        } else if (state.status is OnNoteIsEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(_Constants.errorNote),
              ),
            );
        } else if (state.status is FailurePhoto) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(_Constants.errorPhoto),
              ),
            );
        }
      },
    );
  }
}
