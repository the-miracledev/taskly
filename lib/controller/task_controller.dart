import 'package:taskly_app/state/tasks_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/task.dart';
import '../storage/database_helper.dart';

part 'task_controller.g.dart';

@riverpod
class TaskController extends _$TaskController {
  TasksState build(){
    Future.microtask(() => _loadTasks());
    return TasksState.initial().copyWith(isLoading: true);
  }

  Future<void> _loadTasks() async{
    final tasks = await DatabaseHelper.instance.getAllTask();
    state = state.copyWith(tasks: tasks, isLoading: false);
  }

  Future<void> createTask(String title, String? desc, Priority priority) async{
    final trimmedTitle = title.trim();
    final trimmedDesc = desc?.trim();

    if(trimmedTitle.isEmpty){
      return;
    }

    final newTask = Task(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: trimmedTitle,
        description: trimmedDesc != null && trimmedDesc.isNotEmpty ? trimmedDesc : null,
        isCompleted: false,
        priority: priority
    );
    await DatabaseHelper.instance.insertTask(newTask);
    state = state.copyWith(tasks: [newTask, ...state.tasks]);
  }


  Future<void> toggleTask(String id) async{
    final taskIndex = state.tasks.indexWhere((task) => task.id == id);
    if(taskIndex == -1) return;

    final updatedTask = state.tasks[taskIndex].copyWith(isCompleted: !state.tasks[taskIndex].isCompleted);

    await DatabaseHelper.instance.updateTask(updatedTask);

    final updatedTasks = state.tasks.map((task){
      return task.id == id ? updatedTask : task ;
    }).toList();

    state = state.copyWith(tasks: updatedTasks);
  }

  Future<void> deleteTask(String id) async{
    await DatabaseHelper.instance.deleteTask(id);

    final updatedTasks = state.tasks.where((task) => task.id != id ).toList();
    state = state.copyWith(tasks:  updatedTasks);
  }

  Future<void> editTask(String id, String title, String? desc, Priority priority) async{
    final trimmedTitle = title.trim();
    final trimmedDesc = desc?.trim();

    if(trimmedTitle.isEmpty) return;

    final taskIndex = state.tasks.indexWhere((task) => task.id == id);
    if(taskIndex == -1){
      state = state.copyWith(errorMessage: "Task not found");
      return;
    }

    final updatedTask = state.tasks[taskIndex].copyWith(
      title: trimmedTitle,
      description: trimmedDesc,
      priority: priority,
    );
    await DatabaseHelper.instance.updateTask(updatedTask);
    final updatedTasks = state.tasks.map((task) {
      return task.id == id ? updatedTask : task;
    }).toList();
    state = state.copyWith(tasks: updatedTasks);
  }


}