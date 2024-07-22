import 'package:equatable/equatable.dart';

class TaskItem extends Equatable {
  final int id;
  final String title;
  final String content;
  final bool isCompleted;

  const TaskItem({
    required this.id,
    required this.title,
    required this.content,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [id, title, content, isCompleted];
}
