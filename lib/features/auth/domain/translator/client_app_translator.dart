import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';
import 'package:fedopia/features/auth/domain/model/client_app.dart';

class ClientAppTranslator {
  ClientAppTranslator._();

  static ClientAppEntity toEntity(ClientApp clientApp) {
    return ClientAppEntity(
      id: clientApp.id,
      name: clientApp.name,
      website: clientApp.website,
      redirectUri: clientApp.redirectUri,
      clientId: clientApp.clientId,
      clientSecret: clientApp.clientSecret,
      vapidKey: clientApp.vapidKey,
    );
  }

  static ClientApp toModel(ClientAppEntity clientAppEntity) {
    return ClientApp(
      id: clientAppEntity.id,
      name: clientAppEntity.name,
      website: clientAppEntity.website,
      redirectUri: clientAppEntity.redirectUri,
      clientId: clientAppEntity.clientId,
      clientSecret: clientAppEntity.clientSecret,
      vapidKey: clientAppEntity.vapidKey,
    );
  }
}
