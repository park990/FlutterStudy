import 'package:flutter/material.dart';
import 'package:calendar_scheduler/const/color.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int taskCount;

  const TodayBanner({super.key,
  required this.selectedDay,
  required this.taskCount});
  

  @override
  Widget build(BuildContext context) {

    
    return Container(
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '$taskCount개',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
