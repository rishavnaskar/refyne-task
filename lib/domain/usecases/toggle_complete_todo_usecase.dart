import 'package:personal_task_manager_flutter/domain/model/todo_domain_model.dart';
import 'package:personal_task_manager_flutter/domain/repository/todo_repository.dart';

class ToggleCompleteTodoUseCase {
  final TodoRepository repository;
  ToggleCompleteTodoUseCase(this.repository);

  void execute(TodoDomainModel todoDomain) {
    return repository.toggleCompleteTodo(todoDomain);
  }
}
