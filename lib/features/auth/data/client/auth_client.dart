import 'package:dio/dio.dart';
import 'package:fedopia/core/constants/app_constants.dart';
import 'package:fedopia/features/auth/data/client/auth_endpoints.dart';
import 'package:fedopia/features/auth/data/client/auth_scopes.dart';
import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';
import 'package:retrofit/retrofit.dart' as rf;
import 'package:retrofit/retrofit.dart' show HttpResponse;

part 'auth_client.g.dart';

@rf.RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _IAuthClient;

  /// Create a new client application.
  @rf.POST(AuthEndpoints.createClientApp)
  Future<ClientAppEntity> createClientApp({
    @rf.Field('client_name') required String clientName,
    @rf.Field('redirect_uris') required String redirectUris,
    @rf.Field('scopes') String? scopes = kAuthScopesAll,
    @rf.Field('website') String? website = kAppWebsiteUrl,
  });

  /// Get an authorization code
  /// The authorization code will be returned as a query parameter named code
  /// in the redirect URI.
  @rf.POST(AuthOauthEndpoints.authorize)
  Future<rf.HttpResponse> authorize({
    @rf.Query('client_id') required String clientId,
    @rf.Query('redirect_uri') required String redirectUri,
    @rf.Query('scope') String? scope,
    @rf.Query('response_type') String? responseType,
  });
}
