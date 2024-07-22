import 'package:equatable/equatable.dart';

class TodoItem extends Equatable {
  final int id;
  final String title;
  final String content;
  final bool isCompleted;

  const TodoItem({
    required this.id,
    required this.title,
    required this.content,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [id, title, content, isCompleted];
}
