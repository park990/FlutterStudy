import 'package:flutter/material.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';
import 'package:scrollable_widgets/screen/custom_scroll_view_screen.dart';
import 'package:scrollable_widgets/screen/grid_view_screen.dart';
import 'package:scrollable_widgets/screen/list_view_screen.dart';
import 'package:scrollable_widgets/screen/refresh_indicator.dart';
import 'package:scrollable_widgets/screen/reorderable_list_view_screen.dart';
import 'package:scrollable_widgets/screen/scrollbar_screen.dart';
import 'package:scrollable_widgets/screen/single_child_scroll.dart';

class ScreenModel {
  final WidgetBuilder builder;
  final String name;

  ScreenModel({required this.builder, required this.name});
}

class HomeScreen extends StatelessWidget {
  final screens = [
    ScreenModel(
      builder: (_) => SingleChildScroll(),
      name: 'SingleChildScrollViewH',
    ),
    ScreenModel(
      builder: (_) => ListViewScreen(),
      name: 'ListViewScreenH',
    ),
    ScreenModel(
      builder: (_) => GridViewScreen(),
      name: 'GridViewScreenH',
    ),
    ScreenModel(
      builder: (_) => ReorderableListViewScreen(),
      name: 'ReorderableListviewScreenH',
    ),
    ScreenModel(
      builder:(_)=> CustomScrollViewScreen(),
       name: 'CustomScrollViewScreenH'
      ),
    ScreenModel(
      builder: (_) => ScrollbarScreen(),
      name: 'ScrollBarScreenH',
    ),
    ScreenModel(
      builder: (_) => RefreshIndicatorScreen(),
      name: 'RefreshIndicatorScreenH',
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: screens
                .map(
                  (screen) => ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: screen.builder,
                        ),
                      );
                    },
                    child: Text(screen.name),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
