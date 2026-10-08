import 'package:flutter/material.dart';

import '../../models/task.dart';
import '../theme/app_theme.dart';

class PriorityChip extends StatelessWidget {
  const PriorityChip({super.key, required this.priority, required this.isSelected, required this.onTap});

  final Priority priority;
  final bool  isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.darkPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 4,
              width: 2,
              decoration: BoxDecoration(
                color: priority.color,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(width: 6,),
            Text(
              priority.label, style: TextStyle(color: isSelected ? Colors.white : Theme.of(context).colorScheme.tertiary,),
            )
          ],
        ),
      ),
    );
  }
}
