import 'package:personal_task_manager_flutter/domain/model/task_domain_model.dart';

abstract class TaskRepository {
  List<TaskDomainModel> getTasksList();
  void addTask(TaskDomainModel task);
  void toggleCompleteTask(TaskDomainModel task);
  void updateTask(TaskDomainModel task);
  void deleteTask(int id);
}
