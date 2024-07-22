import 'package:equatable/equatable.dart';
import 'package:personal_task_manager_flutter/app/models/task_item.dart';

class TaskModel extends Equatable {
  const TaskModel({required this.tasksList});

  final List<TaskItem> tasksList;

  @override
  List<Object> get props => [tasksList];
}
