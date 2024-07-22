import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/task_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/task_event.dart';
import 'package:personal_task_manager_flutter/app/bloc/task_state.dart';
import 'package:personal_task_manager_flutter/app/models/task_item.dart';
import 'package:personal_task_manager_flutter/app/ui/components/helper.dart';
import 'package:go_router/go_router.dart';

class UpdateTaskForm extends StatefulWidget {
  final TaskItem taskItem;

  const UpdateTaskForm({super.key, required this.taskItem});

  @override
  State<UpdateTaskForm> createState() => _UpdateTaskFormState();
}

class _UpdateTaskFormState extends State<UpdateTaskForm> {
  final taskFormKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.taskItem.title);
    contentController = TextEditingController(text: widget.taskItem.content);
  }

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
              key: const Key('update_task_title_textFormField'),
              controller: titleController,
              maxLines: 1,
              maxLength: 50,
              validator: titleFieldValidator,
            ),
            const SizedBox(height: 24.0),
            const Text('Content'),
            TextFormField(
              key: const Key('update_task_content_textFormField'),
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
                      updateInfo();
                      context.pop();
                    }
                  },
                  child: const Text('Update'),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void updateInfo() {
    TaskItem taskItem = TaskItem(
        id: widget.taskItem.id,
        title: titleController.text,
        content: contentController.text,
        isCompleted: widget.taskItem.isCompleted);
    context.read<TaskBloc>().add(TaskItemUpdatedEvent(taskItem));
  }
}
