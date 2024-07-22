import 'package:personal_task_manager_flutter/domain/model/todo_domain_model.dart';
import 'package:personal_task_manager_flutter/domain/repository/todo_repository.dart';

class UndoDeletedTodoUseCase {
  final TodoRepository repository;
  UndoDeletedTodoUseCase(this.repository);

  void execute(TodoDomainModel todoDomain) {
    return repository.addTodo(todoDomain);
  }
}
