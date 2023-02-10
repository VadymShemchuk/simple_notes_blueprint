part of 'notes_bloc.dart';

abstract class NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  List<NoteModel> notes;
  final NavigatorStatus status;

  NotesLoaded({
    required this.notes,
    required this.status,
  });
}
