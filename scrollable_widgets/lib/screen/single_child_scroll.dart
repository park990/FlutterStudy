import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

// 알아야 할점!
// SingleChildeScrollView 는 100개가 있으면 100개를 전부 렌더링 해버리는 거임 
// Pageable 예를들면 스크롤 아래로 내리면 더보기를 누를때다마 혹은 내릴때마다 데이터를 가져오지만 이거는 그냥 전부 다 가져와버려서
// 퍼포먼스가 그렇게 좋진 않다.


class SingleChildScroll extends StatelessWidget {
  final List<int> numbers = List.generate(
    100,
    (index) => index,
  );
  SingleChildScroll({super.key});

  @override
  Widget build(BuildContext context) {
    print(numbers);
    return MainLayout(
      title: 'SingleChildScroll',
      body: SingleChildPerformance(),
    );
  }

  // 1
  // 기본 렌더링법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors
            .map((e) => renderContainer(color: e))
            .toList(),
      ),
    );
  }

  // 2
  // 화면을 넘어가지 않아도 스크롤 가능 하지만 최신버전은 안되는듯
  Widget renderScrollAlways() {
    return SingleChildScrollView(
      physics:
          // NeverScrollablePhysics - 스크롤 불가()
          AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 3
  // 위젯이 잘리지 않도록 하기
  Widget renderClip() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 4
  // 여러가지 physics 정리
  Widget renderPhysics() {
    return SingleChildScrollView(
      // NeverScrollableScrollPhysics - 스크롤 X
      // AlwaysScrollableScrollPhysics - 스크롤 O
      // BouncingScrollPhysics - IOS 기본 스크롤 스타일 => 최대로 스크롤 때 흰색 배경
      // ClampingScrollPhysics - Android 기본 스크롤 스타일
      physics: ClampingScrollPhysics(),
      child: Column(
        children: rainbowColors
            .map((e) => renderContainer(color: e))
            .toList(),
      ),
    );
  }

  // 5
  // SingleChildPerformance
  Widget SingleChildPerformance() {
    return SingleChildScrollView(
      child: Column(
        children: numbers
            .map(
              (e) => renderContainer(
                color:
                    rainbowColors[e %
                        rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    int? index,
  }) {
    if (index != null) {
      print(index);
    }
    return Container(height: 300, color: color);
  }
}
