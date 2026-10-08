import 'package:flutter/material.dart';
import 'package:taskly_app/presentation/widgets/priority_chip.dart';
import '../../models/task.dart';

typedef AddTaskCallback = void Function(String title, String? desc, Priority priority );

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key, required this.addTask});
  final AddTaskCallback addTask;

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}


class _AddTaskSheetState extends State<AddTaskSheet> {

  final tittleController = TextEditingController();
  final descriptionController = TextEditingController();
  Priority selectedPriority = Priority.medium;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )
        ),
        child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
              bottom:16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 4,
                      width: 100,
                      decoration: BoxDecoration(
                          color:Theme.of(context).colorScheme.outline,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: Text('Add Task', style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1
                      ),),
                    ),
                    IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close_rounded, size: 20,))
                  ],
                ),
                SizedBox(height: 10,),

                Text("Task Title", style: TextStyle( fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 5,),
                TextField(
                    controller: tittleController,
                    autofocus: true,
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        hintText: "What needs to be done",
                        hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)
                    )
                ),
                SizedBox(height: 10,),
                Text("Task Description", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 5,),
                TextField(
                    controller: descriptionController,
                    autocorrect: true,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        hintText: "What needs to be done",
                        hintStyle: TextStyle(fontSize: 12,  fontWeight: FontWeight.normal)
                    )
                ),
                SizedBox(height: 10,),
                Text("Task Priority", style: TextStyle( fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: PriorityChip(priority: Priority.low, isSelected: selectedPriority == Priority.low, onTap: () => setState(() {
                          selectedPriority =  Priority.low;
                        })),
                      ),
                      Expanded(
                        child: PriorityChip(priority: Priority.medium, isSelected: selectedPriority == Priority.medium, onTap: () => setState(() {
                          selectedPriority =  Priority.medium;
                        })),
                      ),
                      Expanded(
                        child: PriorityChip(priority: Priority.high, isSelected: selectedPriority == Priority.high, onTap: () => setState(() {
                          selectedPriority = Priority.high;
                        })),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(width: double.infinity, height: 50,
                    child: ElevatedButton(
                        onPressed: (){
                          final title = tittleController.text;
                          if(title.trim().isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title is required")));
                            return;
                          }
                          widget.addTask.call(title, descriptionController.text, selectedPriority );
                          Navigator.pop(context);
                        },
                        child: Text("Create Task")))
              ],
            )
        ),
      ),
    );
  }
}
