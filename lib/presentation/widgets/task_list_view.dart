import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly_app/presentation/widgets/filter_pill.dart';
import 'package:taskly_app/presentation/widgets/task_tile.dart';
import 'package:taskly_app/presentation/widgets/update_task_sheet.dart';
import 'package:taskly_app/provider/task_filter_provider.dart';

import '../../controller/task_controller.dart';
import '../../models/task.dart';

class TaskListView extends ConsumerWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(taskControllerProvider);

    final selectedFilter = ref.watch(taskFilterProvider);
    final displayedTask = ref.watch(filteredTaskProvider);
    final selectedPriority = ref.watch(priorityFilterProvider);


    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: filters.values.map((filter) {
                      return FilterPill(
                          filterName: filter.label,
                          isSelected: selectedFilter == filter,
                          onTap:() => ref.read(taskFilterProvider.notifier).setFilter(filter)
                      );
                    }).toList()
                  ),
                  PopupMenuButton<Priority?>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary
                      )
                    ),
                    initialValue: selectedPriority,
                    onSelected: (priority) { ref.read(priorityFilterProvider.notifier).setPriority(priority);},
                    onCanceled: (){ref.read(priorityFilterProvider.notifier).setPriority(null);},
                    itemBuilder: (context) => [
                      const PopupMenuItem<Priority?>(
                        value: null,
                        child: Text("All priorities"),
                      ),
                      ...Priority.values.map(
                              (priority) => PopupMenuItem<Priority?>(
                            value: priority,
                            child: Row(
                              children: [
                                Icon(Icons.circle, size: 8, color: priority.color,),
                                SizedBox(width: 6,),
                                Text(priority.label)
                              ],
                            ),
                          )
                      )
                    ] ,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1)
                      ),
                      child: Row(
                        children: [
                          Text(selectedPriority == null ? 'All Priorities' : '${selectedPriority.label} priority',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.tertiary),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: displayedTask.isEmpty
                  ? Center(
                child: Text(
                  selectedFilter.emptyMessage,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ) :ListView.builder(
                itemCount: displayedTask.length,
                  itemBuilder: (context, index){
                  final task = displayedTask[index];
                  return TaskTile(
                    task: task,
                    onView: (){
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => UpdateTaskSheet(
                            title: task.title,
                            description: task.description,
                            priority: task.priority,
                            updateTask: (title, desc, priority) => ref
                                .read(taskControllerProvider.notifier)
                                .editTask(task.id, title, desc, priority),
                          )
                      );
                    },
                    onToggle: () => ref.read(taskControllerProvider.notifier).toggleTask(task.id),
                    onDelete: () => ref.read(taskControllerProvider.notifier).deleteTask(task.id),
                  );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
