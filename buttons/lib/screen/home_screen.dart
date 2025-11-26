import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  // 배경 색깔
                  backgroundColor: Colors.red,
                  disabledBackgroundColor: Colors.grey,
                  // 배경 위의 색깔
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.amber,
                  // 그림자 색깔
                  shadowColor: Colors.green,
                  elevation: 10,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                  padding: EdgeInsets.all(32),
                  side:BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                  // maximumSize: Size(200, 150),
                  
                ),
                child: Text(
                  'elevated Button'
                ),
              ),
              OutlinedButton(
                onPressed: (){},
                style: ButtonStyle(
                  // 마우스 커
                  backgroundColor: WidgetStatePropertyAll(
                  Colors.red ,
                  ),
                  minimumSize: WidgetStatePropertyAll(
                    Size(200, 150)
                  ),
                ),
                child: Text(
                  'outlined Button'
                ),
              ),
               TextButton(
                onPressed: (){},
                style: ButtonStyle(
                  backgroundColor: WidgetStateColor.resolveWith(
                    (Set<WidgetState> states){
                      if(states.contains(WidgetState.pressed)){
                        return Colors.red;
                      }
                      return Colors.black;
                    }
                  ),
                  foregroundColor: WidgetStateColor.resolveWith(
                    (states){
                      if (states.contains(WidgetState.pressed)){
                        return Colors.black;
                      }
                      return Colors.white;
                    },
                  ),
                  minimumSize: WidgetStateProperty.resolveWith(
                    (states){
                      if(states.contains(WidgetState.pressed)){
                        return Size(200, 150);
                      }
                      return Size(300, 200);
                    },
                  ),
                ),
                child: Text(
                  'text Button'
                ),
              ),
              OutlinedButton(
                onPressed: (){},
                style: OutlinedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                child: Text(
                  'OutLinedButton shape'    
                ),
              ),
              ElevatedButton.icon(
              onPressed: (){},
              icon: Icon(
                  Icons.keyboard_alt_outlined
                ),
                label: Text('키보드'),
              ),
              TextButton.icon(
              onPressed: (){},
              icon: Icon(
                  Icons.keyboard_alt_outlined
                ),
                label: Text('키보드'),
              ),
              OutlinedButton.icon(
              onPressed: (){},
              icon: Icon(
                  Icons.keyboard_alt_outlined
                ),
                label: Text('키보드'),
              ),      
          ],
        ),
      ),
    );
  }
}