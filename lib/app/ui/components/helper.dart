import 'package:fl_three_state_switch/fl_three_state_switch.dart';
import 'package:flutter/material.dart';
import 'package:personal_task_manager_flutter/app/models/task_item.dart';

class SnackBarHelper {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required String label,
    required Function onPress,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: label,
          onPressed: () => onPress(),
        ),
      ));
  }
}

String? contentFieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a content';
  }
  if (value.length > 200) {
    return 'Content cannot be longer than 200 characters';
  }
  return null;
}

String? titleFieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a title';
  }
  if (value.length > 50) {
    return 'Title cannot be longer than 50 characters';
  }
  return null;
}

String getFilterTitle(SwitchState switchState) {
  switch (switchState) {
    case SwitchState.start:
      return 'Complete';
    case SwitchState.end:
      return 'Incomplete';
    case SwitchState.middle:
    default:
      return 'All';
  }
}

List<TaskItem> getTasksAfterFiltering(
    List<TaskItem> tasksList, SwitchState switchState) {
  switch (switchState) {
    case SwitchState.start:
      return tasksList.where((val) => val.isCompleted).toList();
    case SwitchState.end:
      return tasksList.where((val) => !val.isCompleted).toList();
    case SwitchState.middle:
    default:
      return tasksList;
  }
}
