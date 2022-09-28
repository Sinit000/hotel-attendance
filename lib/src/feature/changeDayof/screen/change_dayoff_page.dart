import 'package:e_learning/src/config/routes/routes.dart';
import 'package:e_learning/src/feature/changeDayof/bloc/index.dart';
import 'package:e_learning/src/feature/changeDayof/model/changeday_off_model.dart';
import 'package:e_learning/src/feature/changeDayof/screen/all_day_off.dart';
import 'package:e_learning/src/feature/changeDayof/screen/edit_change_dayoff.dart';
import 'package:e_learning/src/feature/changeDayof/screen/my_dayoff.dart';
import 'package:e_learning/src/shared/widget/delete_dialog.dart';
import 'package:e_learning/src/shared/widget/error_snackbar.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_picker/PickerLocalizations.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../appLocalizations.dart';
import 'package:intl/intl.dart';

// ChangeDayOffBloc changeDayOffBloc = ChangeDayOffBloc();

class ChangeDayOffPage extends StatelessWidget {
  const ChangeDayOffPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.light,
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: Text(
              "${AppLocalizations.of(context)!.translate("change_dayoff")!}",
              style: TextStyle(color: Colors.white),
            ),
            bottom: TabBar(
              indicatorColor: Colors.grey,
              indicatorWeight: 2,
              tabs: [
                Tab(
                  child:
                      Text("All Dayoff", style: TextStyle(color: Colors.white)),
                ),
                Tab(
                  child:
                      Text("My Dayoff", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            titleSpacing: 20,
          ),
          body: TabBarView(
            children: [AllDayOff(), MyDayOff()],
          ),
        ));
  }
}
