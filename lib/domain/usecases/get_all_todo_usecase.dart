import 'package:personal_task_manager_flutter/domain/model/todo_domain_model.dart';
import 'package:personal_task_manager_flutter/domain/repository/todo_repository.dart';

class GetAllTodoUseCase {
  final TodoRepository repository;
  GetAllTodoUseCase(this.repository);

  List<TodoDomainModel> execute() {
    return repository.getTodoList();
  }
}
