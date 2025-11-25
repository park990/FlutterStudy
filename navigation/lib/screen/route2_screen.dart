import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route3_screen.dart';

class Route2Screen extends StatelessWidget {
  const Route2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return DefaultLayout(
      title: "Route2 Screen",
      children: [
        Text(arguments.toString(), textAlign: TextAlign.center),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("pop"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/three", arguments: 1111111111);
          },
          child: Text("push Route3"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Route3Screen();
                },
                settings: RouteSettings(
                  arguments: 999,
                ),
              ),
            );
          },
          child: Text('Push Replacement'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              "/three",
              arguments: 99933,
            );
          },
          child: Text('Push ReplacementNamed'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/three",
              (route){
                // 만약에 삭제할거면 (Route Stack) false를 반환
                // 만약에 삭제를 안할거면 true 반환

                // 아래는 '/'(home) 페이지를 제외하고 다 제거 
                // 즉 route 3 페이지 까지 가지만 pop으로 돌아오면 home 만 존재.
                return route.settings.name=='/';
              },
              arguments: 99933,
            );
          },
          child: Text('Push Named And Remove Until'),
        ),
      ],
    );
  }
}
