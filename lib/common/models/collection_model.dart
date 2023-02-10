import 'package:simple_notes_blueprint/common/models/note_model.dart';

class _Keys {
  static const collectionIdKey = 'collectionId';
  static const collectionNotesKey = 'collectionNotes';
}

class CollectionModel {
  final String collectionId;
  final List<NoteModel> collectionNotes;

  CollectionModel(
    this.collectionId,
    this.collectionNotes,
  );

  Map<String, dynamic> toMap() => {
        _Keys.collectionIdKey: collectionId,
        _Keys.collectionNotesKey: collectionNotes,
      };
}
