import 'package:hive_flutter/hive_flutter.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 1)
class TaskEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final bool isCompleted;

  TaskEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.isCompleted,
  });
}
