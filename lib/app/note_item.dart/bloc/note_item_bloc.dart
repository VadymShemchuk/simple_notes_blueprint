import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_notes_blueprint/app/navigator_status.dart';
import 'package:simple_notes_blueprint/app/notes_list.dart/bloc/notes_bloc.dart';
import 'package:path/path.dart' as p;

import 'package:simple_notes_blueprint/common/models/note_model.dart';
import 'package:simple_notes_blueprint/common/repository/notes_repository.dart';
import 'package:simple_notes_blueprint/utils/date_util.dart';
import 'package:simple_notes_blueprint/utils/image_picker_utile.dart';
import 'package:simple_notes_blueprint/utils/token_util.dart';

part 'note_item_event.dart';
part 'note_item_state.dart';

class NoteItemBloc extends Bloc<NoteItemEvent, NoteItemState> {
  final NotesRepository _notesRepository;
  final NotesBloc _notesBloc;
  NoteItemBloc(
    this._notesRepository,
    this._notesBloc,
  ) : super(NoteItemState(status: const InitialNavigatorStatus())) {
    on<NoteTitleChanged>(_onNoteTitleChanged);
    on<NoteTextChanged>(_onNoteTextChanged);
    on<AddPhotoToNote>(_onAddPhotoToNote);
    on<SaveNote>(_onSaveNote);
    on<BackToList>(_onBackToList);
  }

  String noteTitle = '';
  String noteText = '';
  bool isNoteEmpty = true;
  File? image;

  void _onNoteTitleChanged(
    NoteTitleChanged event,
    Emitter<NoteItemState> emit,
  ) {
    if (event.title != '') {
      isNoteEmpty = false;
      noteTitle = event.title;
    } else {
      isNoteEmpty = true;
      noteTitle = event.title;
    }
  }

  void _onNoteTextChanged(
    NoteTextChanged event,
    Emitter<NoteItemState> emit,
  ) {
    if (event.text != '') {
      isNoteEmpty = false;
      noteText = event.text;
    } else {
      isNoteEmpty = true;
      noteText = event.text;
    }
  }

  void _onAddPhotoToNote(
    AddPhotoToNote event,
    Emitter<NoteItemState> emit,
  ) async {
    final imageFile = await ImagePickerUtil.getImageFrom(ImageSource.gallery);
    if (imageFile != null) {
      image = imageFile;
      emit(state.copyWith(
        status: SuccessPhoto(),
        photo: imageFile,
      ));
    } else {
      emit(
        NoteItemState(
          status: FailurePhoto(),
        ),
      );
    }
  }

  void _onSaveNote(
    SaveNote event,
    Emitter<NoteItemState> emit,
  ) async {
    if (isNoteEmpty) {
      emit(
        state.copyWith(
          status: OnNoteIsEmpty(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: Progress(),
        ),
      );
      final note = NoteModel(
        noteId: TokenUtil.generateToken(),
        noteTitle: noteTitle,
        noteText: noteText,
        noteDate: DateUtil.getFormatedDate(),
        photoUrl: null,
        photoName: null,
      );
      final url = await _notesRepository.saveNote(
        image,
        note,
      );

      String? photoName;
      if (url != null) {
        photoName = p.basename(image!.path);
      }
      final noteDefine = note.copyWith(
        photoUrl: url,
        photoName: photoName,
      );
      _notesBloc.add(AddNote(noteDefine));

      emit(NoteItemState(
        status: OnNotesList(),
        photo: null,
      ));
    }
  }

  void _onBackToList(
    BackToList event,
    Emitter<NoteItemState> emit,
  ) {
    emit(NoteItemState(status: OnNotesList()));
  }
}
