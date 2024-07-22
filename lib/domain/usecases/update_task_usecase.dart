import 'package:personal_task_manager_flutter/domain/model/task_domain_model.dart';
import 'package:personal_task_manager_flutter/domain/repository/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;
  UpdateTaskUseCase(this.repository);

  void execute(TaskDomainModel taskDomain) {
    return repository.updateTask(taskDomain);
  }
}
