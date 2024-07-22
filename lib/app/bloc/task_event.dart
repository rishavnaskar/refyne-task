import 'package:equatable/equatable.dart';
import 'package:personal_task_manager_flutter/app/models/task_item.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class TaskStartedEvent extends TaskEvent {
  @override
  List<Object?> get props => [];
}

class TaskItemAddedEvent extends TaskEvent {
  const TaskItemAddedEvent(this.task);

  final TaskItem task;

  @override
  List<Object?> get props => [task];
}

class TaskItemUpdatedEvent extends TaskEvent {
  const TaskItemUpdatedEvent(this.task);

  final TaskItem task;

  @override
  List<Object?> get props => [task];
}

class TaskItemToggleCompletedEvent extends TaskEvent {
  const TaskItemToggleCompletedEvent(this.task);

  final TaskItem task;

  @override
  List<Object?> get props => [task];
}

class TaskItemDeletedEvent extends TaskEvent {
  const TaskItemDeletedEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [];
}

class TaskItemUndoDeletedEvent extends TaskEvent {
  const TaskItemUndoDeletedEvent(this.task);

  final TaskItem task;

  @override
  List<Object?> get props => [];
}
