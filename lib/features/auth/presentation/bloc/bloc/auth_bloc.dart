import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fedopia/features/auth/domain/model/instance.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<InstanceSelected>(_onInstanceSelected);
  }

  void _onInstanceSelected(InstanceSelected event, Emitter<AuthState> emit) {
    emit(AuthInstanceSelectSuccess(event.instance));
  }
}
