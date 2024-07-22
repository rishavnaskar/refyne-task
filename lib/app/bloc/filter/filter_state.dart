import 'package:equatable/equatable.dart';
import 'package:fl_three_state_switch/fl_three_state_switch.dart';

class FilterTasksState extends Equatable {
  final SwitchState switchState;
  const FilterTasksState({this.switchState = SwitchState.middle});

  FilterTasksState copyWith({SwitchState? newSwitchState}) {
    return FilterTasksState(switchState: newSwitchState ?? switchState);
  }

  @override
  List<Object> get props => [switchState];
}
