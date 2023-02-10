import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/app/navigator_status.dart';
import 'package:simple_notes_blueprint/common/models/note_model.dart';
import 'package:simple_notes_blueprint/common/repository/notes_repository.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _notesRepository;

  NotesBloc(this._notesRepository) : super(NotesLoading()) {
    on<UploadNotes>(_onUploadNotes);
    on<OnNoteItem>(_onNoteItem);
    on<RemoveNote>(_onRemoveNote);
    on<AddNote>(_onAddNote);
  }

  List<NoteModel> notes = [];

  void _onUploadNotes(
    UploadNotes event,
    Emitter<NotesState> emit,
  ) async {
    final notesList = await _notesRepository.getCollection();
    notes.addAll(notesList);
    emit(NotesLoaded(
      notes: notes,
      status: const InitialNavigatorStatus(),
    ));
  }

  void _onNoteItem(
    OnNoteItem event,
    Emitter<NotesState> emit,
  ) {
    emit(NotesLoaded(
      notes: notes,
      status: OnNoteDetailed(),
    ));
  }

  void _onRemoveNote(
    RemoveNote event,
    Emitter<NotesState> emit,
  ) {
    List<NoteModel> noteForRemove = [];
    for (var note in notes) {
      if (note.noteId == event.noteId) {
        noteForRemove.add(note);
        _notesRepository.removeNote(note);
      }
    }
    notes.removeWhere(
      (e) => noteForRemove.contains(e),
    );
    emit(NotesLoaded(
      notes: notes,
      status: const InitialNavigatorStatus(),
    ));
  }

  void _onAddNote(
    AddNote event,
    Emitter<NotesState> emit,
  ) {
    notes.add(event.note);
    emit(NotesLoaded(
      notes: notes,
      status: const InitialNavigatorStatus(),
    ));
  }
}
