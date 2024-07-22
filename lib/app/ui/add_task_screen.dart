import 'package:flutter/material.dart';
import 'package:personal_task_manager_flutter/app/ui/components/add_task_form.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: AddTaskForm(),
      ),
    );
  }
}
