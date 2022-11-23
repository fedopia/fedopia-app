import 'package:fedopia/features/auth/data/entities/instance_entity.dart';
import 'package:fedopia/features/auth/domain/model/instance.dart';

class InstanceTranslator {
  InstanceTranslator._();

  static InstanceEntity toEntity(Instance instance) {
    return InstanceEntity(
      name: instance.name,
      host: instance.host,
    );
  }

  static Instance toModel(InstanceEntity instanceEntity) {
    return Instance(
      name: instanceEntity.name,
      host: instanceEntity.host,
    );
  }
}
