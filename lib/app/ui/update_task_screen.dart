import 'package:flutter/material.dart';
import 'package:personal_task_manager_flutter/app/models/task_item.dart';
import 'package:personal_task_manager_flutter/app/ui/components/update_task_form.dart';

class UpdateTaskScreen extends StatefulWidget {
  final TaskItem taskItem;

  const UpdateTaskScreen({
    super.key,
    required this.taskItem,
  });

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UpdateTaskForm(
          taskItem: widget.taskItem,
        ),
      ),
    );
  }
}
