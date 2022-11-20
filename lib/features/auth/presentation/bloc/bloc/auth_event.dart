part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class LoginPressed extends AuthEvent {
  const LoginPressed();

  @override
  List<Object> get props => [];
}
