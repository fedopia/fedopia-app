import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fedopia/core/data/constants/app_constants.dart';
import 'package:fedopia/features/auth/data/client/auth_errors.dart';
import 'package:fedopia/features/auth/data/constants/auth_client_constants.dart';
import 'package:fedopia/features/auth/data/constants/auth_scope_constants.dart';
import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';
import 'package:fedopia/features/auth/data/entities/token_entity.dart';
import 'package:fedopia/features/auth/data/repository/iauth_repository.dart';
import 'package:fedopia/features/auth/domain/domain.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  /// Requests authorization from the instance.
  /// First creates a client app if needed, then opens the authorization page.
  /// Also saves the client app to the local storage.
  /// @param instance The instance to request authorization from.
  /// @return Either a [AuthError] or [null].
  Future<Either<AuthError, void>> requestAuthorization({
    required Instance instance,
  }) async {
    final redirectUri = '${AuthClientConstants.redirectUri}/${instance.host}';

    ClientAppEntity? clientAppEntity;
    clientAppEntity = await _authRepository.getLocalClientApp(redirectUri);
    if (clientAppEntity == null) {
      try {
        clientAppEntity = await _authRepository.createClientApp(
          clientName: AppConstants.name,
          redirectUris: redirectUri,
          scopes: AuthScopeConstants.all,
          website: AppConstants.websiteUrl,
        );
        await _authRepository.persistClientApp(clientAppEntity);
      } on DioError catch (e) {
        log(e.message);
        return const Left(AuthError.clientAppCreateFailure);
      } catch (e) {
        log(e.toString());
        return const Left(AuthError.clientAppCreateFailure);
      }
    }

    final clientApp = ClientAppTranslator.toModel(clientAppEntity);
    final uri = instance.getAuthorizeUriFromClientApp(clientApp);
    if (Platform.isIOS) {
      // on ios, we need to call CloseInAppBrowser to close the browser
      // and only url_launcher can do that. iOS already provides in app browser
      // like custom tabs on Android.
      await url_launcher.launchUrl(uri);
    } else {
      await custom_tabs.launch(uri.toString());
    }
    return const Right(null);
  }

  /// Verify the authorization code and get the access token.
  /// @param code The authorization code.
  /// @param instance The instance to verify the code.
  /// @return Either a [AuthError] or [Account].
  Future<Either<AuthError, Account>> verifyAuthorizationCode({
    required String code,
    required Instance instance,
  }) async {
    final redirectUri = '${AuthClientConstants.redirectUri}/${instance.host}';
    final clientAppEntity =
        await _authRepository.getLocalClientApp(redirectUri);
    if (clientAppEntity == null) {
      return const Left(AuthError.clientAppNotFound);
    }

    TokenEntity tokenEntity;
    try {
      tokenEntity = await _authRepository.obtainAccessToken(
        code: code,
        clientId: clientAppEntity.clientId,
        clientSecret: clientAppEntity.clientSecret,
        redirectUri: redirectUri,
        grantType: AuthClientConstants.grantType,
        scope: AuthScopeConstants.all,
      );
    } on DioError catch (e) {
      log(e.message);
      return const Left(AuthError.obtainAccessTokenFailure);
    } catch (e) {
      log(e.toString());
      return const Left(AuthError.obtainAccessTokenFailure);
    }

    // get remote account
    final accountEntity = await _authRepository.verifyCredentials(
      tokenEntity.accessToken,
    );

    if (accountEntity == null) {
      return const Left(AuthError.verifyCredentialsFailure);
    }

    final updatedAccountEntity = accountEntity.copyWith(
      instance: InstanceTranslator.toEntity(instance),
      clientApp: clientAppEntity,
      token: tokenEntity,
    );

    await _authRepository.persistAccount(updatedAccountEntity);

    return Right(AccountTranslator.toModel(updatedAccountEntity));
  }
}
