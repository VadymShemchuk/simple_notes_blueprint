import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:simple_notes_blueprint/common/models/note_model.dart';
import 'package:simple_notes_blueprint/common/repository/auth_repository.dart';

class _Constants {
  static const firestoreNotesCollection = 'notes';
  static const firestoreListName = 'data';
  static const storagePath = 'images/';
}

abstract class NotesRepository {
  Future<String?> saveNote(
    File? image,
    NoteModel note,
  );

  void removeNote(
    NoteModel note,
  );

  Future<List<NoteModel>> getCollection();
}

class NotesRepositoryImplementation implements NotesRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;
  final AuthRepository _authRepository;

  NotesRepositoryImplementation(
    this._firebaseFirestore,
    this._firebaseStorage,
    this._authRepository,
  );

  @override
  Future<String?> saveNote(
    File? image,
    NoteModel note,
  ) async {
    String? url;
    String? photoName;
    try {
      if (image != null) {
        url = await _setImageFrom(image);
        photoName = p.basename(image.path);
      }

      final noteDefine = note.copyWith(
        photoUrl: url,
        photoName: photoName,
      );

      final user = _authRepository.getUser();
      if (user != null) {
        final document = await _firebaseFirestore
            .collection(_Constants.firestoreNotesCollection)
            .doc(user.id)
            .get();
        if (document.exists) {
          await _firebaseFirestore
              .collection(_Constants.firestoreNotesCollection)
              .doc(user.id)
              .update({
            _Constants.firestoreListName:
                FieldValue.arrayUnion([noteDefine.toMap()])
          });
        } else {
          await _firebaseFirestore
              .collection(_Constants.firestoreNotesCollection)
              .doc(user.id)
              .set({
            _Constants.firestoreListName:
                FieldValue.arrayUnion([noteDefine.toMap()])
          });
        }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return url;
  }

  @override
  Future<void> removeNote(NoteModel note) async {
    final user = _authRepository.getUser();
    if (user != null) {
      final document = await _firebaseFirestore
          .collection(_Constants.firestoreNotesCollection)
          .doc(user.id)
          .get();
      if (document.exists) {
        await _firebaseFirestore
            .collection(_Constants.firestoreNotesCollection)
            .doc(user.id)
            .update({
          _Constants.firestoreListName: FieldValue.arrayRemove([note.toMap()])
        });
        if (note.photoName != null) {
          Reference reference = _firebaseStorage
              .ref()
              .child('${_Constants.storagePath}${note.photoName}');
          reference.delete();
        }
      }
    }
  }

  Future<String?> _setImageFrom(File image) async {
    String? url;
    try {
      final directory = await getApplicationDocumentsDirectory();
      final user = _authRepository.getUser();
      final path = '${directory.path}/${p.basename(image.path)}';
      final fileDefine = await File(path).create(recursive: true);
      final uploadFile = await fileDefine.writeAsBytes(image.readAsBytesSync());
      if (user != null) {
        Reference reference = _firebaseStorage
            .ref()
            .child('${_Constants.storagePath}${p.basename(image.path)}');
        UploadTask uploadTask = reference.putFile(uploadFile);
        await uploadTask
            .whenComplete(() async => url = await reference.getDownloadURL());
      }

      return url;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return url;
  }

  @override
  Future<List<NoteModel>> getCollection() async {
    final user = _authRepository.getUser();
    List<NoteModel> notes = [];

    if (user != null) {
      final document = await _firebaseFirestore
          .collection(_Constants.firestoreNotesCollection)
          .doc(user.id)
          .get();

      if (document.exists) {
        final List<dynamic>? notesList =
            document.data()?[_Constants.firestoreListName];
        if (notesList != null) {
          for (var json in notesList) {
            final note = NoteModel.fromJson(json);
            notes.add(note);
          }
        }
      }
    }

    return notes;
  }
}
