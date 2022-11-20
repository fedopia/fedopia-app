import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fedopia/core/constants/app_constants.dart';
import 'package:fedopia/features/auth/data/client/auth_scopes.dart';
import 'package:fedopia/features/auth/data/client/errors.dart';
import 'package:fedopia/features/auth/data/client/auth_client.dart';
import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';
import 'package:fedopia/features/auth/data/repository/iauth_repository.dart';

class AuthRepository implements IAuthRepository {
  final AuthClient _authClient;

  AuthRepository(this._authClient);

  @override
  Future<Either<AuthFailure, ClientAppEntity>> createClientApp({
    String clientName = kAppTitle,
    String redirectUris = kAppAuthRedirectUrl,
    String? scopes = kAuthScopesAll,
    String? website = kAppWebsiteUrl,
  }) async {
    try {
      final clientApp = await _authClient.createClientApp(
        clientName: clientName,
        redirectUris: redirectUris,
        scopes: scopes,
        website: website,
      );
      return Right(clientApp);
    } on DioError catch (e) {
      log(e.toString());
      // TODO: Better error handling
      return const Left(AuthFailure.serverFailure);
    }
  }

  /// Get an authorization code
  /// The authorization code will be returned as a query parameter named code
  /// in the redirect URI.
  @override
  Future<void> authorize({
    required String clientId,
    String redirectUri = kAppAuthRedirectUrl,
    String? scope = kAuthScopesAll,
    String? responseType = 'code',
  }) async {
    //
  }
}
