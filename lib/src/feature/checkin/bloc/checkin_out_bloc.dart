import 'dart:developer';

import 'package:e_learning/src/feature/checkin/bloc/index.dart';
import 'package:e_learning/src/feature/checkin/model/checkin_model.dart';
import 'package:e_learning/src/feature/checkin/repository/checkin_out_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInOutBloc extends Bloc<CheckInOutEvent, CheckInOutState> {
  CheckInOutBloc() : super(AddingCheckin());
  CheckInOutRepository checkInOutRepository = CheckInOutRepository();
  List<CheckinModel> checkilist = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<CheckInOutState> mapEventToState(CheckInOutEvent event) async* {
    if (event is AddCheckinStarted) {
      yield AddingCheckin();
      try {
        checkInOutRepository.checkin(
            checkinTime: event.checkinTime,
            lat: event.lat,
            lon: event.lon,
            locationId: event.locationId,
            date: event.date,
            timetableId: event.timetableId);
        yield AddedCheckin();
      } catch (e) {
        yield ErrorAddingCheckInOut(error: e.toString());
      }
    }
    if (event is InitializeCheckinStarted) {
      yield InitializingCheckin();
      try {
        page = 1;
        checkilist = await checkInOutRepository.getcheckin(
            page: page, rowperpage: rowperpage);
        // leavemodel.addAll(leaveList);
        print(checkilist.length);
        page++;
        print(page);
        print(checkilist.length);
        if (checkilist.length < rowperpage) {
          yield EndOfCheckinList();
        } else {
          yield InitializedCheckin();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingCheckin(error: e.toString());
      }
    }
    if (event is FetchCheckinStarted) {
      yield FetchingCheckin();
      try {
        List<CheckinModel> _leaveList = await checkInOutRepository.getcheckin(
            page: page, rowperpage: rowperpage);
        checkilist.addAll(_leaveList);
        print(checkilist.length);
        page++;
        print(page);
        print(_leaveList.length);
        if (_leaveList.length < rowperpage) {
          yield EndOfCheckinList();
        } else {
          yield FetchedCheckin();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingCheckin(error: e.toString());
      }
    }
    if (event is RefreshCheckinStarted) {
      yield RefreshingCheckin();
      try {
        page = 1;
        if (checkilist.length != 0) {
          checkilist.clear();
        }
        List<CheckinModel> _leaveList = await checkInOutRepository.getcheckin(
            page: page, rowperpage: rowperpage);
        checkilist.addAll(_leaveList);
        print(checkilist.length);
        yield RefreshedCheckin();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingCheckin(error: e.toString());
      }
    }
    if (event is AddCheckoutStarted) {
      yield AddingCheckin();
      try {
        checkInOutRepository.checkin(
            checkinTime: event.checkoutTime,
            lat: event.lat,
            lon: event.lon,
            locationId: event.locationId,
            date: event.date,
            timetableId: event.timetableId);
        yield AddedCheckin();
      } catch (e) {
        yield ErrorAddingCheckInOut(error: e.toString());
      }
    }
  }
}
