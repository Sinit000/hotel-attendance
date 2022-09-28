import 'dart:developer';

import 'package:e_learning/src/feature/working_day/model/working_day_model.dart';
import 'package:e_learning/src/feature/working_day/repository/working_day_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class WorkingDayBloc extends Bloc<WorkingDayEvent, WorkingDayState> {
  WorkingDayBloc() : super(FetchingWorkingDay());

  WorkingDayRepository _departmentRepository = WorkingDayRepository();
  List<WorkdayModel> worklist = [];

  @override
  Stream<WorkingDayState> mapEventToState(WorkingDayEvent event) async* {
    if (event is FetchWoringdayStarted) {
      yield FetchingWorkingDay();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<WorkdayModel> _departmentList =
            await _departmentRepository.getWorkday();
        worklist.addAll(_departmentList);
        yield FetchedWorkingDay();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingWorkingDay(error: e.toString());
      }
    }
  }
}
