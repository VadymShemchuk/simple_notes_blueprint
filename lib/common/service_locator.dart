import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_notes_blueprint/app/root/bloc/root_bloc.dart';
import 'package:simple_notes_blueprint/common/models/user_model.dart';
import 'package:simple_notes_blueprint/common/repository/auth_repository.dart';
import 'package:simple_notes_blueprint/common/repository/notes_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  initInstance();
  initRepositories();
  initRoot();
}

void initInstance() {
  serviceLocator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  serviceLocator.registerSingleton<UserModel>(UserModel.unAuthenticated);
  serviceLocator.registerSingleton<FirebaseStorage>(FirebaseStorage.instanceFor(
      bucket: "gs://simple-notes-blueprint.appspot.com"));
  serviceLocator
      .registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
}

initRepositories() {
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplementation(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImplementation(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );
}

initRoot() {
  serviceLocator.registerLazySingleton<RootBloc>(
    () => RootBloc(
      serviceLocator(),
    ),
  );
}
