import 'package:fedopia/core/data/constants/app_constants.dart';
import 'package:fedopia/features/auth/data/client/auth_api_client.dart';
import 'package:fedopia/features/auth/data/constants/auth_scope_constants.dart';
import 'package:fedopia/features/auth/data/client/auth_client.dart';
import 'package:fedopia/features/auth/data/entities/account_entity.dart';
import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';
import 'package:fedopia/features/auth/data/entities/token_entity.dart';
import 'package:fedopia/features/auth/data/repository/iauth_repository.dart';
import 'package:fedopia/features/auth/data/vaults/account_vault.dart';
import 'package:fedopia/features/auth/data/vaults/client_app_vault.dart';

class AuthRepository implements IAuthRepository {
  final AuthClient _authClient;
  final AuthApiClient _authApiClient;

  AuthRepository(this._authClient, this._authApiClient);

  @override
  Future<ClientAppEntity> createClientApp({
    required String clientName,
    required String redirectUris,
    String? scopes = AuthScopeConstants.all,
    String? website = AppConstants.websiteUrl,
  }) async {
    final clientApp = await _authApiClient.createClientApp(
      clientName: clientName,
      redirectUris: redirectUris,
      scopes: scopes,
      website: website,
    );
    return clientApp;
  }

  /// Obtain access token
  /// https://docs.joinmastodon.org/methods/apps/oauth/
  @override
  Future<TokenEntity> obtainAccessToken({
    required String clientId,
    required String clientSecret,
    required String redirectUri,
    required String code,
    required String grantType,
    String? scope,
  }) async {
    final token = await _authClient.obtainAccessToken(
      clientId: clientId,
      clientSecret: clientSecret,
      redirectUri: redirectUri,
      code: code,
      grantType: grantType,
      scope: scope,
    );
    return token;
  }

  @override
  Future<void> persistAccount(AccountEntity account) async {
    await AccountVault.addAccount(account);
  }

  @override
  Future<AccountEntity?> getLocalAccount(String identifier) async {
    final account = await AccountVault.getAccount(identifier);
    return account;
  }

  @override
  Future<AccountEntity?> verifyCredentials(String accessToken) async {
    final account = await _authApiClient.verifyCredentials(
      authorization: 'Bearer $accessToken',
    );
    return account;
  }

  @override
  Future<void> persistClientApp(ClientAppEntity clientApp) async {
    await ClientAppVault.addClientApp(clientApp);
  }

  @override
  Future<ClientAppEntity?> getLocalClientApp(String identifier) async {
    final clientApp = await ClientAppVault.getClientApp(identifier);
    return clientApp;
  }
}
