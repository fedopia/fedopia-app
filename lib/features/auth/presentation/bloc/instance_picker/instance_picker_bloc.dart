import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fedopia/features/auth/domain/model/instance.dart';
import 'package:fedopia/features/auth/domain/model/instance_type.dart';
import 'package:fedopia/features/auth/domain/usecase/instance_picker_usecase.dart';

part 'instance_picker_event.dart';
part 'instance_picker_state.dart';

class InstancePickerBloc
    extends Bloc<InstancePickerEvent, InstancePickerState> {
  final InstancePickerUseCase instancesUseCase;
  String? query;

  InstancePickerBloc(this.instancesUseCase) : super(InstancePickerInitial()) {
    on<InstancePickerSearchStarted>(_onInstancePickerSearchStarted);
  }

  void _onInstancePickerSearchStarted(
    InstancePickerSearchStarted event,
    Emitter<InstancePickerState> emit,
  ) async {
    emit(InstancePickerInProgress());

    // get instances
    // NOTE: disabled for now, because the service is down :(

    // final result = await instancesUseCase.searchInstances(
    //   query: event.query,
    //   instanceType: event.instanceType,
    // );

    // result.fold(
    //   (failure) => emit(InstancePickerSearchFailure(message: failure.name)),
    //   (instances) => emit(InstancePickerSearchSuccess(instances: instances)),
    // );

    // NOTE: mock the instances
    List<Instance> instances = [];
    if (event.query != null) {
      instances.add(Instance.fromHost(event.query!));
    }

    emit(InstancePickerSearchSuccess(instances: instances));
  }
}
