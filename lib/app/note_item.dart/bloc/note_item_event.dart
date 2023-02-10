part of 'note_item_bloc.dart';

@immutable
abstract class NoteItemEvent {}

class NoteTitleChanged extends NoteItemEvent {
  final String title;

  NoteTitleChanged(this.title);
}

class NoteTextChanged extends NoteItemEvent {
  final String text;

  NoteTextChanged(this.text);
}

class AddPhotoToNote extends NoteItemEvent {}

class SaveNote extends NoteItemEvent {}

class BackToList extends NoteItemEvent {}
