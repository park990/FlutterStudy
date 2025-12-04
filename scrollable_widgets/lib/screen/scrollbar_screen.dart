import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

final List<int> numbers = List.generate(100, (index) => index);

class ScrollbarScreen extends StatelessWidget {
  const ScrollbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "ScrollBar",
      body: Scrollbar(
        interactive: true,   
        child: SingleChildScrollView(
          child: Column(
            children: numbers
                .map(
                  (e) => renderContainer(
                    color: rainbowColors[e % rainbowColors.length],
                    index: e,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    required int? index,
    double? height,
  }) {
    print(index);

    return Container(
      key: Key(index.toString()),
      height: height == null ? 300 : height,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
