import 'dart:developer';

import 'package:e_learning/src/feature/report/bloc/index.dart';
import 'package:e_learning/src/feature/report/model/report_model.dart';
import 'package:e_learning/src/feature/report/repository/report_repository.dart';
import 'package:e_learning/src/utils/share/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(FetchingReport());
  List<ReportModel> myreport = [];
  ReportRepository _reportRepository = ReportRepository();

  int rowperpage = 12;
  String? dateRange;
  int page = 1;
  String? startDate;
  String? endDate;
  Helper helper = Helper();
  @override
  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    if (event is InitailizeReportStarted) {
      yield InitializingReport();
      try {
        dateRange = event.dateRange;
        print(dateRange);
        setEndDateAndStartDate();
        myreport.clear();
        page = 1;
        List<ReportModel> _temList = await _reportRepository.getReport(
            endDate: endDate!,
            startDate: startDate!,
            page: page,
            rowperpage: rowperpage);
        myreport.addAll(_temList);
        page++;
        print(myreport.length);
        if (event.isSecond == true || event.isRefresh=='yes') {
          yield FetchedReport();
        } else {
          yield InitializedReport();
        }
      } catch (e) {
        log(e.toString());
        ErrorFetchingReport(error: e.toString());
      }
    }
    if (event is FetchReportStarted) {
      yield FetchingReport();
      try {
        print(myreport.length);
        dateRange = event.dateRange;
        print(dateRange);
        print(page);
        setEndDateAndStartDate();
        List<ReportModel> _temList = await _reportRepository.getReport(
            endDate: endDate!,
            startDate: startDate!,
            page: page,
            rowperpage: rowperpage);
        myreport.addAll(_temList);
        page++;
        print(page);
        print(myreport.length);
        if (_temList.length < rowperpage) {
          yield EndOfReportList();
        } else {
          print(myreport.length);
          yield FetchedReport();
        }
      } catch (e) {
        log(e.toString());
        ErrorFetchingReport(error: e.toString());
      }
    }
    // if (event is RefreshReportStarted) {
    //   yield FetchingReport();
    //   try {
    //     myreport.clear();
    //     page = 1;
    //     dateRange = event.dateRange;
    //     print(dateRange);
    //     setEndDateAndStartDate();
    //     List<ReportModel> _temList = await _reportRepository.getReport(
    //         endDate: endDate!,
    //         startDate: startDate!,
    //         page: page,
    //         rowperpage: rowperpage);
    //     myreport.addAll(_temList);
    //     page++;
    //     yield FetchedReport();
    //   } catch (e) {
    //     log(e.toString());
    //     ErrorFetchingReport(error: e.toString());
    //   }
    // }
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
