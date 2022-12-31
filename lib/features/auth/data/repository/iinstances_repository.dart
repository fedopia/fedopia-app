import 'package:fedopia/features/auth/data/entities/instance_entity.dart';
import 'package:fedopia/features/auth/domain/model/instance_type.dart';

abstract class IInstancesRepository {
  /// Search instances by query and type
  Future<List<InstanceEntity>> searchInstances({
    String? query,
    InstanceType? instanceType,
  });

  /// Get instances
  Future<List<InstanceEntity>> getInstances({
    String? sortField,
    String? sortDirection,
  });
}
