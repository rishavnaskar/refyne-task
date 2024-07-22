import 'package:flutter/material.dart';
import 'package:personal_task_manager_flutter/app/models/task_item.dart';

class TaskListItem extends StatelessWidget {
  final TaskItem taskItem;
  final Function onClickItem;
  final Function onClickDelete;
  final Function onToggleComplete;

  const TaskListItem(
      {required this.taskItem,
      required this.onClickItem,
      required this.onClickDelete,
      required this.onToggleComplete,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("deleted_task_${taskItem.id}"),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onClickDelete();
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        onTap: () => onClickItem(),
        title: Text(
          taskItem.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: taskItem.isCompleted
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        subtitle: Text(
          taskItem.content,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: taskItem.isCompleted
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
        leading: Checkbox(
          key: Key('task_item_checkbox_${taskItem.id}'),
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          value: taskItem.isCompleted,
          onChanged: (bool? value) {
            onToggleComplete();
          },
        ),
      ),
    );
  }
}
