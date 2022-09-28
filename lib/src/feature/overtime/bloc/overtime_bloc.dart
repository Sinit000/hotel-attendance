import 'dart:developer';
import 'package:e_learning/src/feature/overtime/bloc/index.dart';
import 'package:e_learning/src/feature/overtime/model/overtime_model.dart';
import 'package:e_learning/src/feature/overtime/repository/overtime_repository.dart';
import 'package:e_learning/src/utils/share/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverTimeBloc extends Bloc<OverTimeEvent, OverTimeState> {
  OverTimeBloc() : super(InitailizingOvertime());
  OverTimeRepository _overTimeRepository = OverTimeRepository();
  List<OvertimeModel> myovertime = [];
  List<OvertimeModel> chieflist = [];
  int rowperpage = 12;
  String? dateRange;
  int page = 1;
  String? startDate;
  String? endDate;
  Helper helper = Helper();
  @override
  Stream<OverTimeState> mapEventToState(OverTimeEvent event) async* {
    if (event is InitailzeMyOvertimeStarted) {
      yield InitailizingOvertime();
      try {
        page = 1;
        myovertime.clear();
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<OvertimeModel> overtime = await _overTimeRepository.getMyOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myovertime.addAll(overtime);
        page++;
        if (event.isSecond == true || event.isRefresh == 'yes') {
          yield FetchedOvertime();
        } else {
          yield InitailizedOvertime();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingOvertime(error: e.toString());
      }
    }

    if (event is FetchMyOvertimeStarted) {
      yield FetchingOvertime();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<OvertimeModel> overtime = await _overTimeRepository.getMyOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myovertime.addAll(overtime);
        page++;
        if (overtime.length < rowperpage) {
          yield EndofOvertimeList();
        } else {
          yield FetchedOvertime();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingOvertime(error: e.toString());
      }
    }
    if (event is UpdateOvertimeStatusStarted) {
      yield AddingOvertime();
      try {
        await _overTimeRepository.editStatusOT(
            status: event.status, id: event.id, paytype: event.paytype);
        yield AddedOvertime();
        yield FetchingOvertime();
        myovertime.clear();
        page = 1;
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OvertimeModel> overtime = await _overTimeRepository.getMyOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myovertime.addAll(overtime);
        page++;
        yield FetchedOvertime();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingOvertime(error: e.toString());
      }
    }
    if (event is InitializeAllOvertimeStarted) {
      yield InitailizingOvertime();
      try {
        page = 1;
        myovertime.clear();
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<OvertimeModel> overtime = await _overTimeRepository.getOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myovertime.addAll(overtime);
        page++;

        if (event.isSecond == true || event.isRefresh == 'yes') {
          yield FetchedOvertime();
        } else {
          yield InitailizedOvertime();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingOvertime(error: e.toString());
      }
    }

    if (event is FetchAllOvertimeStarted) {
      yield FetchingOvertime();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();
      
        List<OvertimeModel> overtime = await _overTimeRepository.getOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myovertime.addAll(overtime);
        page++;

        if (overtime.length < rowperpage) {
          print(chieflist.length);
          yield EndofOvertimeList();
        } else {
          yield FetchedOvertime();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingOvertime(error: e.toString());
      }
    }
    if (event is AddOvertimeStarted) {
      yield AddingOvertime();
      try {
        await _overTimeRepository.addOvertime(
            userId: event.userId,
            reason: event.reason,
            duration: event.duration,
            fromDate: event.fromDate,
            notes: event.notes,
            type: event.type,
            otMethod: event.otMethod,
            createDate: event.createdDate,
            date: event.today,
            toDate: event.toDate);
        yield AddedOvertime();
        yield FetchingOvertime();
        myovertime.clear();
        page = 1;
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OvertimeModel> overtime = await _overTimeRepository.getOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myovertime.addAll(overtime);
        page++;
        yield FetchedOvertime();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingOvertime(error: e.toString());
      }
    }
    if (event is UpdateOvertimeStarted) {
      yield AddingOvertime();
      try {
        await _overTimeRepository.editOvertime(
            id: event.id,
            userId: event.userId,
            reason: event.reason,
            duration: event.duration,
            fromDate: event.fromDate,
            notes: event.notes,
            type: event.type,
            otMethod: event.otMethod,
            createDate: event.createdDate,
            date: event.today,
            toDate: event.toDate);
        yield AddedOvertime();
        yield FetchingOvertime();
        myovertime.clear();
        page = 1;
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OvertimeModel> overtime = await _overTimeRepository.getOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myovertime.addAll(overtime);
        page++;
        yield FetchedOvertime();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingOvertime(error: e.toString());
      }
    }
    if (event is DeleteOvertimeStarted) {
      yield AddingOvertime();
      try {
        await _overTimeRepository.deleteOvertime(
          id: event.id,
        );
        yield AddedOvertime();
        yield FetchingOvertime();
        myovertime.clear();
        page = 1;
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OvertimeModel> overtime = await _overTimeRepository.getOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myovertime.addAll(overtime);
        page++;
        yield FetchedOvertime();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingOvertime(error: e.toString());
      }
    }
  }

  void setEndDateAndStartDate() {
    DateTime now = DateTime.now();
    if (dateRange == "Today") {
      dateRange = "Today";
      startDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(now.day)}";
      endDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(now.day)} 23:59:59";
    } else if (dateRange == "This week") {
      dateRange = "This week";
      DateTime startDateThisWeek = helper.findFirstDateOfTheWeek(now);
      DateTime endDateThisWeek = helper.findLastDateOfTheWeek(now);
      startDate =
          "${now.year}-${helper.intToStringWithPrefixZero(startDateThisWeek.month)}-${helper.intToStringWithPrefixZero(startDateThisWeek.day)}";
      if (helper.intToStringWithPrefixZero(startDateThisWeek.month) == "12" &&
          (helper.intToStringWithPrefixZero(endDateThisWeek.month) == "01")) {
        endDate =
            "${now.year + 1}-${helper.intToStringWithPrefixZero(endDateThisWeek.month)}-${helper.intToStringWithPrefixZero(endDateThisWeek.day)} 23:59:59";
      } else {
        endDate =
            "${now.year}-${helper.intToStringWithPrefixZero(endDateThisWeek.month)}-${helper.intToStringWithPrefixZero(endDateThisWeek.day)} 23:59:59";
      }
    } else if (dateRange == "This month") {
      dateRange = "This month";
      DateTime lastDateOfMonth = DateTime(now.year, now.month + 1, 0);
      startDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-01";
      endDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(lastDateOfMonth.day)} 23:59:59";
    } else if (dateRange == "This year") {
      dateRange = "This year";
      DateTime lastDateOfYear = DateTime(now.year + 1, 1, 0);
      startDate = "${now.year}-01-01";
      endDate =
          "${now.year}-12-${helper.intToStringWithPrefixZero(lastDateOfYear.day)} 23:59:59";
    } else {
      startDate = dateRange!.split("/").first;
      endDate = dateRange!.split("/").last + " 23:59:59";
      dateRange = "$startDate to ${dateRange!.split("/").last}";
    }
  }
}
