

import 'dart:developer';

import 'package:e_learning/src/feature/timetable/bloc/index.dart';
import 'package:e_learning/src/feature/timetable/model/schedule_model.dart';
import 'package:e_learning/src/feature/timetable/model/timetable_model.dart';
import 'package:e_learning/src/feature/timetable/repository/repository_timetable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimetableBloc extends Bloc<TimetableEvent,TimetableState>{
  TimetableBloc():super(FetchingTime());
  TimetableRepository _timetableRepository = TimetableRepository();
  List<ScheduleModel> timeList =[];
  @override
  Stream<TimetableState> mapEventToState(TimetableEvent event) async*{
      if(event is FetchTimetableStarted){
        yield FetchingTime();
        try {
            timeList = await _timetableRepository.getTime();
            yield FetchedTime();
        } catch (e) {
          log(e.toString());
          yield ErrorFetchingTime(error: e.toString());
        }
      }
  }
}