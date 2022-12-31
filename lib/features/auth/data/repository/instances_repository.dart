import 'package:fedopia/features/auth/data/client/instances_client.dart';
import 'package:fedopia/features/auth/data/entities/instance_entity.dart';
import 'package:fedopia/features/auth/data/repository/iinstances_repository.dart';
import 'package:fedopia/features/auth/domain/model/instance_type.dart';

class InstancesRepository implements IInstancesRepository {
  final InstancesClient instancesClient;

  InstancesRepository(this.instancesClient);

  @override
  Future<List<InstanceEntity>> searchInstances({
    String? query,
    InstanceType? instanceType,
  }) async {
    final instances = await instancesClient.searchInstances(
      query: query,
      instanceType: instanceType,
    );
    return instances.data;
  }

  @override
  Future<List<InstanceEntity>> getInstances({
    String? sortField,
    String? sortDirection,
  }) {
    throw UnimplementedError();
  }
}
