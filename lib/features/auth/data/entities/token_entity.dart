import 'package:json_annotation/json_annotation.dart';

part 'token_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenEntity {
  final String accessToken;
  final String tokenType;
  final String scope;
  final int createdAt;

  const TokenEntity({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
    required this.createdAt,
  });

  factory TokenEntity.fromJson(Map<String, dynamic> json) =>
      _$TokenEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TokenEntityToJson(this);
}
