part of 'note_item_bloc.dart';

class NoteItemState {
  final File? photo;
  final NavigatorStatus status;

  NoteItemState({
    this.photo,
    required this.status,
  });

  NoteItemState copyWith({
    File? photo,
    required NavigatorStatus status,
  }) {
    return NoteItemState(
      photo: photo ?? this.photo,
      status: status,
    );
  }
}
