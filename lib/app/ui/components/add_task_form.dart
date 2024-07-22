import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/task_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/task_event.dart';
import 'package:personal_task_manager_flutter/app/bloc/task_state.dart';
import 'package:personal_task_manager_flutter/app/models/task_item.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_task_manager_flutter/app/ui/components/helper.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final taskFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      return Form(
        key: taskFormKey,
        child: ListView(
          children: [
            const SizedBox(height: 24.0),
            const Text('Title'),
            TextFormField(
              key: const Key('add_task_title_textFormField'),
              controller: titleController,
              maxLines: 1,
              maxLength: 50,
              validator: titleFieldValidator,
            ),
            const SizedBox(height: 24.0),
            const Text('Content'),
            TextFormField(
              key: const Key('add_task_content_textFormField'),
              controller: contentController,
              minLines: 1,
              maxLines: 3,
              maxLength: 200,
              validator: contentFieldValidator,
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (taskFormKey.currentState!.validate()) {
                      addTask();
                      context.pop();
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void addTask() async {
    TaskItem taskItem = TaskItem(
        id: 0,
        title: titleController.text,
        content: contentController.text,
        isCompleted: false);
    context.read<TaskBloc>().add(TaskItemAddedEvent(taskItem));
  }
}
