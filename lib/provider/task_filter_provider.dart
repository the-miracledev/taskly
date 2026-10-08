import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taskly_app/provider/task_provider.dart';

import '../controller/task_controller.dart';
import '../models/task.dart';

part 'task_filter_provider.g.dart';

enum filters {all, upcoming, done}

extension TaskFilterX on filters{
  String get label{
    switch(this){
      case filters.all:
        return 'All';
      case filters.done:
        return 'Done';
      case filters.upcoming:
        return 'Upcoming';
    }
  }

  String get emptyMessage{
    switch(this){
      case filters.all:
        return 'You have no task';
      case filters.done:
        return 'You have not completed any task';
      case filters.upcoming:
        return 'You have no upcoming task';
    }

  }
}

@riverpod
class TaskFilter extends _$TaskFilter{
  @override
  filters build() => filters.all;

  void setFilter(filters filter){
    state = filter;
  }
}

@riverpod
class priorityFilter extends _$priorityFilter{
  @override
  Priority? build() => null;

  void setPriority(Priority? priority){
    state = priority;
  }
}


@riverpod
class SearchQuery extends _$SearchQuery{
  @override
  String build() => '';

  void setQuery(String query){
    state = query;
  }
  void clear(){
    state = '';
  }

}

@riverpod
List<Task> filteredTask(Ref ref){
  final filter = ref.watch(taskFilterProvider);
  final priorityFilter = ref.watch(priorityFilterProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  final allTasks = ref.watch(taskControllerProvider).tasks;
  final ongoingTasks = ref.watch(uncompletedTasksProvider);
  final completedTasks = ref.watch(completedTasksProvider);

  List<Task> tasks;
  switch(filter){
    case filters.all:
      tasks = allTasks;
      break;
    case filters.upcoming:
      tasks = ongoingTasks;
      break;
    case filters.done:
      tasks =  completedTasks;
      break;
  }

  if(priorityFilter != null){
    tasks = tasks.where((task) => task.priority == priorityFilter).toList();
  }


  if(searchQuery.isNotEmpty){
    tasks = tasks.where((task) {
      final titleMatch = task.title.toLowerCase().contains(searchQuery);
      final descMatch = task.description?.toLowerCase().contains(searchQuery) ?? false;
      return titleMatch || descMatch;
    }).toList();
  }


  return tasks;
}

