import 'package:personal_task_manager_flutter/domain/model/todo_domain_model.dart';
import 'package:personal_task_manager_flutter/domain/repository/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository repository;
  AddTodoUseCase(this.repository);

  void execute(TodoDomainModel todoDomain) {
    return repository.addTodo(todoDomain);
  }
}
