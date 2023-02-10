part of 'root_bloc.dart';

abstract class RootState {}

class Loading extends RootState {}

class AuthenticationRequired extends RootState {}

class Authenticated extends RootState {}
