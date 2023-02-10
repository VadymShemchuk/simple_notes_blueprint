import 'package:flutter/material.dart';
import 'package:simple_notes_blueprint/app/notes_list.dart/bloc/notes_bloc.dart';
import 'package:simple_notes_blueprint/app/notes_list.dart/note_item_widget.dart';
import 'package:simple_notes_blueprint/common/models/note_model.dart';
import 'package:simple_notes_blueprint/utils/button_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _Constants {
  static const createNote = 'Create Note';
}

class NotesListView extends StatelessWidget {
  const NotesListView({super.key, required this.notes});

  final List<NoteModel> notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 200,
                child: ButtonUtil.buildCommonButton(
                  context,
                  onPressed: () => context.read<NotesBloc>().add(OnNoteItem()),
                  buttonText: _Constants.createNote,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(notes[index].noteId),
                      onDismissed: (_) => context
                          .read<NotesBloc>()
                          .add(RemoveNote(notes[index].noteId)),
                      child: NoteItemWidget(
                        text: notes[index].noteText,
                        title: notes[index].noteTitle,
                        date: notes[index].noteDate,
                        url: notes[index].photoUrl,
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
