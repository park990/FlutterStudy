import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  // {2023-11-23:[Shedule,Schedule]}
  Map<DateTime, List<ScheduleTable>> schedules = {
    DateTime.utc(2025, 11, 28): [
      // ScheduleTable(
      //   id: 1,
      //   startTime: 11,
      //   endTime: 12,
      //   content: '플러터 공부하기',
      //   date: DateTime.utc(2025,11,28),
      //   color: categoryColors[0],
      //   createdAt: DateTime.now().toUtc(),
      // ),
      // ScheduleTable(
      //   id: 2,
      //   startTime: 14,
      //   endTime: 16,
      //   content: 'Nest.JS 공부하기',
      //   date: DateTime.utc(2025,11,28),
      //   color: categoryColors[3],
      //   createdAt: DateTime.now().toUtc(),
      // ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final schedule = await showModalBottomSheet<ScheduleTable> (
            context: context,
            builder: (_) {
              return ScheduleBottomSheet(
                selectedDay:selectedDay,
              );
            },
          );
          if(schedule == null){
            return;
          }
          setState(() {
            // schedules={
            //   ...schedules,
            //   schedule.date:[
            //     if(schedules.containsKey(schedule.date))
            //       ...schedules[schedule.date]!,
            //     schedule
            //   ]
            // };
          });
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calender(
              focusedDay: DateTime(2025, 11, 28),
              onDaySelected: onDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            TodayBanner(selectedDay: selectedDay, taskCount: 0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: FutureBuilder<List<ScheduleTableData>>(
                  future: null,
                  builder: (context, asyncSnapshot) {
                    return ListView.separated(
                      itemCount: 0,
                        itemBuilder: (BuildContext context, int index){
                    
                          // List로 갖고옴 
                          // final selectedSchedules = schedules[selectedDay]!;
                          // final scheduleModel = selectedSchedules[index];
                    
                    
                          return ScheduleCard(startTime: 12,
                           endTime: 14,
                            content: 'test',
                             color: Color(
                              int.parse(
                                  'FF0000000',
                                  radix: 16
                                ),
                              ),
                            );
                        },
                        separatorBuilder: (BuildContext context, int  index){
                          return SizedBox(height: 8);
                        } ,
                      );
                  }
                ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 함수
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(DateTime date) {
    if (selectedDay == null) {
      return false;
    }
    return date.isAtSameMomentAs(selectedDay!);
  }
}
