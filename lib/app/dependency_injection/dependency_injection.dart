import 'package:get_it/get_it.dart';
import 'package:personal_task_manager_flutter/app/bloc/filter/filter_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/task/task_bloc.dart';
import 'package:personal_task_manager_flutter/data/datasource/crud_datasource.dart';
import 'package:personal_task_manager_flutter/data/repository_implementation/task_repository_implementation.dart';
import 'package:personal_task_manager_flutter/domain/repository/task_repository.dart';
import 'package:personal_task_manager_flutter/domain/usecases/add_task_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/delete_task_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/get_all_tasks_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/toggle_complete_task_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/undo_deleted_task_usecase.dart';
import 'package:personal_task_manager_flutter/domain/usecases/update_task_usecase.dart';

GetIt getIt = GetIt.instance;

Future configureDependencies(CRUDDataSource database) async {
  getIt.registerLazySingleton<CRUDDataSource>(() => database);
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImplementation(getIt()),
  );
  getIt.registerLazySingleton<GetAllTasksUseCase>(
    () => GetAllTasksUseCase(getIt()),
  );
  getIt.registerLazySingleton<AddTaskUseCase>(() => AddTaskUseCase(getIt()));
  getIt.registerLazySingleton<UpdateTaskUseCase>(
    () => UpdateTaskUseCase(getIt()),
  );
  getIt.registerLazySingleton<ToggleCompleteTaskUseCase>(
    () => ToggleCompleteTaskUseCase(getIt()),
  );
  getIt.registerLazySingleton<DeleteTaskUseCase>(
    () => DeleteTaskUseCase(getIt()),
  );
  getIt.registerLazySingleton<UndoDeletedTaskUseCase>(
    () => UndoDeletedTaskUseCase(getIt()),
  );
  getIt.registerFactory<TaskBloc>(
    () => TaskBloc(
        getAllTasksUseCase: getIt(),
        addTaskUseCase: getIt(),
        updateTaskUseCase: getIt(),
        toggleCompleteTaskUseCase: getIt(),
        deleteTaskUseCase: getIt(),
        undoDeletedTaskUseCase: getIt()),
  );
  getIt.registerFactory<FilterTasksBloc>(() => FilterTasksBloc());
}
