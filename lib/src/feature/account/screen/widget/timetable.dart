
import 'package:e_learning/src/feature/timetable/model/timetable_model.dart';
import 'package:flutter/widgets.dart';

Widget time(BuildContext context, {required TimetableModel time}) {
  return Container(
    child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text("from :"),
              Text(" ${time.onDutyTtime}"),
              Text(" to :"),
              Text("${time.offDutyTime}"),
            ],
          );
        }),
  );
}
