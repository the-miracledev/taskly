import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskly_app/presentation/theme/app_theme.dart';


class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key, required this.tasksLeft});

  final tasksLeft;
  @override
  Widget build(BuildContext context) {

    final dateStr = DateFormat('EEEE, d MMMM').format(DateTime.now()).toUpperCase();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateStr,
                style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600, fontSize: 11),
              ),
              Text(
                'Tasks',
                style: TextStyle(fontSize: 31, fontWeight: FontWeight.w900),
              )
            ],
          ),
          if(tasksLeft > 0) ...[
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                  color:  Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(24)
              ),
              child: Text(
                  "$tasksLeft Left"
              ),
            )
          ]

        ],
      ),
    );
  }
}
