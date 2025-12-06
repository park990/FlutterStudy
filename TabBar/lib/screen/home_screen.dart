import 'package:flutter/material.dart';
import 'package:front/screen/AppBar_using_controller.dart';
import 'package:front/screen/Basic_Bar_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomeScreen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contextBuilder) {
                      return BasicBarScreen();
                    },
                  ),
                );
              },
              child: Text('Basic AppBar TabBar Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contextBuilder) {
                      return AppbarUsingController();
                    },
                  ),
                );
              },
              child: Text('APPBARCONTROLLER'),
            ),
          ],
        ),
      ),
    );
  }
}
