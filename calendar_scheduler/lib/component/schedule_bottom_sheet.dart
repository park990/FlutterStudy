import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDay;
  const ScheduleBottomSheet({super.key,
  required this.selectedDay});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formkey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

  String selectedColor = categoryColors.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                _Time(
                  onStartSaved: onStartTimeSaved,
                  onStartValidate: onStartTimeValidate,
                  onEndSaved: onEndTimeSaved,
                  onEndValidate: onEndTimeValidate,
                ), // 시간 표현 하는 stless
                SizedBox(height: 8),

                _Content(
                  onSaved: onContentSaved,
                  onValidate: onContentValidate,
                ), // 내용을 표현하는 stless
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

                _SaveButton(onPressed: onSavePressed), // 저장 버튼 stless
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 함수들

  // 시작 시간 저장
  void onStartTimeSaved(String? val) {
    if (val == null) {
      return null;
    }
    startTime = int.parse(val);
  }

  // 시작 시간 검증
  String? onStartTimeValidate(String? val) {
    if (val == null) {
      return '값을 입력 해주세요';
    }
    if (int.tryParse(val) == null) {
      return '숫자를 입력해 주세요';
    }
    final time = int.parse(val);
    if (time > 24 || time < 0) {
      return ('0과 24사이의 숫자만 입력 가능');
    }
    return null;
  }

  // 끝나는 시간 저장
  void onEndTimeSaved(String? val) {
    if (val == null) {
      return null;
    }
    endTime = int.parse(val);
  }

  // 끝나는 시간 검증
  String? onEndTimeValidate(String? val) {
    if (val == null) {
      return '값을 입력 해주세요';
    }
    if (int.tryParse(val) == null) {
      return '숫자를 입력해 주세요';
    }

    final time = int.parse(val);
    if (time > 24 || time < 0) {
      return ('0과 24사이의 숫자만 입력 가능');
    }
    return null;
  }

  // 내용 저장
  void onContentSaved(String? val) {
    if (val == null) {
      return null;
    }
    content = val;
  }

  // 내용 검증
  String? onContentValidate(String? val) {
    if (val == null) {
      return '내용을 입력해주세요';
    }
    if (val.length < 5) {
      return '5자 이상 입력해주세요';
    }

    return null;
  }

  // 저장버튼 눌렀을 때
  void onSavePressed() async {
    final isValid = formkey.currentState!.validate();

    if (isValid) {
      formkey.currentState!.save();
      final database = GetIt.I<AppDatabase>();

      await database.createSchedule(
        ScheduleTableCompanion(
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          color: Value(selectedColor),
          date: Value(widget.selectedDay)
        )
      );
      Navigator.of(context).pop();
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidate;
  final FormFieldValidator<String> onEndValidate;

  const _Time({
    super.key,
    required this.onStartSaved,
    required this.onEndSaved,
    required this.onStartValidate,
    required this.onEndValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: '시작시간',
            onSaved: onStartSaved,
            validator: onStartValidate,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: CustomTextField(
            label: '마감시간',
            onSaved: onEndSaved,
            validator: onEndValidate,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;

  const _Content({super.key, required this.onSaved, required this.onValidate});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        onSaved: onSaved,
        validator: onValidate,
      ),
    );
  }
}

typedef OnColorSelected = void Function(String color);

class _Categorys extends StatelessWidget {
  final String selectedColor;
  final OnColorSelected onTap;
  const _Categorys({
    super.key,
    required this.onTap,
    required this.selectedColor,
  });

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
                    border: e == selectedColor
                        ? Border.all(color: Colors.black, width: 4)
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
  final VoidCallback onPressed;
  const _SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
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
