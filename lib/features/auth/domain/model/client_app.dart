import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client_app.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ClientApp extends Equatable {
  final String id;
  final String name;
  final String website;
  final String redirectUri;
  final String clientId;
  final String clientSecret;
  final String vapidKey;

  const ClientApp({
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

  factory ClientApp.fromJson(Map<String, dynamic> json) =>
      _$ClientAppFromJson(json);

  Map<String, dynamic> toJson() => _$ClientAppToJson(this);
}
