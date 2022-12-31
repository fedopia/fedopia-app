import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fedopia/core/data/router.dart';
import 'package:fedopia/features/auth/domain/domain.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Instance instance;
  final AuthUseCase _authUseCase;

  AuthBloc({required AuthUseCase authUseCase, required this.instance})
      : _authUseCase = authUseCase,
        super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthStartedWithCode>(_onAuthStartedWithCode);
  }

  void _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());

    final response = await _authUseCase.requestAuthorization(
      instance: instance,
    );
    response.fold((l) => emit(AuthFailure(l.name)), (r) => emit(AuthInitial()));
  }

  void _onAuthStartedWithCode(
    AuthStartedWithCode event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());

    final response = await _authUseCase.verifyAuthorizationCode(
      code: event.code,
      instance: instance,
    );
    response.fold(
      (l) => emit(AuthFailure(l.name)),
      (r) {
        emit(AuthInitial());
        FedopiaRouter.router.go(FedopiaRouter.home);
      },
    );
  }
}
