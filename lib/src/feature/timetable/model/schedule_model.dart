import 'package:e_learning/src/feature/timetable/model/timetable_model.dart';

class ScheduleModel {
  final String id;
  final TimetableModel? time;
  factory ScheduleModel.fromJson(Map<String,dynamic>json){
    return ScheduleModel(id: json["id"].toString(), time: json["timetable"]==null?null:TimetableModel.fromJson(json["timetable"]));
  }
  ScheduleModel({
    required this.id,
    required this.time
  });
}