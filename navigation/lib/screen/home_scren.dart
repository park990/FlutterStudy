import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route1_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: DefaultLayout(
        title: 'HomeScreen',
        children: [
          OutlinedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Route1Screen(
                      number: 20,
                    );
                  },
                ),
              );
              print("ghghghg $result");
            },
            child: Text('push'),
          ),
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
        ],
      ),
    );
  }
}
