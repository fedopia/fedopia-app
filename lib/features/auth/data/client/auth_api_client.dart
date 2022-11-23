import 'package:dio/dio.dart';
import 'package:fedopia/features/auth/data/client/auth_endpoints.dart';
import 'package:fedopia/features/auth/data/entities/account_entity.dart';
import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';
import 'package:retrofit/retrofit.dart' as rf;

part 'auth_api_client.g.dart';

@rf.RestApi()
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  /// Create a new client application.
  @rf.POST(AuthEndpoints.createClientApp)
  Future<ClientAppEntity> createClientApp({
    @rf.Field('client_name') required String clientName,
    @rf.Field('redirect_uris') required String redirectUris,
    @rf.Field('scopes') String? scopes,
    @rf.Field('website') String? website,
  });

  /// Verify user credentials
  @rf.GET(AuthEndpoints.verifyCredentials)
  Future<AccountEntity> verifyCredentials({
    @rf.Header('Authorization') required String authorization,
  });
}
