import 'package:personal_task_manager_flutter/domain/model/todo_domain_model.dart';

abstract class TodoRepository {
  List<TodoDomainModel> getTodoList();
  void addTodo(TodoDomainModel todo);
  void toggleCompleteTodo(TodoDomainModel todo);
  void updateTodo(TodoDomainModel todo);
  void deleteTodo(int id);
}
