import 'package:bloc/bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/task/task_event.dart';
import 'package:personal_task_manager_flutter/app/bloc/task/task_state.dart';
import 'package:personal_task_manager_flutter/app/models/task_item.dart';
import 'package:personal_task_manager_flutter/app/models/task_model.dart';
import 'package:personal_task_manager_flutter/domain/model/task_domain_model.dart';
import 'package:personal_task_manager_flutter/domain/usecases/add_task_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/delete_task_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/get_all_tasks_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/toggle_complete_task_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/undo_deleted_task_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/update_task_usecase.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final ToggleCompleteTaskUseCase toggleCompleteTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UndoDeletedTaskUseCase undoDeletedTaskUseCase;
  TaskBloc(
      {required this.getAllTasksUseCase,
      required this.addTaskUseCase,
      required this.updateTaskUseCase,
      required this.toggleCompleteTaskUseCase,
      required this.deleteTaskUseCase,
      required this.undoDeletedTaskUseCase})
      : super(TaskLoadingState()) {
    on<TaskStartedEvent>(_onStarted);
    on<TaskItemAddedEvent>(_onItemAdded);
    on<TaskItemUpdatedEvent>(_onItemUpdated);
    on<TaskItemToggleCompletedEvent>(_onItemToggleCompleted);
    on<TaskItemDeletedEvent>(_onItemDeleted);
    on<TaskItemUndoDeletedEvent>(_onItemUndoDeleted);
  }

  void _onStarted(TaskStartedEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      var dataList = getAllTasksUseCase.execute();
      var taskList = dataList
          .map((e) => TaskItem(
              id: e.id,
              title: e.title,
              content: e.content,
              isCompleted: e.isCompleted))
          .toList();
      emit(TaskLoadedState(TaskModel(tasksList: taskList)));
    } catch (e) {
      emit(const TaskErrorState());
    }
  }

  void _onItemAdded(TaskItemAddedEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      var taskDomain = TaskDomainModel(event.task.id, event.task.title,
          event.task.content, event.task.isCompleted);
      addTaskUseCase.execute(taskDomain);
      add(TaskStartedEvent());
    } catch (_) {
      emit(const TaskErrorState());
    }
  }

  void _onItemUpdated(
      TaskItemUpdatedEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      var taskDomain = TaskDomainModel(event.task.id, event.task.title,
          event.task.content, event.task.isCompleted);
      updateTaskUseCase.execute(taskDomain);
      add(TaskStartedEvent());
    } catch (_) {
      emit(const TaskErrorState());
    }
  }

  void _onItemToggleCompleted(
      TaskItemToggleCompletedEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      var taskDomain = TaskDomainModel(event.task.id, event.task.title,
          event.task.content, event.task.isCompleted);
      toggleCompleteTaskUseCase.execute(taskDomain);
      add(TaskStartedEvent());
    } catch (_) {
      emit(const TaskErrorState());
    }
  }

  void _onItemDeleted(
      TaskItemDeletedEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      deleteTaskUseCase.execute(event.id);
      add(TaskStartedEvent());
    } catch (_) {
      emit(const TaskErrorState());
    }
  }

  void _onItemUndoDeleted(
      TaskItemUndoDeletedEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      var taskDomain = TaskDomainModel(event.task.id, event.task.title,
          event.task.content, event.task.isCompleted);
      undoDeletedTaskUseCase.execute(taskDomain);
      add(TaskStartedEvent());
    } catch (_) {
      emit(const TaskErrorState());
    }
  }
}
