import 'package:json_annotation/json_annotation.dart';

part 'instance_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InstanceEntity {
  final String name;
  final String host;

  const InstanceEntity({
    required this.name,
    required this.host,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstanceEntity &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          host == other.host;

  @override
  int get hashCode => name.hashCode ^ host.hashCode;

  factory InstanceEntity.fromJson(Map<String, dynamic> json) =>
      _$InstanceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$InstanceEntityToJson(this);
}
