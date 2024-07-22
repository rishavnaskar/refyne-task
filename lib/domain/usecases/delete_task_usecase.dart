import 'package:personal_task_manager_flutter/domain/repository/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;
  DeleteTaskUseCase(this.repository);

  void execute(int id) {
    return repository.deleteTask(id);
  }
}
