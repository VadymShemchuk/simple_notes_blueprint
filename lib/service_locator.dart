import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_notes_blueprint/common/models/user_model.dart';
import 'package:simple_notes_blueprint/common/repository/auth_repository.dart';

final serviceLocator = GetIt.instance;

void init() {
  initInstance();
  initAuthRepository();
}

void initInstance() {
  serviceLocator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  serviceLocator.registerSingleton<UserModel>(UserModel.unAuthenticated);
}

initAuthRepository() {
  serviceLocator.registerLazySingleton<AuthRepositoryImplementation>(
      () => AuthRepositoryImplementation(
            serviceLocator(),
            serviceLocator(),
          ));
}
