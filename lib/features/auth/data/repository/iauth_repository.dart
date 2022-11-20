import 'package:dartz/dartz.dart';
import 'package:fedopia/features/auth/data/client/errors.dart';
import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';

abstract class IAuthRepository {
  /// Create a new client application.
  Future<Either<AuthFailure, ClientAppEntity>> createClientApp({
    String clientName,
    String redirectUris,
    String? scopes,
    String? website,
  });

  /// Get an authorization code
  /// The authorization code will be returned as a query parameter named code
  /// in the redirect URI.
  Future<void> authorize({
    String clientId,
    String redirectUri,
    String? scope,
    String? responseType,
  });
}
