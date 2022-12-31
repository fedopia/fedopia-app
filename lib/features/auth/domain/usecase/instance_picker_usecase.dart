import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fedopia/features/auth/data/client/instances_errors.dart';
import 'package:fedopia/features/auth/data/repository/iinstances_repository.dart';
import 'package:fedopia/features/auth/domain/domain.dart';
import 'package:fedopia/features/auth/domain/model/instance_type.dart';

class InstancePickerUseCase {
  final IInstancesRepository _instancesRepository;

  InstancePickerUseCase(this._instancesRepository);

  Future<Either<InstancesError, List<Instance>>> searchInstances({
    String? query,
    InstanceType? instanceType,
  }) async {
    try {
      final instanceEntities = await _instancesRepository.searchInstances(
        query: query,
        instanceType: instanceType,
      );
      final instances = instanceEntities
          .map((instanceEntity) => InstanceTranslator.toModel(instanceEntity))
          .toList();
      return Right(instances);
    } on DioError catch (e) {
      log(e.message);
      return const Left(InstancesError.searchFailure);
    } catch (e) {
      // TODO: Handle errors
      log(e.toString());
      return const Left(InstancesError.searchFailure);
    }
  }
}
