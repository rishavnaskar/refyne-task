import 'package:flutter/foundation.dart';
import 'package:personal_task_manager_flutter/data/datasource/crud_datasource.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_task_manager_flutter/data/entity/task_data.dart';
import 'package:personal_task_manager_flutter/database/entity/task_entity.dart';

const String taskBoxName = 'taskBox';
const String latestIdBoxName = "latestIdBox";
const String latestIdName = "latestId";

class LocalDatabase extends CRUDDataSource {
  LocalDatabase._constructor();

  static final LocalDatabase _instance = LocalDatabase._constructor();

  factory LocalDatabase() => _instance;

  late Box taskBox;
  late Box _lastIdBox;

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskEntityAdapter());
    taskBox = await Hive.openBox(taskBoxName);
    _lastIdBox = await Hive.openBox(latestIdBoxName);
  }

  void close() {
    Hive.close();
  }

  @override
  void saveTask(TaskData taskData) async {
    try {
      int latestId = _lastIdBox.get(latestIdName, defaultValue: 0);
      int newLatestId = latestId + 1;
      final taskEntity = TaskEntity(
        id: newLatestId,
        title: taskData.title,
        content: taskData.content,
        isCompleted: taskData.isCompleted,
      );
      await taskBox.put(taskEntity.id, taskEntity);
      await _lastIdBox.put(latestIdName, newLatestId);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  void updateTask(int id, TaskData taskData) async {
    try {
      final taskEntity = TaskEntity(
        id: id,
        title: taskData.title,
        content: taskData.content,
        isCompleted: taskData.isCompleted,
      );
      await taskBox.put(taskData.id, taskEntity);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  void deleteTask(int id) async {
    try {
      await taskBox.delete(id);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  void deleteAllTasks() async {
    try {
      await taskBox.clear();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  List<TaskData> getAllTasksList() {
    return taskBox.values
        .map((e) => TaskData(e.id, e.title, e.content, e.isCompleted))
        .toList();
  }
}
