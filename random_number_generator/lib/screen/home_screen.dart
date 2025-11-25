import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_to_img.dart';
import 'package:random_number_generator/constant/color.dart';
import 'dart:math';

import 'package:random_number_generator/screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> numbers=[
            123,
            456,
            789,
          ];
  
  int maxNumber=1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16, // 좌 우
            vertical: 16, // 상 하
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // 제목과 아이콘 버튼
              _Header(
                onPressed: onSettingIconPressed,
              ),

              // 숫자
              _Body(
                numbers: numbers,
              ),

              // 버튼
              _Footer(
                onPressed: genarateRandomNumber,
              ),

            ],
          ),
        ),
      ),
    );
  }
  onSettingIconPressed() async{
    final result = await Navigator.of(context).push(
      // 이동하고 싶은 화면은 MaterialRoute로 감싸줘야한다. 빌더는 실제 빌더랑 똑같이
      // 그리고 반환은 그냥 페이지를 반환하면 된다.
      MaterialPageRoute(
        builder: (BuildContext context){
          return SettingScreen(
            maxNumber: maxNumber,
          );
        },
      )
    );
    maxNumber=result;
  }
  
  genarateRandomNumber(){
  
    final rand =Random();
    
    final Set<int> newNumbers={};

      while(newNumbers.length<3){
        final randomNumber=rand.nextInt(maxNumber);
        newNumbers.add(randomNumber);
      }
      setState(() {
        numbers=newNumbers.toList();
    });
  }
}


class _Header extends StatelessWidget {
  final VoidCallback onPressed;
  const _Header({super.key,
  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return 
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("랜덤숫자 생성기",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700
          ),
        ),
        
        IconButton(
          color: redcolor,
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> numbers;

  const _Body({super.key,
  required this.numbers});

  @override
  Widget build(BuildContext context) {
    return 
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: numbers
            .map(
              (e)=>NumberToImg(number: e,
              )
            ).toList(),
        ),
        
        
      );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;
  const _Footer({super.key,
  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return
    ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
      backgroundColor: redcolor,
      foregroundColor: Colors.white,
    ),
    child: Text('생성하기'),
    );
  }
}