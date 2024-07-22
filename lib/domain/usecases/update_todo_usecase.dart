import 'package:personal_task_manager_flutter/domain/model/todo_domain_model.dart';
import 'package:personal_task_manager_flutter/domain/repository/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;
  UpdateTodoUseCase(this.repository);

  void execute(TodoDomainModel todoDomain) {
    return repository.updateTodo(todoDomain);
  }
}
