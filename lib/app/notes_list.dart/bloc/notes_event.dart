part of 'notes_bloc.dart';

abstract class NotesEvent {}

class UploadNotes extends NotesEvent {}

class OnNoteItem extends NotesEvent {}

class RemoveNote extends NotesEvent {
  final String noteId;

  RemoveNote(this.noteId);
}

class AddNote extends NotesEvent {
  final NoteModel note;

  AddNote(this.note);
}
