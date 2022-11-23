import 'package:equatable/equatable.dart';
import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';
import 'package:fedopia/features/auth/data/entities/instance_entity.dart';
import 'package:fedopia/features/auth/data/entities/token_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_entity.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  anyMap: true,
)
class AccountEntity extends Equatable {
  final String id;
  final String username;
  final String url;
  final String acct;
  final String displayName;
  final bool locked;
  final String createdAt;
  final int followersCount;
  final int followingCount;
  final int statusesCount;
  final String note;
  final String avatar;
  final String avatarStatic;
  final String header;
  final String headerStatic;
  // final List<Emoji> emojis;
  @JsonKey(defaultValue: false)
  final bool moved;

  final TokenEntity? token;
  final InstanceEntity? instance;
  final ClientAppEntity? clientApp;

  const AccountEntity({
    required this.id,
    required this.username,
    required this.url,
    required this.acct,
    required this.displayName,
    required this.locked,
    required this.createdAt,
    required this.followersCount,
    required this.followingCount,
    required this.statusesCount,
    required this.note,
    required this.avatar,
    required this.avatarStatic,
    required this.header,
    required this.headerStatic,
    // required this.emojis,
    required this.moved,

    // TODO: custom additions, separate table needed
    this.token,
    this.instance,
    this.clientApp,
  });

  @override
  List<Object?> get props => [
        token,
        id,
        username,
        url,
        acct,
        displayName,
        locked,
        createdAt,
        followersCount,
        followingCount,
        statusesCount,
        note,
        avatar,
        avatarStatic,
        header,
        headerStatic,
        // emojis,
        moved,
        instance,
        clientApp,
      ];

  factory AccountEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AccountEntityToJson(this);

  AccountEntity copyWith({
    String? id,
    String? username,
    String? url,
    String? acct,
    String? displayName,
    bool? locked,
    String? createdAt,
    int? followersCount,
    int? followingCount,
    int? statusesCount,
    String? note,
    String? avatar,
    String? avatarStatic,
    String? header,
    String? headerStatic,
    // List<Emoji>? emojis,
    bool? moved,
    TokenEntity? token,
    InstanceEntity? instance,
    ClientAppEntity? clientApp,
  }) {
    return AccountEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      url: url ?? this.url,
      acct: acct ?? this.acct,
      displayName: displayName ?? this.displayName,
      locked: locked ?? this.locked,
      createdAt: createdAt ?? this.createdAt,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      statusesCount: statusesCount ?? this.statusesCount,
      note: note ?? this.note,
      avatar: avatar ?? this.avatar,
      avatarStatic: avatarStatic ?? this.avatarStatic,
      header: header ?? this.header,
      headerStatic: headerStatic ?? this.headerStatic,
      // emojis: emojis ?? this.emojis,
      moved: moved ?? this.moved,
      token: token ?? this.token,
      instance: instance ?? this.instance,
      clientApp: clientApp ?? this.clientApp,
    );
  }
}
