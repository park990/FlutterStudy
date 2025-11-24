import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Container(
          height:200,
          width: 200,
          color:Colors.red,
          // 중요한 것 : 자식 위젯이 어디에 정렬될지 모를 떄 
          // 자식위젯의 크기는 무시가 된다.
          child: Align(
            alignment: Alignment(
              1,1,
            ),
            child: Container(
              width: 50,
              height:50,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}