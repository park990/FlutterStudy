import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final List<Widget> children;
  final title;
  
  const DefaultLayout({
  super.key,
  required this.children,
  required this.title,
  }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
