part of 'instance_picker_bloc.dart';

abstract class InstancePickerEvent extends Equatable {
  const InstancePickerEvent();

  @override
  List<Object> get props => [];
}

class InstancePickerSearchStarted extends InstancePickerEvent {
  final String? query;
  final InstanceType? instanceType;
  const InstancePickerSearchStarted({this.query, this.instanceType});
}
