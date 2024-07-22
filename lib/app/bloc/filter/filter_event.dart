import 'package:equatable/equatable.dart';
import 'package:fl_three_state_switch/fl_three_state_switch.dart';

abstract class FilterTasksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FilterTasks extends FilterTasksEvent {
  final SwitchState switchState;
  FilterTasks(this.switchState);

  @override
  List<Object> get props => [switchState];
}
