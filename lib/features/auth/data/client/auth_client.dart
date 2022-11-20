import 'package:dio/dio.dart';
import 'package:fedopia/core/constants/app_constants.dart';
import 'package:fedopia/features/auth/data/client/auth_endpoints.dart';
import 'package:fedopia/features/auth/domain/constants/auth_scopes_constants.dart';
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
    @rf.Field('scopes') String? scopes,
    @rf.Field('website') String? website,
  });
}
