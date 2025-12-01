import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  String selectedColor = categoryColors.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
          child: Column(
            children: [
              _Time(), // 시간 표현 하는 stless
              SizedBox(height: 8),

              _Content(), // 내용을 표현하는 stless
              SizedBox(height: 8),

              _Categorys(
                selectedColor: selectedColor,
                onTap: (String color) {
                  print('받은색은 $color');
                  setState(() {
                    selectedColor = color;
                    print('받은 $color  를 selected에 지정');
                  });
                },
              ), // 색들을 표현하는 stless
              SizedBox(height: 8),

              _SaveButton(), // 저장 버튼 stless
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomTextField(label: '시작시간')),
        SizedBox(width: 16),
        Expanded(child: CustomTextField(label: '마감시간')),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(child: CustomTextField(label: '내용', expand: true));
  }
}



typedef OnColorSelected = void Function(String color);

class _Categorys extends StatelessWidget {
  final String selectedColor;
  final OnColorSelected onTap;
  const _Categorys({super.key, required this.onTap,
  required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categoryColors
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  print('준색은 $e');
                  onTap(e);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(int.parse('FF$e', radix: 16)),
                    shape: BoxShape.circle,
                    border: e==selectedColor 
                      ? Border.all(
                      color: Colors.black,
                      width: 4
                    )
                      : null,
                  ),
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
