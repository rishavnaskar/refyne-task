import 'package:equatable/equatable.dart';
import 'package:personal_task_manager_flutter/app/models/task_model.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  const TaskLoadedState(this.taskModel);

  final TaskModel taskModel;

  @override
  List<Object> get props => [taskModel];
}

class TaskErrorState extends TaskState {
  const TaskErrorState();
}
