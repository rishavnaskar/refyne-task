import 'package:fl_three_state_switch/fl_three_state_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/filter/filter_event.dart';
import 'package:personal_task_manager_flutter/app/bloc/filter/filter_state.dart';

class FilterTasksBloc extends Bloc<FilterTasksEvent, FilterTasksState> {
  FilterTasksBloc()
      : super(const FilterTasksState(switchState: SwitchState.middle)) {
    on<FilterTasks>(updateFilter);
  }

  void updateFilter(FilterTasks event, Emitter<FilterTasksState> emit) {
    emit(state.copyWith(newSwitchState: event.switchState));
  }
}
