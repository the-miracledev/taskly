import 'package:flutter/material.dart';

import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, required this.onView, required this.onToggle, required this.onDelete});
  final VoidCallback onView;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onView,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Checkbox(value: task.isCompleted, onChanged: (_) => onToggle()),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style:  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,

                    ),
                  ),
                  if(task.description != null && task.description!.trim().isNotEmpty)
                    Text(task.description!, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.tertiary),)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              decoration: BoxDecoration(
                color: task.priority.color.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(task.priority.label, style: TextStyle(color: task.priority.color, fontSize: 10),),
            ),
            // IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded, size: 20,)),
            IconButton(onPressed: onDelete, icon: Icon(Icons.delete_outline_outlined, size: 20,))
          ],
        ),
      ),
    );
  }
}
