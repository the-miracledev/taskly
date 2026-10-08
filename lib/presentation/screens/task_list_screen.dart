import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly_app/controller/task_controller.dart';
import 'package:taskly_app/presentation/widgets/add_task_sheet.dart';
import 'package:taskly_app/presentation/widgets/dashboard_widget.dart';
import 'package:taskly_app/presentation/widgets/header_widget.dart';
import 'package:taskly_app/presentation/widgets/task_list_view.dart';

import '../../provider/task_provider.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(taskControllerProvider);
    final tasks = state.tasks;
    final ongoingTask= ref.read(uncompletedTasksProvider).length;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(),
            DashboardWidget(tasksLeft: ongoingTask,),
            TaskListView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => AddTaskSheet(addTask: (title, desc, priority) => ref
                .read(taskControllerProvider.notifier)
                .createTask(title, desc, priority),)
          );
        },
        icon:  Icon(Icons.add),
        label: Text('Add Task'),
      ),
    );
  }
}
