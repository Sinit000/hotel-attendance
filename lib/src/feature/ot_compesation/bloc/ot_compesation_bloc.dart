import 'dart:developer';
import 'package:e_learning/src/feature/ot_compesation/bloc/index.dart';
import 'package:e_learning/src/feature/ot_compesation/model/ot_compesation_model.dart';

import 'package:e_learning/src/feature/ot_compesation/repository/ot_compesation_repository.dart';

import 'package:e_learning/src/utils/share/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTCompesationBloc extends Bloc<OTCompesationEvent, OTCompesationState> {
  OTCompesationBloc() : super(InitailizingOTCompesation());
  List<OTCompesationModel> otComList = [];
  OTCompesationRepository _otCompesationRepository = OTCompesationRepository();
  List<OTCompesationModel> songlist = [];
  int rowperpage = 12;

  String? dateRange;
  int page = 1;
  String? startDate;
  String? endDate;
  Helper helper = Helper();
  @override
  Stream<OTCompesationState> mapEventToState(OTCompesationEvent event) async* {
    if (event is InitailzeOTCompesationStarted) {
      yield InitailizingOTCompesation();
      try {
        page = 1;
        otComList.clear();
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getOTCompesation(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        otComList.addAll(overtime);
        page++;
        if (event.isRefresh == true || event.isSecond == true) {
          yield FetchedOTCompesation();
        }
        yield InitailizedOTCompesation();
      } catch (e) {
        yield ErrorFetchingOTCompesation(error: e.toString());
      }
    }
    if (event is FetchOTCompesationStarted) {
      yield FetchingOTCompesation();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getOTCompesation(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        otComList.addAll(overtime);
        page++;
        if (overtime.length < rowperpage) {
          yield EndofOTCompesationList();
        } else {
          yield FetchedOTCompesation();
        }
      } catch (e) {
        yield ErrorFetchingOTCompesation(error: e.toString());
      }
    }
    if (event is AddOTCompesationStarted) {
      yield AddingOTCompesation();
      try {
        await _otCompesationRepository.addOTCompesation(
            reason: event.reason,
            duration: event.duration,
            fromDate: event.fromDate,
            type: event.type,
            createDate: event.createdDate,
            date: event.today,
            toDate: event.toDate);
        yield AddedOTCompesation();
        yield FetchingOTCompesation();
        otComList.clear();
        page = 1;
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getOTCompesation(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        otComList.addAll(overtime);
        page++;
        yield FetchedOTCompesation();
      } catch (e) {
        yield ErrorAddingOTCompesation(error: e.toString());
      }
    }
    if (event is UpdateOTCompesationStarted) {
      yield AddingOTCompesation();
      try {
        await _otCompesationRepository.editOTCompesation(
            id: event.id,
            reason: event.reason,
            duration: event.duration,
            fromDate: event.fromDate,
            type: event.type,
            createDate: event.createdDate,
            date: event.today,
            toDate: event.toDate);
        yield AddedOTCompesation();
        yield FetchingOTCompesation();
        otComList.clear();
        page = 1;
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getOTCompesation(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        otComList.addAll(overtime);
        page++;
        yield FetchedOTCompesation();
      } catch (e) {
        yield ErrorAddingOTCompesation(error: e.toString());
      }
    }
    if (event is DeleteOTCompesationStarted) {
      yield AddingOTCompesation();
      try {
        await _otCompesationRepository.deleteOTCompesation(id: event.id);
        yield AddedOTCompesation();
        yield FetchingOTCompesation();
        otComList.clear();
        page = 1;
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getOTCompesation(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        otComList.addAll(overtime);
        page++;
        yield FetchedOTCompesation();
      } catch (e) {
        yield ErrorAddingOTCompesation(error: e.toString());
      }
    }
    // songMong
    if (event is InitailzeSongMongStarted) {
      yield InitailizingSongMong();
      try {
        page = 1;
        songlist.clear();
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getSongMong(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        songlist.addAll(overtime);
        page++;
        if (event.isRefresh == true || event.isSecond == true) {
          yield FetchedSongMong();
        }
        yield InitailizedSongMong();
      } catch (e) {
        yield ErrorFetchingSongMong(error: e.toString());
      }
    }
    if (event is FetchSongMonStarted) {
      yield FetchingSongMong();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<OTCompesationModel> _song =
            await _otCompesationRepository.getSongMong(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        songlist.addAll(_song);
        page++;
        if (_song.length < rowperpage) {
          yield EndOfSonMong();
        } else {
          yield FetchedSongMong();
        }
      } catch (e) {
        yield ErrorFetchingSongMong(error: e.toString());
      }
    }
    if (event is AddSongMongStarted) {
      yield AddingSongMong();
      try {
        await _otCompesationRepository.addSonMong(
            fromDate: event.fromDate,
            createDate: event.createdDate,
            date: event.date,
            toDate: event.toDate);
        yield AddedSongMong();
        yield FetchingSongMong();
        page = 1;
        songlist.clear();
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getSongMong(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        songlist.addAll(overtime);
        page++;
        yield FetchedSongMong();
      } catch (e) {
        yield ErrorAddingSongMong(error: e.toString());
      }
    }
    if (event is UpdateSongMongStarted) {
      yield AddingSongMong();
      try {
        await _otCompesationRepository.editSonMong(
            id: event.id,
            fromDate: event.fromDate,
            createDate: event.createdDate,
            date: event.date,
            toDate: event.toDate);
        yield AddedSongMong();
        yield FetchingSongMong();
        page = 1;
        songlist.clear();
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getSongMong(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        songlist.addAll(overtime);
        page++;
        yield FetchedSongMong();
      } catch (e) {
        yield ErrorAddingSongMong(error: e.toString());
      }
    }
    if (event is DeleteSongMongStarted) {
      yield AddingSongMong();
      try {
        await _otCompesationRepository.deleteSongMong(
          id: event.id,
        );
        yield AddedSongMong();
        yield FetchingSongMong();
        page = 1;
        songlist.clear();
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getSongMong(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        songlist.addAll(overtime);
        page++;
        yield FetchedSongMong();
      } catch (e) {
        yield ErrorAddingSongMong(error: e.toString());
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
