import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fedopia/features/auth/data/repository/iauth_repository.dart';
import 'package:fedopia/features/auth/domain/model/instance.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<InstanceSelected>(_onInstanceSelected);
  }

  void _onInstanceSelected(
      InstanceSelected event, Emitter<AuthState> emit) async {
    // create app
    final clientApp = await _authRepository.createClientApp();
    emit(AuthInstanceSelectSuccess(event.instance));
  }
}
