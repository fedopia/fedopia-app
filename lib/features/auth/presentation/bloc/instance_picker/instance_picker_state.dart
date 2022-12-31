part of 'instance_picker_bloc.dart';

abstract class InstancePickerState extends Equatable {
  const InstancePickerState();

  @override
  List<Object> get props => [];
}

class InstancePickerInitial extends InstancePickerState {}

class InstancePickerInProgress extends InstancePickerState {}

class InstancePickerSearchSuccess extends InstancePickerState {
  final List<Instance> instances;
  const InstancePickerSearchSuccess({required this.instances});

  @override
  List<Object> get props => [instances];
}

class InstancePickerSearchFailure extends InstancePickerState {
  final String message;
  const InstancePickerSearchFailure({required this.message});

  @override
  List<Object> get props => [message];
}
