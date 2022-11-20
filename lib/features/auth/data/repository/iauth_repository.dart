import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';

abstract class IAuthRepository {
  /// Create a new client application.
  Future<ClientAppEntity> createClientApp({
    required String clientName,
    required String redirectUris,
    String? scopes,
    String? website,
  });

  /// Get an authorization code
  /// The authorization code will be returned as a query parameter named code
  /// in the redirect URI.
  Future<void> authorize({
    required String clientId,
    required String redirectUri,
    String? scope,
    String? responseType,
  });
}
