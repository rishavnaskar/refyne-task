import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_task_manager_flutter/app/ui/add_task_screen.dart';
import 'package:personal_task_manager_flutter/app/ui/home_screen.dart';
import 'package:personal_task_manager_flutter/app/ui/update_task_screen.dart';

class Routes {
  static const homeScreen = '/';
  static const addTaskScreen = 'add-task-screen';
  static const updateTaskScreen = 'update-task-screen';
}

final GoRouter goRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.homeScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: Routes.addTaskScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const AddTaskScreen();
          },
        ),
        GoRoute(
          path: Routes.updateTaskScreen,
          builder: (BuildContext context, GoRouterState state) {
            Map<String, dynamic> args = state.extra as Map<String, dynamic>;
            return UpdateTaskScreen(
              taskItem: args['taskItem'],
            );
          },
        ),
      ],
    ),
  ],
);
