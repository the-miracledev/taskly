import 'package:flutter/material.dart';

enum Priority { low, medium, high }

extension PriorityX on Priority {
  String get label {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
    }
  }

  Color get color {
    switch (this) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.orange;
      case Priority.high:
        return Colors.red;
    }
  }
}

class Task {
  String title;
  String description;
  Priority priority;
  bool isDone;

  Task({
    required this.title,
    this.description = '',
    required this.priority,
    this.isDone = false,
  });
}