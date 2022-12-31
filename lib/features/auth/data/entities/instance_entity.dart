import 'package:fedopia/features/auth/data/entities/instance_type_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'instance_entity.g.dart';

@JsonSerializable()
class InstanceEntity {
  final String name;
  @JsonKey(readValue: _readHost)
  final String host;
  final String? description;
  final InstanceTypeEntity type;
  final int? userCount;

  const InstanceEntity({
    required this.name,
    required this.host,
    this.description,
    required this.type,
    this.userCount,
  });

  // readHost
  static _readHost(Map data, String host) {
    return data["name"];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstanceEntity &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          host == other.host &&
          description == other.description &&
          type == other.type &&
          userCount == other.userCount;

  @override
  int get hashCode => name.hashCode ^ host.hashCode;

  factory InstanceEntity.fromJson(Map<String, dynamic> json) =>
      _$InstanceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$InstanceEntityToJson(this);
}
