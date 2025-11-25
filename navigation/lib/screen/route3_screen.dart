import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';

class Route3Screen extends StatelessWidget {
  const Route3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    return DefaultLayout(
      title: 'Route3 Screen',
      children: [
        Text(
          arguments.toString(),
          textAlign: TextAlign.center,
        ),
        OutlinedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text(
          'pop'
          ),
        ),
      ],
      );
  }
}