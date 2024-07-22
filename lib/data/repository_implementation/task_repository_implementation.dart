import 'package:personal_task_manager_flutter/data/datasource/crud_datasource.dart';
import 'package:personal_task_manager_flutter/data/entity/task_data.dart';
import 'package:personal_task_manager_flutter/domain/model/task_domain_model.dart';
import 'package:personal_task_manager_flutter/domain/repository/task_repository.dart';

class TaskRepositoryImplementation extends TaskRepository {
  final CRUDDataSource dataSource;
  TaskRepositoryImplementation(this.dataSource);

  @override
  void addTask(TaskDomainModel task) {
    return dataSource.saveTask(
      TaskData(
        task.id,
        task.title,
        task.content,
        task.isCompleted,
      ),
    );
  }

  @override
  void toggleCompleteTask(TaskDomainModel task) {
    return dataSource.updateTask(
      task.id,
      TaskData(
        task.id,
        task.title,
        task.content,
        !task.isCompleted,
      ),
    );
  }

  @override
  void deleteTask(int id) {
    return dataSource.deleteTask(id);
  }

  @override
  List<TaskDomainModel> getTasksList() {
    return dataSource
        .getAllTasksList()
        .map((e) => TaskDomainModel(e.id, e.title, e.content, e.isCompleted))
        .toList();
  }

  @override
  void updateTask(TaskDomainModel task) async {
    return dataSource.updateTask(
      task.id,
      TaskData(
        task.id,
        task.title,
        task.content,
        task.isCompleted,
      ),
    );
  }
}
