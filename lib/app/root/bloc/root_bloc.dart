import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/common/models/user_model.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final UserModel _model;

  RootBloc(
    this._model,
  ) : super(Loading()) {
    on<UnknownAuthorization>(_getUser);
  }

  void _getUser(
    UnknownAuthorization event,
    Emitter<RootState> emit,
  ) {
    if (_model.isAuthenticated) {
      emit(Authenticated());
    } else {
      emit(AuthenticationRequired());
    }
  }
}
