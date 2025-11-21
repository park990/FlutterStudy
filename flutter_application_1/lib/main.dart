import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //0xFF를 앞에 꼭 넣어줘야함
        //0x: 16진수 표현
        //FF: 투명도
        // 99d1d0
        backgroundColor: Color(0xFF99d1d0),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/logo.png'
            ),
            SizedBox(height: 28.0), // Padding 보다 효율이 좋을 수 도
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
        ),
    );
  }
}
// statelesswidget

