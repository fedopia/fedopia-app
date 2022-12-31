part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthStartedWithCode extends AuthEvent {
  final String code;

  const AuthStartedWithCode({required this.code});

  @override
  List<Object> get props => [code];
}

class LoginPressed extends AuthEvent {}
