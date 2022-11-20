import 'package:fedopia/features/auth/data/client/auth_endpoints.dart';
import 'package:fedopia/features/auth/domain/constants/auth_response_constants.dart';
import 'package:fedopia/features/auth/domain/constants/auth_scopes_constants.dart';
import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';

class Instance {
  final String name;
  final String host;

  const Instance({
    required this.name,
    required this.host,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Instance &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          host == other.host;

  @override
  int get hashCode => name.hashCode ^ host.hashCode;

  // get uri
  Uri get uri => Uri.parse('https://$host');
  // get api uri
  Uri get apiUri => Uri.parse('https://$host/api/v1');

  // uri with path
  Uri uriWithPath(String path) => uri.replace(path: path);
  Uri uriWithQuery(String path, Map<String, dynamic> query) =>
      uriWithPath(path).replace(queryParameters: query);

  // api uri with path
  Uri apiUriWithPath(String path) => uri.replace(path: '/api/v1/$path');
  Uri apiUriWithQuery(String path, Map<String, dynamic> query) =>
      apiUriWithPath(path).replace(queryParameters: query);

  // authorize uri from client app
  Uri authorizeUriFromClientApp(ClientAppEntity clientApp) => uriWithQuery(
        AuthOauthEndpoints.authorize,
        {
          'client_id': clientApp.clientId,
          'redirect_uri': clientApp.redirectUri,
          'scope': kAuthScopesAll,
          'response_type': kAuthResponseTypeCode,
        },
      );
}
