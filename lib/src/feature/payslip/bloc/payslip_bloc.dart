import 'dart:developer';

import 'package:e_learning/src/feature/payslip/bloc/index.dart';
import 'package:e_learning/src/feature/payslip/model/payslip_model.dart';
import 'package:e_learning/src/feature/payslip/repository/payslip_repository.dart';
import 'package:e_learning/src/utils/share/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayslipBloc extends Bloc<PayslipEvent, PayslipState> {
  PayslipBloc() : super(InitailizingPayslip());
  PayslipRepository _payslipRepository = PayslipRepository();
  List<PayslipModel> payslip = [];
  int rowperpage = 12;
  int page = 1;
  String? dateRange;

  String? startDate;
  String? endDate;
  Helper helper = Helper();
  @override
  Stream<PayslipState> mapEventToState(PayslipEvent event) async* {
    if (event is InitailizePayslipStarted) {
      yield InitailizingPayslip();
      try {
        page = 1;
        payslip.clear();
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<PayslipModel> _departmentList =
            await _payslipRepository.getPayslip(
                rowperpage: rowperpage,
                page: page,
                startDate: startDate!,
                endDate: endDate!);
        payslip.addAll(_departmentList);
        page++;
        if (event.isSecond == true || event.isRefresh == 'yes') {
          yield FetchedPayslip();
        } else {
          yield InitailizedPayslip();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPayslip(error: e.toString());
      }
    }

    if (event is FetchPayslipStarted) {
      yield FetchingPayslip();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<PayslipModel> _departmentList =
            await _payslipRepository.getPayslip(
                rowperpage: rowperpage,
                page: page,
                startDate: startDate!,
                endDate: endDate!);
        payslip.addAll(_departmentList);
        page++;

        if (_departmentList.length < rowperpage) {
          yield EndofPayslip();
        } else {
          yield FetchedPayslip();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPayslip(error: e.toString());
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
