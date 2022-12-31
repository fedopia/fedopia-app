import 'package:json_annotation/json_annotation.dart';

enum InstanceTypeEntity {
  @JsonValue('unknown')
  unknown,
  @JsonValue('pleroma')
  pleroma,
  @JsonValue('mastodon')
  mastodon,
  @JsonValue('misskey')
  misskey,
}
