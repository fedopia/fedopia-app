import 'package:fedopia/features/auth/data/entities/account_entity.dart';
import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';
import 'package:fedopia/features/auth/data/entities/token_entity.dart';

abstract class IAuthRepository {
  /// Create a new client application.
  Future<ClientAppEntity> createClientApp({
    required String clientName,
    required String redirectUris,
    String? scopes,
    String? website,
  });

  /// Obtain access token
  /// https://docs.joinmastodon.org/methods/apps/oauth/
  Future<TokenEntity> obtainAccessToken({
    required String clientId,
    required String clientSecret,
    required String redirectUri,
    required String code,
    required String grantType,
    String? scope,
  });

  /// Persist account
  Future<void> persistAccount(AccountEntity account);

  /// Get local account
  Future<AccountEntity?> getLocalAccount(String identifier);

  /// Verify user credentials
  Future<AccountEntity?> verifyCredentials(String accessToken);

  /// Persist client app
  Future<void> persistClientApp(ClientAppEntity clientApp);

  /// Get client app
  Future<ClientAppEntity?> getLocalClientApp(String identifier);
}
