import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/filter/filter_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/task/task_bloc.dart';
import 'package:personal_task_manager_flutter/app/bloc/task/task_event.dart';
import 'package:personal_task_manager_flutter/app/dependency_injection/dependency_injection.dart';
import 'package:personal_task_manager_flutter/app/routes/router.dart';
import 'package:personal_task_manager_flutter/app/utils/colors.dart';
import 'package:personal_task_manager_flutter/database/database.dart';

Future<void> main() async {
  LocalDatabase database = LocalDatabase();
  await database.initialize();
  configureDependencies(database);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TaskBloc taskBloc = getIt<TaskBloc>();
  final FilterTasksBloc filterTasksBloc = getIt<FilterTasksBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => filterTasksBloc),
        BlocProvider(create: (context) => taskBloc..add(TaskStartedEvent())),
      ],
      child: MaterialApp.router(
        title: 'Personal Task App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: const AppBarTheme(
            backgroundColor: ambientColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
