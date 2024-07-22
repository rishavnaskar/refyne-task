import 'package:equatable/equatable.dart';
import 'package:personal_task_manager_flutter/app/models/todo_item.dart';

class TodoModel extends Equatable {
  const TodoModel({required this.todoList});

  final List<TodoItem> todoList;

  @override
  List<Object> get props => [todoList];
}
