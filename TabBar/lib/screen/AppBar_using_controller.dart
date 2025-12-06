import 'package:flutter/material.dart';
import 'package:front/const/tabs.dart';

class AppbarUsingController extends StatefulWidget {
  const AppbarUsingController({super.key});

  @override
  State<AppbarUsingController> createState() =>
      _AppbarUsingControllerState();
}

class _AppbarUsingControllerState
    extends State<AppbarUsingController>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: TABS.length,
      vsync: this,
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
        title: Text('APPBAR CONTROLLER'),
        bottom: TabBar(
          controller: tabController,
          tabs: TABS
              .map(
                (e) => Tab(
                  icon: Icon(e.icon),
                  child: Text(e.label),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: TABS
            .map(
              (e) => Container(
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(e.icon),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        if (tabController.index != 0)
                          ElevatedButton(
                            onPressed: () {
                              tabController.animateTo(
                                tabController.index - 1,
                              );   
                            },
                            child: Text('이전'),
                          ),
                        SizedBox(width: 16),
                        if (tabController.index !=tabController.length - 1)
                          ElevatedButton(
                            onPressed: () {
                              tabController.animateTo(
                                tabController.index + 1,
                              );
                            },
                            child: Text('다음'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
