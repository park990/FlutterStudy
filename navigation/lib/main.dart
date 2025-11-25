import 'package:flutter/material.dart';
import 'package:navigation/screen/home_scren.dart';
import 'package:navigation/screen/route1_screen.dart';
import 'package:navigation/screen/route2_screen.dart';
import 'package:navigation/screen/route3_screen.dart';

// Imperative vs Declarative
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:{
        // key - 라우트 이름
        // value - builder -> 이동하고 싶은 라우트
        '/': (BuildContext context)=> HomeScreen(),
        '/one': (BuildContext context)=>Route1Screen(
          number:999
          ),
        '/two':(BuildContext context)=>Route2Screen(),
        '/three':(BuildContext context)=>Route3Screen(), 
      }
    ),
  );
}

