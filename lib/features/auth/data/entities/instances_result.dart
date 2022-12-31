import 'package:fedopia/features/auth/data/entities/instance_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'instances_result.g.dart';

@JsonSerializable()
class InstancesResult {
  InstancesResult({
    required this.data,
  });

  @JsonKey(name: 'results')
  final List<InstanceEntity> data;

  factory InstancesResult.fromJson(Map<String, dynamic> json) =>
      _$InstancesResultFromJson(json);

  Map<String, dynamic> toJson() => _$InstancesResultToJson(this);
}
