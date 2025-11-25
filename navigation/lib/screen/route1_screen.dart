import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route2_screen.dart';

class Route1Screen extends StatelessWidget {
  final int number;
  const Route1Screen({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // 시스템에서 제공해주는 뒤로가기 기능 제어 가능
      canPop: false,
      child: DefaultLayout(
        title: 'Route1 Screen',
        children: [
          Text('$number', textAlign: TextAlign.center),
          OutlinedButton(
            onPressed: (){
              Navigator.of(context).pop(
                999999
              );
            },
            child: Text(
            "pop",
          ),
          ),
          OutlinedButton(
            onPressed: (){
              // pop이 가능한 페이지가 없으면 pop 실행 X
              Navigator.of(context).maybePop(
                999999
              );
            },
            child: Text(
            "Maybe POP",
          ),
          ),
          OutlinedButton(
            onPressed: (){
              print(Navigator.of(context).canPop());
            },
            child: Text(
            "Can POP",
          ),
          ),
      
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Route2Screen();
                  },
                  settings: RouteSettings(
                    arguments: 555555
                  ),
                ),
              );
            },
            child: Text('push'),
          ),
        ],
      ),
    );
  }
}
