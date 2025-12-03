
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import 'package:drift/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:path_provider/path_provider.dart';

part 'drift.g.dart';

@DriftDatabase(
  tables: [ScheduleTable]
)
class AppDatabase extends _$AppDatabase{
  AppDatabase() : super(_openConnection());

  Future<ScheduleTableData> getScheduleById(int id)=>
  (select(scheduleTable)..where((table)=>table.id.equals(id))).getSingle();

  Future<int> updateScheduleById(int id, ScheduleTableCompanion data)
  => (update(scheduleTable)..where((table)=>table.id.equals(id))).write(data);

  Future<List<ScheduleTableData>> getSchedules(
    DateTime date,
  ) {
    // scheduleTable을 가져와야 하니 .. 으로 
    return (select(scheduleTable)..where((table)=>table.date.equals(date))).get();
  }

  Stream<List<ScheduleTableData>> streamSchedules(DateTime date)=>
  (select(scheduleTable)..where(
      (table)=>table.date.equals(date),

    )..orderBy([
      (table)=>OrderingTerm(expression: table.startTime,
      mode: OrderingMode.asc),
      (table)=>OrderingTerm(expression: table.endTime,
      mode: OrderingMode.asc),
    ])
  ).watch();


  Future<int> createSchedule(ScheduleTableCompanion data) => into(scheduleTable).insert(data);

  Future<int> removeSchedule(int id) => (delete(scheduleTable)..where((table)=>table.id.equals(id))).go();

  @override
  int get schemaVersion =>1;
  
}

LazyDatabase _openConnection() {
  return LazyDatabase(()async{
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path,'db.sqlite'));


  final cachebase = await getTemporaryDirectory();
  sqlite3.tempDirectory = cachebase.path;

  return NativeDatabase.createInBackground(file);
  });
}