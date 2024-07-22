import 'package:personal_task_manager_flutter/domain/repository/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository repository;
  DeleteTodoUseCase(this.repository);

  void execute(int id) {
    return repository.deleteTodo(id);
  }
}
