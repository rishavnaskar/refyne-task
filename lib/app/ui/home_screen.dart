import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/task_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/task_event.dart';
import 'package:personal_task_manager_flutter/app/bloc/task_state.dart';
import 'package:personal_task_manager_flutter/app/models/task_item.dart';
import 'package:personal_task_manager_flutter/app/routes/router.dart';
import 'package:personal_task_manager_flutter/app/ui/components/helper.dart';
import 'package:personal_task_manager_flutter/app/ui/components/task_list_item.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Task Manager'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push("/${Routes.addTaskScreen}"),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TaskLoadedState) {
            if (state.taskModel.tasksList.isEmpty) {
              return const Center(
                child: Text('Empty'),
              );
            } else {
              return ListView.builder(
                itemCount: state.taskModel.tasksList.length,
                itemBuilder: (context, index) {
                  var taskItem = state.taskModel.tasksList[index];
                  return TaskListItem(
                      taskItem: taskItem,
                      onClickItem: () => {
                            context.push("/${Routes.updateTaskScreen}",
                                extra: {"task": taskItem})
                          },
                      onClickDelete: () => {
                            context
                                .read<TaskBloc>()
                                .add(TaskItemDeletedEvent(taskItem.id)),
                            SnackBarHelper.showSnackBar(
                                context: context,
                                message: '${taskItem.title} is deleted',
                                label: 'Undo',
                                onPress: () => onClickUndo(taskItem))
                          },
                      onToggleComplete: () => {
                            context
                                .read<TaskBloc>()
                                .add(TaskItemToggleCompletedEvent(taskItem))
                          });
                },
              );
            }
          }
          return const Text('Something went wrong!');
        },
      ),
    );
  }

  void onClickUndo(TaskItem taskItem) {
    context.read<TaskBloc>().add(TaskItemUndoDeletedEvent(taskItem));
  }
}
