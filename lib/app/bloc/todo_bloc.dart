import 'package:bloc/bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/todo_event.dart';
import 'package:personal_task_manager_flutter/app/bloc/todo_state.dart';
import 'package:personal_task_manager_flutter/app/models/todo_item.dart';
import 'package:personal_task_manager_flutter/app/models/todo_model.dart';
import 'package:personal_task_manager_flutter/domain/model/todo_domain_model.dart';
import 'package:personal_task_manager_flutter/domain/usecases/add_todo_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/delete_todo_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/get_all_todo_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/toggle_complete_todo_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/undo_deleted_todo_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/update_todo_usecase.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodoUseCase getAllTodoUseCase;
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final ToggleCompleteTodoUseCase toggleCompleteTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final UndoDeletedTodoUseCase undoDeletedTodoUseCase;
  TodoBloc(
      {required this.getAllTodoUseCase,
      required this.addTodoUseCase,
      required this.updateTodoUseCase,
      required this.toggleCompleteTodoUseCase,
      required this.deleteTodoUseCase,
      required this.undoDeletedTodoUseCase})
      : super(TodoLoadingState()) {
    on<TodoStartedEvent>(_onStarted);
    on<TodoItemAddedEvent>(_onItemAdded);
    on<TodoItemUpdatedEvent>(_onItemUpdated);
    on<TodoItemToggleCompletedEvent>(_onItemToggleCompleted);
    on<TodoItemDeletedEvent>(_onItemDeleted);
    on<TodoItemUndoDeletedEvent>(_onItemUndoDeleted);
  }

  void _onStarted(TodoStartedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var dataList = getAllTodoUseCase.execute();
      var todoVOList = dataList
          .map((e) => TodoItem(
              id: e.id,
              title: e.title,
              content: e.content,
              isCompleted: e.isCompleted))
          .toList();
      emit(TodoLoadedState(TodoModel(todoList: todoVOList)));
    } catch (e) {
      emit(const TodoErrorState());
    }
  }

  void _onItemAdded(TodoItemAddedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var todoDomain = TodoDomainModel(event.todo.id, event.todo.title,
          event.todo.content, event.todo.isCompleted);
      addTodoUseCase.execute(todoDomain);
      add(TodoStartedEvent());
    } catch (_) {
      emit(const TodoErrorState());
    }
  }

  void _onItemUpdated(
      TodoItemUpdatedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var todoDomain = TodoDomainModel(event.todo.id, event.todo.title,
          event.todo.content, event.todo.isCompleted);
      updateTodoUseCase.execute(todoDomain);
      add(TodoStartedEvent());
    } catch (_) {
      emit(const TodoErrorState());
    }
  }

  void _onItemToggleCompleted(
      TodoItemToggleCompletedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var todoDomain = TodoDomainModel(event.todo.id, event.todo.title,
          event.todo.content, event.todo.isCompleted);
      toggleCompleteTodoUseCase.execute(todoDomain);
      add(TodoStartedEvent());
    } catch (_) {
      emit(const TodoErrorState());
    }
  }

  void _onItemDeleted(
      TodoItemDeletedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      deleteTodoUseCase.execute(event.id);
      add(TodoStartedEvent());
    } catch (_) {
      emit(const TodoErrorState());
    }
  }

  void _onItemUndoDeleted(
      TodoItemUndoDeletedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var todoDomain = TodoDomainModel(event.todo.id, event.todo.title,
          event.todo.content, event.todo.isCompleted);
      undoDeletedTodoUseCase.execute(todoDomain);
      add(TodoStartedEvent());
    } catch (_) {
      emit(const TodoErrorState());
    }
  }
}
