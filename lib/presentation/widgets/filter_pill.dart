import 'package:flutter/material.dart';
import 'package:taskly_app/presentation/theme/app_theme.dart';

class FilterPill extends StatelessWidget {
  const FilterPill({super.key,required this.filterName,required this.isSelected,required this.onTap});
  final String filterName;
  final bool isSelected;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.colorScheme.primary, width: 1)
        ),
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text( filterName, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Theme.of(context).colorScheme.tertiary ) ,),
      ),
    );
  }
}
