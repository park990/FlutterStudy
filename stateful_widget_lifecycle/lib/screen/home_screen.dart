import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool show = false;
  Color color = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(show) GestureDetector(
              onTap: () {
                setState(() {
                  color= color == Colors.blue ? Colors.red: Colors.blue;
                });
              },
              child: Jaeyoon(
                color: color,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: (){
               setState(() {
                 show=!show;
               });
              },
              child: Text("클릭해서 보이기/안보이기"))
          ],
        ),
      )
    );
  }
}

class Jaeyoon extends StatefulWidget {
  final Color color;
   Jaeyoon({super.key,
   required this.color,})
  {
      print("1 Stateful Widget Constructor");
  }

  @override
  State<Jaeyoon> createState(){
    print('2 Stateful Widget Create State');
    return _JaeyoonState();
  }
}

class _JaeyoonState extends State<Jaeyoon> {

  @override
  void initState() {
    print('3 Stateful widget initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('4 Stateful widget didChangeDependencies');

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('5 Stateful widget build');
    return SafeArea(
      child: Container(
        color:widget.color,
        width: 50,
        height:50,
      ),
    );
  }
   
  @override
  void deactivate() {
    print('6 Stateful widget deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('7 Stateful widget dispose');
    super.dispose();
  }
}