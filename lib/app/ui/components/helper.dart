import 'package:flutter/material.dart';

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
