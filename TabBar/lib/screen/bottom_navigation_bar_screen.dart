import 'package:flutter/material.dart';
import 'package:front/const/tabs.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> with TickerProviderStateMixin{
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController=TabController(
    length: TABS.length,
    vsync: this
    );
    
    tabController.addListener((){
      setState(() {
        
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BOTTOM NAV BAR'),
      ),
      body: TabBarView(
        controller: tabController,
        children: TABS.map(
          (e)=> Center(
            child: Icon(e.icon),
          )
        ).toList()
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: tabController.index,

        // 확대
        type: BottomNavigationBarType.shifting,

        // tab 눌렀을 때 컨트롤러에게 index가 바뀌었다고 알려줌
        onTap: (index){
          tabController.animateTo(index);
        },
        items: TABS.map(
          (e)=>BottomNavigationBarItem(
            icon: Icon(e.icon),
            label: e.label,
            )
        ).toList()
      ),
    );
  }
}