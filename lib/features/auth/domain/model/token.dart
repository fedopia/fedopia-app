import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Token {
  final String accessToken;
  final String tokenType;
  final String scope;
  final int createdAt;

  const Token({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
    required this.createdAt,
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
