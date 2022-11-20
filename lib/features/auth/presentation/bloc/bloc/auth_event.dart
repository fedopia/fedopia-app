part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class InstanceSelected extends AuthEvent {
  final Instance instance;

  const InstanceSelected(this.instance);

  @override
  List<Object> get props => [instance];
}
