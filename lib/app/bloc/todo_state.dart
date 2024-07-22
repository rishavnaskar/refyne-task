import 'package:equatable/equatable.dart';
import 'package:personal_task_manager_flutter/app/model/todo_item.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  const TodoLoadedState(this.todoModel);

  final TodoItem todoModel;

  @override
  List<Object> get props => [todoModel];
}

class TodoErrorState extends TodoState {
  const TodoErrorState();
}
