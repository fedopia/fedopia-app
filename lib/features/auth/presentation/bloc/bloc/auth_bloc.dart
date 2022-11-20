import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fedopia/core/constants/app_constants.dart';
import 'package:fedopia/features/auth/domain/constants/auth_scopes_constants.dart';
import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';
import 'package:fedopia/features/auth/data/repository/iauth_repository.dart';
import 'package:fedopia/features/auth/domain/model/instance.dart';
import 'package:url_launcher/url_launcher.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Instance instance;
  final IAuthRepository authRepository;

  AuthBloc({
    required this.authRepository,
    required this.instance,
  }) : super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
  }

  void _onAuthStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());

    ClientAppEntity? clientApp;
    // get or create app
    try {
      clientApp = await authRepository.createClientApp(
        clientName: kAppName,
        redirectUris: kAppAuthRedirectUri,
        scopes: kAuthScopesAll,
        website: kAppWebsiteUrl,
      );
      log(clientApp.toJson().toString());
    } on DioError catch (e) {
      // TODO: Better error handling
      log(e.toString());
      emit(AuthFailure(e.message));
      return;
    }

    // initiate in-app browser
    final url = instance.authorizeUriFromClientApp(clientApp);
    if (!await launchUrl(url)) {
      emit(const AuthFailure(
          'Failed to launch in-app browser for authorization'));
    }
  }
}
