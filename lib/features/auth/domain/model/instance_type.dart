import 'package:json_annotation/json_annotation.dart';

enum InstanceType {
  @JsonValue('unknown')
  unknown,
  @JsonValue('pleroma')
  pleroma,
  @JsonValue('mastodon')
  mastodon,
  @JsonValue('misskey')
  misskey;

  String toJson() => name;
  static InstanceType fromJson(String json) => values.byName(json);
}
