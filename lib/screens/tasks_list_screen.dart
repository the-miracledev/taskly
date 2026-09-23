import 'package:flutter/material.dart';
import 'package:taskly_app/widgets/add_task_sheet.dart';
import 'package:taskly_app/widgets/task_tile.dart';

import '../task.dart';

class TasksListScreen extends StatefulWidget {
  const TasksListScreen({super.key});

  @override
  State<TasksListScreen> createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {

  // final List<Task> tasks = [];
  final List<Task> tasks = [
    Task(title: 'Review design feedback', priority: Priority.medium),
    Task(title: 'Review code feedback', priority: Priority.low),
    Task(title: 'Review assignment feedback', priority: Priority.low),
    Task(title: 'Review design feedback', priority: Priority.medium),
    Task(title: 'Reply to support tickets', description: 'Clear the backlog', priority: Priority.high),
  ];

  void _toggleDone(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
     final incompleteCount = tasks.where((t) => !t.isDone).length;
     final pendingTasks = tasks.where((t) => !t.isDone).toList();
     final completedTasks = tasks.where((t) => t.isDone).toList();
    return Scaffold(
      backgroundColor: Color(0xffF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _header(incompleteCount),
            SizedBox(height: 10,),
            _tasklist(pendingTasks, completedTasks),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await showModalBottomSheet<Task>(
            context: context,
            isScrollControlled: true,
            // constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            builder: (context) => const AddTaskSheet(),
          );
          if(newTask != null){
            setState(() {
              tasks.add(newTask);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task added successfully')),
            );
          }

        },
        backgroundColor: Colors.blue,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  
  
  
  Expanded _tasklist(List<Task> pendingTasks, List<Task> completedTasks) {
    return Expanded(
            child: tasks.isEmpty
                ? const Center(
              child: Text(
                'No tasks yet, tap + to add one',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
            : ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                if (pendingTasks.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Ongoing',
                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                  ),
                  ...pendingTasks.map((task) {
                    final index = tasks.indexOf(task);
                    return TaskTile(
                      task: task,
                      onToggle: () => _toggleDone(index),
                      onDelete: () => _deleteTask(index),
                    );
                  }),
                ],
                if (completedTasks.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Completed',
                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                  ),
                  ...completedTasks.map((task) {
                    final index = tasks.indexOf(task);
                    return TaskTile(
                      task: task,
                      onToggle: () => _toggleDone(index),
                      onDelete: () => _deleteTask(index),
                    );
                  }),
                ],
              ],
            ),
          );
  }


  Container _header(int incompleteCount) {
    return Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Taskly",
                    style:  TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    Text("Manage your day productively",
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$incompleteCount left',
                  style: TextStyle(
                  color: Colors.blue.shade700,
                    fontWeight: FontWeight.w600,
                  )
                  ),
                )
              ],
            ),
          );
  }
}
