import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JaeyoonWidget(),
    );
  }
}

class JaeyoonWidget extends StatelessWidget {
    JaeyoonWidget({super.key}){
    print("생성자!!");
  }

  @override
  Widget build(BuildContext context) {
    print("빌드!!");

    return SafeArea(
      child: Container(
        width: 50,
        height:50,
        color: Colors.red,
      ),
    );
  }
}