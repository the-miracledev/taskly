import 'package:flutter/material.dart';
import 'package:taskly_app/widgets/priority_chip.dart';

import '../task.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}


class _AddTaskSheetState extends State<AddTaskSheet> {

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Priority _selectedPriority = Priority.medium;
  @override
  void dispose(){
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit(){
    final title = _titleController.text.trim();

    if(title.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title cannot be empty'))
      );
      Navigator.pop(context);
      return; 
    }

    final  task = Task(
        title: title,
        priority: _selectedPriority,
        description: _descriptionController.text.trim()
    );

    Navigator.pop(context, task);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New task',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),
            const Text(
              'TASK NAME',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 6,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .1),
                    blurRadius: 10,
                    spreadRadius: 0
                  )
                ]
              ),
              child: TextField(
                controller: _titleController,
                style: TextStyle(
                  fontSize: 14
                ),
                decoration: InputDecoration(
                  hintText: 'E.g Review Design Feedback',
                  hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                ),
              ),
            ),
            const SizedBox(height: 20,),
            const Text(
              'DESCRIPTION',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 6,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: .1),
                        blurRadius: 10,
                        spreadRadius: 0
                    )
                  ]
              ),
              child: TextField(
                controller: _descriptionController,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                    hintText: 'E.g Review Design Feedback',
                    hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                ),
              ),
            ),
            const SizedBox(height: 20,),
            const Text(
              'PRIORITY LEVEL',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 6,),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: PriorityChip(
                      priority: Priority.low,
                      isSelected: _selectedPriority == Priority.low,
                      onTap: () => setState(() => _selectedPriority = Priority.low),
                    ),
                  ),
                  Expanded(
                    child: PriorityChip(
                      priority: Priority.medium,
                      isSelected: _selectedPriority == Priority.medium,
                      onTap: () => setState(() => _selectedPriority = Priority.medium),
                    ),
                  ),
                  Expanded(
                    child: PriorityChip(
                      priority: Priority.high,
                      isSelected: _selectedPriority == Priority.high,
                      onTap: () => setState(() => _selectedPriority = Priority.high),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 24,),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                child: Text('Add Task',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ) ,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
