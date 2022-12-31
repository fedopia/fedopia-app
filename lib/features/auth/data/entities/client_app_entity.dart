import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client_app_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, anyMap: true)
class ClientAppEntity extends Equatable {
  final String id;
  final String name;
  final String website;
  final String redirectUri;
  final String clientId;
  final String clientSecret;
  final String vapidKey;

  const ClientAppEntity({
    required this.id,
    required this.name,
    required this.website,
    required this.redirectUri,
    required this.clientId,
    required this.clientSecret,
    required this.vapidKey,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        website,
        redirectUri,
        clientId,
        clientSecret,
        vapidKey,
      ];

  factory ClientAppEntity.fromJson(Map<String, dynamic> json) =>
      _$ClientAppEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ClientAppEntityToJson(this);
}
