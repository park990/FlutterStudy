import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  CustomScrollViewScreen({super.key});

  // 크게 다른점은 appBar까지 Sivers 에 포함시켜서 같이 스크롤 되게 끔 하는거 그게 말곤 ListView랑 비슷함.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppbar(),
          renderSliverGridBuilder(),
        ],
      ),
    );
  }





  // AppBar
  SliverAppBar renderSliverAppbar(){
    return   SliverAppBar(
      title: Text('CustomScrollViewScreen'),

      // 기본이 false인데 true로하면 스크롤 올리면 바로 앱바가 보임
      floating: true,

      // true: 앱바 완전 고정
      pinned: false,

      // 조금만 올려도 튀어 나오는데 이때는 pinned(고정)을 false로 해야지 작동함
      // false로 하면 조금만 올리면 앱바가 조금만 내려옴
      snap: false,

      // true로 하면 최대로 스크롤 할 때 앱바가 늘어남 (안드로이드는 피직스 수정해야된다.)
      stretch: false,

      // 늘어나는 최대 
      expandedHeight: 100,
      collapsedHeight: 80, 


      flexibleSpace: FlexibleSpaceBar(
        title: Text('Flexible'),

        // 아래처럼 늘어나는 곳에 사진도 첨부 할 수 있음
        // background:Image.asset('경로',fit: BoxFit.cover,
        // ),
      ),
      );
  }


  // Gridview.builder와 비슷함.
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      }, childCount: 100),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }

  // GridView.count와 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  // ListView 기본생성자와 유사함
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
    );
  }

  // ListView.Builder 생성자와 유사
  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      }),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);

    return Container(
      key: Key(index.toString()),
      height: height == null ? 300 : height,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
