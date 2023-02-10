import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_notes_blueprint/common/models/user_model.dart';

abstract class AuthRepository {
  Future<bool> signUp(
    String email,
    String password,
  );

  Future<bool> signIn(
    String email,
    String password,
  );

  UserModel? getUser();

  signOut();
}

class AuthRepositoryImplementation implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final UserModel _user;

  AuthRepositoryImplementation(
    this._firebaseAuth,
    this._user,
  );

  @override
  Future<bool> signUp(
    String email,
    String password,
  ) async {
    bool isSignUp = false;
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null && user.email != null) {
        _user.copyWith(
          id: user.uid,
          email: user.email!,
        );
        isSignUp = true;
      }
      return isSignUp;
    } on FirebaseAuthException catch (e) {
      RepositoryFailExeption.copyWith(e.message);
      isSignUp = false;
    } catch (_) {
      RepositoryFailExeption();
      isSignUp = false;
    }
    return isSignUp;
  }

  @override
  Future<bool> signIn(
    String email,
    String password,
  ) async {
    bool isSignIn = false;
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null && user.email != null) {
        _user.copyWith(
          id: user.uid,
          email: user.email!,
        );
        isSignIn = true;
      }
      return isSignIn;
    } on FirebaseAuthException catch (e) {
      throw RepositoryFailExeption.copyWith(e.message);
    } catch (_) {
      throw RepositoryFailExeption();
    }
  }

  @override
  signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  UserModel? getUser() {
    final user = _firebaseAuth.currentUser;
    if (user != null && user.email != null) {
      return _user.copyWith(
        id: user.uid,
        email: user.email!,
      );
    } else {
      return null;
    }
  }
}

class RepositoryFailExeption implements Exception {
  final String? message;

  RepositoryFailExeption([this.message = 'An unknown exception occurred.']);

  factory RepositoryFailExeption.copyWith(String? message) {
    return RepositoryFailExeption(message);
  }
}
