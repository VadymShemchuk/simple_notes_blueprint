class UserModel {
  final String email;
  final String id;

  const UserModel({
    required this.email,
    required this.id,
  });

  static const unAuthenticated = UserModel(
    email: '',
    id: '',
  );

  UserModel copyWith({
    required String id,
    required String email,
  }) =>
      UserModel(
        email: email,
        id: id,
      );

  bool get isUnauthenticated => this == UserModel.unAuthenticated;

  bool get isAuthenticated => this != UserModel.unAuthenticated;
}
