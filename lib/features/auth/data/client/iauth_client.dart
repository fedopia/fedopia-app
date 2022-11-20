import 'package:dio/dio.dart';
import 'package:fedopia/features/auth/data/client/auth_endpoints.dart';
import 'package:fedopia/features/auth/data/client/auth_scopes.dart';
import 'package:retrofit/retrofit.dart' as rf;
import 'package:retrofit/retrofit.dart' show HttpResponse;

part 'iauth_client.g.dart';

@rf.RestApi()
abstract class IAuthClient {
  factory IAuthClient(Dio dio, {String baseUrl}) = _IAuthClient;

  /// Get an authorization code
  /// The authorization code will be returned as a query parameter named code
  /// in the redirect URI.
  @rf.GET(AuthOauthEndpoints.authorize)
  Future<rf.HttpResponse> authorize(
    @rf.Path('client_id') String clientId,
    @rf.Query('redirect_uri') String redirectUri, {
    @rf.Query('scope') String scope = kAuthScopesAll,
    @rf.Query('response_type') String responseType = 'code',
  });
}
