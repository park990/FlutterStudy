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
import 'package:get_it/get_it.dart';

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
          await showModalBottomSheet<ScheduleTable> (
            context: context,
            builder: (_) {
              return ScheduleBottomSheet(
                selectedDay:selectedDay,
                id: null,
              );
            },
          );
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
            StreamBuilder(
              stream: GetIt.I<AppDatabase>().streamSchedules(selectedDay),
              builder: (context, snapshot) {
                return TodayBanner(selectedDay: selectedDay,
                 taskCount: !snapshot.hasData ? 0:snapshot.data!.length);
              }
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: StreamBuilder<List<ScheduleTableData>>(
                  stream: GetIt.I<AppDatabase>().streamSchedules(selectedDay),
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: Text(snapshot.error.toString()
                        ),
                      );
                    }
                    print('호ㅓ호호호호호$snapshot');
                    if(snapshot.data==null){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final schedules = snapshot.data!;

                    return ListView.separated(
                      itemCount: schedules.length,
                        itemBuilder: (BuildContext context, int index){
                          // List로 갖고옴 
                          // final selectedSchedules = schedules[selectedDay]!;
                          // final scheduleModel = selectedSchedules[index];

                          final schedule = schedules[index];
                          return Dismissible(
                            key: ObjectKey(schedule.id),
                            direction: DismissDirection.endToStart,
                            // confirmDismiss: (DismissDirection direction) async{
                            //   await GetIt.I<AppDatabase>().removeSchedule(
                            //     schedule.id
                            //   );
                            //   return true;
                            // },
                            onDismissed: (direction) {
                              GetIt.I<AppDatabase>().removeSchedule(
                                schedule.id
                              );
                            },
                            child: GestureDetector(
                              onTap: () async{
                                await showModalBottomSheet<ScheduleTable>(
                                  context:context,
                                  builder:(_){
                                    return ScheduleBottomSheet(
                                      id: schedule.id,
                                       selectedDay: selectedDay);
                                  },
                                );
                              },
                              child: ScheduleCard(
                                startTime: schedule.startTime,
                                endTime: schedule.endTime,
                                content: schedule.content,
                                 color: Color(
                                  int.parse(
                                      'FF${schedule.color}',
                                      radix: 16
                                    ),
                                  ),
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
