class _Keys {
  static const noteIdKey = 'noteIdKey';
  static const noteTitleKey = 'noteTitle';
  static const noteTextKey = 'noteText';
  static const noteDateKey = 'noteDate';
  static const photoUrlKey = 'photoUrl';
  static const photoNameKey = 'photoName';
}

class NoteModel {
  final String noteId;
  final String noteTitle;
  final String noteText;
  final String noteDate;
  final String? photoUrl;
  final String? photoName;

  const NoteModel({
    required this.noteId,
    required this.noteTitle,
    required this.noteText,
    required this.noteDate,
    required this.photoUrl,
    required this.photoName,
  });

  NoteModel copyWith({
    String? noteTitle,
    String? noteText,
    String? noteDate,
    String? photoUrl,
    String? photoName,
  }) =>
      NoteModel(
        noteId: noteId,
        noteTitle: noteTitle ?? this.noteTitle,
        noteText: noteText ?? this.noteText,
        noteDate: noteDate ?? this.noteDate,
        photoUrl: photoUrl,
        photoName: photoName,
      );

  Map<String, dynamic> toMap() => {
        _Keys.noteIdKey: noteId,
        _Keys.noteTitleKey: noteTitle,
        _Keys.noteTextKey: noteText,
        _Keys.noteDateKey: noteDate,
        _Keys.photoUrlKey: photoUrl,
        _Keys.photoNameKey: photoName,
      };

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        noteId: json[_Keys.noteIdKey],
        noteTitle: json[_Keys.noteTitleKey],
        noteText: json[_Keys.noteTextKey],
        noteDate: json[_Keys.noteDateKey],
        photoUrl: json[_Keys.photoUrlKey],
        photoName: json[_Keys.photoNameKey],
      );
}
