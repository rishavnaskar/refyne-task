import 'package:personal_task_manager_flutter/data/entity/task_data.dart';

abstract class CRUDDataSource {
  List<TaskData> getAllTasksList();
  void saveTask(TaskData taskData);
  void updateTask(int id, TaskData taskData);
  void deleteTask(int id);
  void deleteAllTasks();
}
