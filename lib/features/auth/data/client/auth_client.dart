import 'package:dio/dio.dart';
import 'package:fedopia/features/auth/data/client/auth_endpoints.dart';
import 'package:fedopia/features/auth/data/entities/token_entity.dart';
import 'package:retrofit/retrofit.dart' as rf;

part 'auth_client.g.dart';

@rf.RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  /// Obtain access token
  /// https://docs.joinmastodon.org/methods/apps/oauth/
  @rf.POST(AuthEndpoints.oauthToken)
  Future<TokenEntity> obtainAccessToken({
    @rf.Field('client_id') required String clientId,
    @rf.Field('client_secret') required String clientSecret,
    @rf.Field('redirect_uri') required String redirectUri,
    @rf.Field('code') required String code,
    @rf.Field('grant_type') required String grantType,
    @rf.Field('scope') String? scope,
  });
}
