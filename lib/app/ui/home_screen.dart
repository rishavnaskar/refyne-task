import 'package:fl_three_state_switch/fl_three_state_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/filter/filter_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/filter/filter_event.dart';
import 'package:personal_task_manager_flutter/app/bloc/filter/filter_state.dart';
import 'package:personal_task_manager_flutter/app/bloc/task/task_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/task/task_event.dart';
import 'package:personal_task_manager_flutter/app/bloc/task/task_state.dart';
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
        actions: [
          BlocBuilder<FilterTasksBloc, FilterTasksState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlThreeStateSwtich(
                    height: 20,
                    width: 50,
                    onChanged: (state) {
                      context.read<FilterTasksBloc>().add(FilterTasks(state));
                    },
                    state: state.switchState,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getFilterTitle(state.switchState),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push("/${Routes.addTaskScreen}"),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<FilterTasksBloc, FilterTasksState>(
          builder: (filterTasksContext, filterTasksState) {
        return BlocBuilder<TaskBloc, TaskState>(
          builder: (taskContext, taskState) {
            if (taskState is TaskLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (taskState is TaskLoadedState) {
              if (taskState.taskModel.tasksList.isEmpty) {
                return const Center(
                  child: Text('Empty'),
                );
              } else {
                final tasks = getTasksAfterFiltering(
                  taskState.taskModel.tasksList,
                  filterTasksState.switchState,
                );
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    var taskItem = tasks[index];
                    return TaskListItem(
                      taskItem: taskItem,
                      onClickItem: () => {
                        context.push(
                          "/${Routes.updateTaskScreen}",
                          extra: {"taskItem": taskItem},
                        )
                      },
                      onClickDelete: () => {
                        context
                            .read<TaskBloc>()
                            .add(TaskItemDeletedEvent(taskItem.id)),
                        SnackBarHelper.showSnackBar(
                          context: context,
                          message: '${taskItem.title} is deleted',
                          label: 'Undo',
                          onPress: () => onClickUndo(taskItem),
                        )
                      },
                      onToggleComplete: () => {
                        context
                            .read<TaskBloc>()
                            .add(TaskItemToggleCompletedEvent(taskItem))
                      },
                    );
                  },
                );
              }
            }
            return const Text('Something went wrong!');
          },
        );
      }),
    );
  }

  void onClickUndo(TaskItem taskItem) {
    context.read<TaskBloc>().add(TaskItemUndoDeletedEvent(taskItem));
  }
}
