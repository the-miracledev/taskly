import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly_app/presentation/theme/app_theme.dart';
import 'package:taskly_app/provider/theme_provider.dart';

import '../../provider/task_filter_provider.dart';

class HeaderWidget extends ConsumerStatefulWidget {
  const HeaderWidget({super.key});

  @override
  ConsumerState<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends ConsumerState<HeaderWidget> {
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
    ref.read(searchQueryProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context) {

    final themeNotifier = ref.watch(themeProvider);
    final isDark = themeNotifier == ThemeMode.dark;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _isSearching ?
                TextField(
                  controller: _searchController,
                  onChanged: (value) => ref.read(searchQueryProvider.notifier).setQuery(value),
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: _stopSearching,
                    ),
                  ),
                )
                : Row(
              children: [
                Image.asset('lib/assets/images/taskly_logo.png', height: 25,),
                SizedBox(width: 4,),
                Text('Taskly', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          if(!_isSearching) ...[
            IconButton(
                onPressed: (){
                  setState(() {
                    _isSearching = true;
                  });
                },
                icon: Icon(Icons.search_rounded, size: 20, color: AppTheme.accent,)
            ),
            IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, size: 20, color: AppTheme.accent,),
            ),

          ]
        ],
      ),
    );
  }
}
