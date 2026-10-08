import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

enum Priority { low, medium, high }

extension PriorityName on Priority {
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
@freezed
abstract class Task with _$Task {
  const Task._();
  const factory Task({
    required String id,
    required String title,
    required bool isCompleted,
    required Priority priority,
    String? description,
  }) = _Task;

  factory Task.fromMap(Map<String, dynamic> map){
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description:  map['description'] as String?,
      isCompleted: (map['isCompleted'] as int) == 1,
      priority:  Priority.values.firstWhere(
              (p) => p.name == map['priority']
      ),
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'title' : title,
      'description' : description,
      'isCompleted' : isCompleted ? 1 : 0,
      'priority' : priority.name,
    };
  }
}
