import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/task.dart';

part 'tasks_state.freezed.dart';

@freezed
abstract class TasksState with _$TasksState {
  const factory TasksState({
    required List<Task> tasks,
    required bool isLoading,
    String? errorMessage,
  }) = _TasksState;

  factory TasksState.initial() => const TasksState(
    tasks: [],
    isLoading: false,
  );
}
