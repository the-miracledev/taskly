import 'package:flutter/material.dart';
import 'package:taskly_app/screens/tasks_list_screen.dart';

void main() {
  runApp(const TasklyApp());
}

class TasklyApp extends StatelessWidget {
  const TasklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      title: 'Taskly',
      debugShowCheckedModeBanner: false,
      home: TasksListScreen(),
    );
  }
}