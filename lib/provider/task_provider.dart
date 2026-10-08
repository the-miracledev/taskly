import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../controller/task_controller.dart';
import '../models/task.dart';

part 'task_provider.g.dart';

@riverpod
List<Task> completedTasks(Ref ref) {
  final tasks = ref.watch(taskControllerProvider).tasks;
  final completed = tasks.where((task) => task.isCompleted).toList();

  completed.sort((a, b) => b.priority.index.compareTo(a.priority.index));

  return completed;
}

@riverpod
List<Task> uncompletedTasks(Ref ref) {
  final tasks = ref.watch(taskControllerProvider).tasks;
  final uncompleted = tasks.where((task) => !task.isCompleted).toList();

  uncompleted.sort((a, b) => b.priority.index.compareTo(a.priority.index));

  return uncompleted;
}