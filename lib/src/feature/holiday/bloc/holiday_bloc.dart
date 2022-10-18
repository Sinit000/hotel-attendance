import 'dart:developer';

import 'package:e_learning/src/feature/holiday/bloc/index.dart';
import 'package:e_learning/src/feature/holiday/model/holiday_model.dart';
import 'package:e_learning/src/feature/holiday/repository/holiday_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HolidayBloc extends Bloc<HolidayEvent, HolidayState> {
  HolidayBloc() : super(FetchingHoliday());
  // List<HolidayModel> leaveList = [];
  HolidayRepository leaveRepository = HolidayRepository();
  List<HolidayModel> holidaylist = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<HolidayState> mapEventToState(HolidayEvent event) async* {
    if (event is FetchHolidayStarted) {
      yield FetchingHoliday();
      try {
        List<HolidayModel> _templist = await leaveRepository.getHoliday();
        holidaylist.addAll(_templist);
        // leavemodel.addAll(leaveList);
        yield FetchedHoliday();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingHoliday(error: e.toString());
      }
    }
    if (event is InitailizePHStarted) {
      yield InitailizingPH();
      try {
        // page = 1;
        holidaylist.clear();
        List<HolidayModel> _templist = await leaveRepository.getPh();
        holidaylist.addAll(_templist);
        yield InitailizedPH();
      } catch (e) {
        yield ErrorFetchingHoliday(error: e.toString());
      }
    }
    if (event is FetchPHStarted) {
      yield FetchingHoliday();
      try {
         holidaylist.clear();
        List<HolidayModel> _templist = await leaveRepository.getPh();
        holidaylist.addAll(_templist);
        // leavemodel.addAll(leaveList);
        yield FetchedHoliday();
      } catch (e) {
        yield ErrorFetchingHoliday(error: e.toString());
      }
    }
  }
}
