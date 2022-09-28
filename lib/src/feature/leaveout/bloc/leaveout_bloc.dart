import 'dart:developer';
import 'package:e_learning/src/feature/leaveout/bloc/index.dart';
import 'package:e_learning/src/feature/leaveout/bloc/leaveout_event.dart';
import 'package:e_learning/src/feature/leaveout/model/leaveout_model.dart';
import 'package:e_learning/src/feature/leaveout/repository/leaveout_repository.dart';
import 'package:e_learning/src/feature/permission/repository/leave_repository.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/share/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaveOutBloc extends Bloc<LeaveOutEvent, LeaveoutState> {
  LeaveOutBloc() : super(InitializingLeaveOut());

  LeaveOutRepository leaveRepository = LeaveOutRepository();
  List<LeaveOutModel> myLeaveout = [];
  List<LeaveOutModel> allLeaveout = [];
  List<LeaveOutModel> security = [];

  int rowperpage = 12;
  String? dateRange;
  int page = 1;
  String? startDate;
  String? endDate;
  Helper helper = Helper();
  String? image;
  @override
  Stream<LeaveoutState> mapEventToState(LeaveOutEvent event) async* {
    if (event is InitializeMyLeaveOutStarted) {
      yield InitializingLeaveOut();
      try {
        page = 1;
        myLeaveout.clear();
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<LeaveOutModel> leaveList = await leaveRepository.getleaveout(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myLeaveout.addAll(leaveList);
        page++;
        if (event.isSecond == true || event.isRefresh == 'ye') {
          yield FetchedLeaveOut();
        } else {
          yield InitializedLeaveOut();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeaveOut(error: e.toString());
      }
    }
    if (event is FetchMyLeaveOutStarted) {
      yield FetchingLeaveOut();

      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<LeaveOutModel> leaveList = await leaveRepository.getleaveout(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myLeaveout.addAll(leaveList);
        page++;
        if (leaveList.length < rowperpage) {
          yield EndOfLeaveOutList();
        } else {
          print(leaveList.length);
          yield FetchedLeaveOut();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeaveOut(error: e.toString());
      }
    }

    if (event is AddLeaveOutStarted) {
      yield AddingLeaveOut();
      try {
        dateRange = "This month";

        setEndDateAndStartDate();
        print(startDate);
        print(endDate);
        await leaveRepository.addleaveOut(
            createDate: event.createdDate,
            date: event.today,
            reason: event.reason,
            // duration: event.duration,
            timein: event.timein,
            // type: event.type,
            timeout: event.timeout);
        yield AddedLeaveOut();
        yield FetchingLeaveOut();
        myLeaveout.clear();
        page = 1;
        // this week is default
        dateRange = "This month";
        setEndDateAndStartDate();
        List<LeaveOutModel> leaveList = await leaveRepository.getleaveout(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myLeaveout.addAll(leaveList);

        page++;
        yield FetchedLeaveOut();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeaveOut(error: e.toString());
      }
    }
    if (event is UpdateLeaveOutStarted) {
      yield AddingLeaveOut();
      try {
        dateRange = "This month";

        setEndDateAndStartDate();

        await leaveRepository.editleaveOut(
            createDate: event.createdDate,
            date: event.today,
            id: event.id,
            reason: event.reason,
            // duration: event.duration,
            timein: event.timein,
            // type: event.type,
            timeout: event.timeout);
        yield AddedLeaveOut();
        yield FetchingLeaveOut();
        myLeaveout.clear();
        page = 1;
        // this week is default
        dateRange = "This month";
        setEndDateAndStartDate();
        List<LeaveOutModel> leaveList = await leaveRepository.getleaveout(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myLeaveout.addAll(leaveList);

        page++;
        yield FetchedLeaveOut();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeaveOut(error: e.toString());
      }
    }

    if (event is DeleteLeaveOutStarted) {
      yield AddingLeaveOut();
      try {
        dateRange = "This month";

        setEndDateAndStartDate();

        await leaveRepository.deleteleaveOut(id: event.id);
        yield AddedLeaveOut();
        yield FetchingLeaveOut();
        myLeaveout.clear();
        page = 1;
        // this week is default
        dateRange = "This month";
        setEndDateAndStartDate();
        List<LeaveOutModel> leaveList = await leaveRepository.getleaveout(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myLeaveout.addAll(leaveList);

        page++;
        yield FetchedLeaveOut();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeaveOut(error: e.toString());
      }
    }
    // all leave function for chief of department
    if (event is InitializeAllLeaveOutStarted) {
      yield InitializingLeaveOut();
      try {
        page = 1;
        allLeaveout.clear();
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<LeaveOutModel> leaveList = await leaveRepository.getAllLeaveoutC(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        allLeaveout.addAll(leaveList);
        page++;
        if (event.isSecond == true || event.isRefresh == 'yes') {
          yield FetchedLeaveOut();
        } else {
          yield InitializedLeaveOut();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeaveOut(error: e.toString());
      }
    }
    if (event is FetchAllLeaveOutStarted) {
      yield FetchingLeaveOut();

      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<LeaveOutModel> leaveList = await leaveRepository.getAllLeaveoutC(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        allLeaveout.addAll(leaveList);

        page++;

        if (leaveList.length < rowperpage) {
          yield EndOfLeaveOutList();
        } else {
          yield FetchedLeaveOut();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeaveOut(error: e.toString());
      }
    }

    if (event is UpdateLeaveOutStatusStarted) {
      yield AddingLeaveOut();
      try {
        dateRange = "This month";

        setEndDateAndStartDate();

        await leaveRepository.editleaveOutStatusC(
            id: event.id, status: event.status);
        yield AddedLeaveOut();
        yield FetchingLeaveOut();
        allLeaveout.clear();
        page = 1;
        // this week is default
        dateRange = "This month";
        setEndDateAndStartDate();
        List<LeaveOutModel> leaveList = await leaveRepository.getAllLeaveoutC(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        allLeaveout.addAll(leaveList);

        page++;
        yield FetchedLeaveOut();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeaveOut(error: e.toString());
      }
    }
    // for security
    if (event is InitializeLeaveOutSecurityStarted) {
      yield InitializingLeaveOut();
      try {
        page = 1;
        security.clear();

        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<LeaveOutModel> leaveList = await leaveRepository.getAllLeaveoutS(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        security.addAll(leaveList);

        page++;

        if (event.isSecond == true || event.isRefresh == 'yes') {
          yield FetchedLeaveOut();
        } else {
          yield InitializedLeaveOut();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeaveOut(error: e.toString());
      }
    }
    if (event is FetchLeaveOutSecurityStarted) {
      yield FetchingLeaveOut();

      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<LeaveOutModel> leaveList = await leaveRepository.getAllLeaveoutS(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        security.addAll(leaveList);

        page++;

        if (leaveList.length < rowperpage) {
          yield EndOfLeaveOutList();
        } else {
          print(leaveList.length);
          yield FetchedLeaveOut();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeaveOut(error: e.toString());
      }
    }

    if (event is UpdateLeaveOutSStatusStarted) {
      yield AddingLeaveOut();
      try {
        dateRange = "This month";

        await leaveRepository.editleaveOutStatusS(
            id: event.id, status: event.status);
        yield AddedLeaveOut();
        yield FetchingLeaveOut();
        security.clear();
        page = 1;
        // this week is default
        dateRange = "This month";
        setEndDateAndStartDate();
        List<LeaveOutModel> leaveList = await leaveRepository.getAllLeaveoutS(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        security.addAll(leaveList);

        page++;
        yield FetchedLeaveOut();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeaveOut(error: e.toString());
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
