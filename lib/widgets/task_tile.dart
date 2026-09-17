import 'package:flutter/material.dart';
import 'package:taskly_app/task.dart';

class TaskTile extends StatelessWidget {

  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;


  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xff0F172A).withValues(alpha: .1),
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0,4),
          )
        ],
        border: Border.all(
          color: Color(0xffE2E8F0),
          width: 1,
        )
      ),

      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(6)
            ),
            activeColor: Colors.blue,
              value: task.isDone,
              onChanged: (_) => onToggle(),

          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                    color: task.isDone ? Colors.grey : Colors.black,
                  ),
                ),
                if (task.description.isNotEmpty)
                  Text(
                    task.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                const SizedBox(height: 4,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: task.priority.color.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: task.priority.color, width: 1)
                  ),
                  child: Text(
                    task.priority.label,
                    style: TextStyle(
                      color: task.priority.color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete_outline, color: Colors.black38,)
          )
        ],
      ),
    );
  }
}
