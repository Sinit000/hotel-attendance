import 'dart:developer';

import 'package:e_learning/src/feature/permission/bloc/index.dart';
import 'package:e_learning/src/feature/permission/model/leave_model.dart';
import 'package:e_learning/src/feature/permission/model/leave_type_model.dart';
import 'package:e_learning/src/feature/subtype/model/subtype_model.dart';
import 'package:e_learning/src/feature/permission/repository/leave_repository.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/share/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(FetchingLeaveType());
  List<LeaveTypeModel> leaveList = [];
  LeaveRepository leaveRepository = LeaveRepository();
  List<LeaveModel> myleave = [];
  List<LeaveModel> allLeave = [];

  int rowperpage = 12;
  String? dateRange;
  int page = 1;
  String? startDate;
  String? endDate;
  Helper helper = Helper();
  String? image;
  @override
  Stream<LeaveState> mapEventToState(LeaveEvent event) async* {
    if (event is FetchLeaveTypeStarted) {
      yield FetchingLeaveType();
      try {
        leaveList.clear();

        leaveList = await leaveRepository.getleavetype();

        yield FetchedLeaveType();
      } catch (e) {
        yield ErrorFetchingLeaveType(error: e.toString());
      }
    }

    if (event is InitializeLeaveStarted) {
      yield InitializingLeave();
      try {
        page = 1;
        myleave.clear();

        dateRange = event.dateRange;
        setEndDateAndStartDate();

      List<LeaveModel> leaveList = await leaveRepository.getleave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myleave.addAll(leaveList);
        page++;

        if (event.isSecond == true || event.isRefresh == 'yes') {
          yield FetchedLeave();
        } else {
          yield InitializedLeave();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeave(error: e.toString());
      }
    }
    if (event is FetchLeaveStarted) {
      yield FetchingLeave();

      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<LeaveModel> leaveList = await leaveRepository.getleave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);

        myleave.addAll(leaveList);
        print(leaveList.length);
        page++;

        if (leaveList.length < rowperpage) {
          yield EndOfLeaveList();
        } else {
          print(leaveList.length);
          yield FetchedLeave();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeave(error: e.toString());
      }
    }

    if (event is AddLeaveStarted) {
      yield AddingLeave();
      try {
        dateRange = "This month";
        if (event.imgUrl == null) {
          image = "";
        } else {
          image = await uploadImage(image: event.imgUrl!);
          print(image);
        }
        setEndDateAndStartDate();

        await leaveRepository.addleave(
            createDate: event.createdDate,
            date: event.today,
            notes: event.notes!,
            // subtype: event.subtype!,
            type: event.type,
            imgUrl: image!,
            // employeeId: event.employeeId,
            leavetypeId: event.leaveTypeId,
            reason: event.reason,
            number: event.number,
            fromDate: event.fromDate,
            // date: event.date,
            toDate: event.toDate);
        yield AddedLeave();
        yield FetchingLeave();
        myleave.clear();
        page = 1;
        // this week is default
        dateRange = "This month";
        setEndDateAndStartDate();
        List<LeaveModel> leaveList = await leaveRepository.getleave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myleave.addAll(leaveList);

        page++;
        yield FetchedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeave(error: e.toString());
      }
    }
    if (event is UpdateLeaveStarted) {
      yield AddingLeave();
      try {
        // if dont'have img file
        if (event.imgUrl == null) {
          image = event.imageUrl;
        } else {
          image = await uploadImage(image: event.imgUrl!);
          print(image);
        }
        await leaveRepository.editleave(
            createDate: event.createdDate,
            date: event.today,
            // subtype: event.subtype!,
            type: event.type,
            notes: event.notes!,
            imgUrl: image!,
            id: event.id,
            // employeeId: event.employeeId,
            leavetypeId: event.leaveTypeId,
            reason: event.reason,
            number: event.number,
            fromDate: event.fromDate,
            // date: event.date,
            toDate: event.toDate);
        yield AddedLeave();
        yield FetchingLeave();
        myleave.clear();
        page = 1;
        // this week is default
        dateRange = "This month";
        setEndDateAndStartDate();
        List<LeaveModel> leaveList = await leaveRepository.getleave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myleave.addAll(leaveList);

        page++;
        yield FetchedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeave(error: e.toString());
      }
    }
    if (event is UpdateLeaveStatusStarted) {
      yield AddingLeave();
      try {
        await leaveRepository.editleaveStatus(
            leaveDeduction: event.leaveDeduction,
            id: event.id,
            status: event.status);
        yield AddedLeave();
        yield FetchingLeave();
        allLeave.clear();
        page = 1;
        // this week is default
        dateRange = "This month";
        setEndDateAndStartDate();
        List<LeaveModel> leaveList = await leaveRepository.getAllLeave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        allLeave.addAll(leaveList);

        page++;
        yield FetchedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeave(error: e.toString());
      }
    }
    if (event is DeleteLeaveStarted) {
      yield AddingLeave();
      try {
        await leaveRepository.deleteleave(
          id: event.id,
          // employeeId: event.employeeId,
        );
        yield AddedLeave();
        yield FetchingLeave();
        myleave.clear();
        page = 1;
        // this week is default
        dateRange = "This month";
        setEndDateAndStartDate();
        List<LeaveModel> leaveList = await leaveRepository.getleave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        myleave.addAll(leaveList);

        page++;
        yield FetchedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeave(error: e.toString());
      }
    }
    // all leave function for chief of department
    if (event is InitializeAllLeaveStarted) {
      yield InitializingLeave();
      try {
        page = 1;
        allLeave.clear();
        // like Today, this week , this month, this year
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<LeaveModel> leaveList = await leaveRepository.getAllLeave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        allLeave.addAll(leaveList);

        page++;

        if (event.isSecond == true || event.isRefresh == 'yes') {
          yield FetchedLeave();
        } else {
          yield InitializedLeave();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeave(error: e.toString());
      }
    }
    if (event is FetchAllLeaveStarted) {
      yield FetchingLeave();

      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<LeaveModel> leaveList = await leaveRepository.getAllLeave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);

        allLeave.addAll(leaveList);

        page++;

        if (leaveList.length < rowperpage) {
          yield EndOfLeaveList();
        } else {
          yield FetchedLeave();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeave(error: e.toString());
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
