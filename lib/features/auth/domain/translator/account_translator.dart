import 'package:fedopia/features/auth/data/entities/account_entity.dart';
import 'package:fedopia/features/auth/domain/model/account.dart';
import 'package:fedopia/features/auth/domain/translator/client_app_translator.dart';
import 'package:fedopia/features/auth/domain/translator/instance_translator.dart';
import 'package:fedopia/features/auth/domain/translator/token_translator.dart';

class AccountTranslator {
  AccountTranslator._();

  static AccountEntity toEntity(Account account) {
    return AccountEntity(
      id: account.id,
      username: account.username,
      url: account.url,
      acct: account.acct,
      displayName: account.displayName,
      locked: account.locked,
      createdAt: account.createdAt,
      followersCount: account.followersCount,
      followingCount: account.followingCount,
      statusesCount: account.statusesCount,
      note: account.note,
      avatar: account.avatar,
      avatarStatic: account.avatarStatic,
      header: account.header,
      headerStatic: account.headerStatic,
      moved: account.moved,
      token: account.token != null
          ? TokenTranslator.toEntity(account.token!)
          : null,
      instance: account.instance != null
          ? InstanceTranslator.toEntity(account.instance!)
          : null,
      clientApp: account.clientApp != null
          ? ClientAppTranslator.toEntity(account.clientApp!)
          : null,
    );
  }

  static Account toModel(AccountEntity accountEntity) {
    return Account(
      id: accountEntity.id,
      username: accountEntity.username,
      url: accountEntity.url,
      acct: accountEntity.acct,
      displayName: accountEntity.displayName,
      locked: accountEntity.locked,
      createdAt: accountEntity.createdAt,
      followersCount: accountEntity.followersCount,
      followingCount: accountEntity.followingCount,
      statusesCount: accountEntity.statusesCount,
      note: accountEntity.note,
      avatar: accountEntity.avatar,
      avatarStatic: accountEntity.avatarStatic,
      header: accountEntity.header,
      headerStatic: accountEntity.headerStatic,
      moved: accountEntity.moved,
      token: accountEntity.token != null
          ? TokenTranslator.toModel(accountEntity.token!)
          : null,
      instance: accountEntity.instance != null
          ? InstanceTranslator.toModel(accountEntity.instance!)
          : null,
      clientApp: accountEntity.clientApp != null
          ? ClientAppTranslator.toModel(accountEntity.clientApp!)
          : null,
    );
  }
}
