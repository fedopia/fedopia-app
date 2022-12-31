import 'package:fedopia/features/auth/data/entities/instance_entity.dart';
import 'package:fedopia/features/auth/domain/domain.dart';

class InstanceTranslator {
  InstanceTranslator._();

  static InstanceEntity toEntity(Instance instance) {
    return InstanceEntity(
      name: instance.name,
      host: instance.host,
      description: instance.description,
      type: instance.type,
      userCount: instance.userCount,
    );
  }

  static Instance toModel(InstanceEntity instanceEntity) {
    return Instance(
      name: instanceEntity.name,
      host: instanceEntity.host,
      description: instanceEntity.description,
      type: instanceEntity.type,
      userCount: instanceEntity.userCount,
    );
  }
}
