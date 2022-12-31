import 'package:equatable/equatable.dart';
import 'package:fedopia/features/auth/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  anyMap: true,
)
class Account extends Equatable {
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

  final Token? token;
  final Instance? instance;
  final ClientApp? clientApp;

  const Account({
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

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
