import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
        stream: StreamNumbers(),
       builder: (BuildContext context, AsyncSnapshot<int> snaps){
        print('------------data--------------');
        print(snaps.connectionState);
        print(snaps.data);

        // ConnectionState.none; -> Future 또는 Stream이 입력되지 않은상태
        // ConnectionState.active; -> Stream에서만 존재 / 스트림 아직 실행중
        // ConnectionState.done;  -> Future 또는 Stream이 종료 됐을때
        // ConnectionState.waiting; -> 실행중

          if(snaps.connectionState==ConnectionState.active){
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center ,
                children: [
                  CircularProgressIndicator(),
                  Text(snaps.data.toString())
                ],
              ),
            );
          }

          // error 확인
          if(snaps.hasError){
           final error= snaps.error;
            return Center(
              child: Text('$error'),
            );
          }
          // 데이터가 존재하는지 확인
          if(snaps.hasData){
            final data = snaps.data;
          return Center(
            child: Text(
              data.toString(),
            ),
          );
          }  
          return Center(
            child: Text(
              '데이터가 없습니다'
            ),
          );
       },
       ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));

    final random = Random(); 
    
    // return random.nextInt(10);
    throw 'errrrrrorrrrrrrrr';
    
  }

  Stream<int> StreamNumbers() async* {
    for(int i =0; i<10;i++){
      await Future.delayed(Duration(seconds: 1));
      if(i==5){
        throw "STREAM_errorrrrrrrrr";
      }
      yield i;
    }
  }
}