import 'package:fedopia/features/auth/data/entities/token_entity.dart';
import 'package:fedopia/features/auth/domain/domain.dart';

class TokenTranslator {
  TokenTranslator._();

  static TokenEntity toEntity(Token token) {
    return TokenEntity(
      accessToken: token.accessToken,
      tokenType: token.tokenType,
      scope: token.scope,
      createdAt: token.createdAt,
    );
  }

  static Token toModel(TokenEntity tokenEntity) {
    return Token(
      accessToken: tokenEntity.accessToken,
      tokenType: tokenEntity.tokenType,
      scope: tokenEntity.scope,
      createdAt: tokenEntity.createdAt,
    );
  }
}
