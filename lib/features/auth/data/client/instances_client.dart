import 'package:dio/dio.dart';
import 'package:fedopia/features/auth/data/entities/instances_result.dart';
import 'package:fedopia/features/auth/domain/model/instance_type.dart';
import 'package:retrofit/retrofit.dart' as rf;

part 'instances_client.g.dart';

@rf.RestApi()
abstract class InstancesClient {
  factory InstancesClient(Dio dio, {String? baseUrl}) = _InstancesClient;

  @rf.GET('/search')
  Future<InstancesResult> searchInstances({
    @rf.Query('query') String? query,
    @rf.Query('type_eq') InstanceType? instanceType,
  });

  @rf.GET('/instances')
  Future<InstancesResult> getInstances({
    @rf.Query('sortField') String? sortField,
    @rf.Query('sortDirection') String? sortDirection,
    // we won't support pagination for now
    // @rf.Query('page') int page,
  });
}
