import 'package:flutter/material.dart';

class NumberToImg extends StatelessWidget {
  final int number;
  const NumberToImg({super.key,
  required this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: number.toString().split('')
        .map(
          (number)=>Image.asset(
            'asset/img/$number.png',
            width:50,
            height:70,
          ),
        ).toList()
    );
  }
}