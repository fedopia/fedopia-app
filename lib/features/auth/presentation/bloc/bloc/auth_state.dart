part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthInstanceSelectSuccess extends AuthState {
  final Instance instance;

  const AuthInstanceSelectSuccess(this.instance);

  @override
  List<Object> get props => [instance];
}
