import 'dart:developer';

import 'package:e_learning/src/feature/permission/model/leave_model.dart';
import 'package:e_learning/src/feature/permission/model/leave_type_model.dart';
import 'package:e_learning/src/feature/subtype/bloc/subtype_event.dart';
import 'package:e_learning/src/feature/subtype/bloc/subtype_state.dart';
import 'package:e_learning/src/feature/subtype/model/subtype_model.dart';
import 'package:e_learning/src/feature/subtype/repository/subtype_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubtypeBloc extends Bloc<SubstypeEvent, SubstypeState> {
  SubtypeBloc() : super(FetchingSubtype());
  SubtypeRepository _subtypeRepository = SubtypeRepository();

  List<LeaveTypeModel> subtype = [];
  @override
  Stream<SubstypeState> mapEventToState(SubstypeEvent event) async* {
    if (event is FetchSubtypeStarted) {
      yield FetchingSubtype();
      try {
        if (subtype.length != 0) {
          subtype.clear();
        }

        // Future.delayed(Duration(milliseconds: 200));
        subtype = await _subtypeRepository.getsubtype(id: event.id);
        print(subtype.length);
        yield FetchedSubtype(length: subtype.length);
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingSubtype(error: e.toString());
      }
    }
  }
}
