import 'package:e_learning/src/feature/permission/bloc/index.dart';
import 'package:e_learning/src/feature/permission/model/leave_type_model.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';

class LeavetypePage extends StatefulWidget {
  const LeavetypePage({Key? key}) : super(key: key);

  @override
  State<LeavetypePage> createState() => _LeavetypePageState();
}

class _LeavetypePageState extends State<LeavetypePage> {
  LeaveBloc _leaveBloc = LeaveBloc();
  @override
  void initState() {
    _leaveBloc.add(FetchLeaveTypeStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context, "Leavetype"),
      body: BlocBuilder(
          bloc: _leaveBloc,
          builder: (context, state) {
            if (state is FetchingLeaveType) {
              return Center(
                child: Lottie.asset('assets/animation/loader.json',
                    width: 200, height: 200),
              );
            }
            if (state is ErrorFetchingLeaveType) {
              return Center(
                child: Text(state.error.toString()),
              );
            }
            return Stack(
              children: [
                Container(child: _portrait(context, _leaveBloc.leaveList)),
              ],
            );
          }),
    );
  }

  _portrait(BuildContext context, List<LeaveTypeModel> leave) {
    return Stack(
      children: [
        _headBackground(
          context,
          aspectRatio: 10 / 3,
        ),
        OrientationBuilder(builder: (context, orie) {
          return Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            // child: GridView.count(crossAxisCount: 2,children: [

            // ],),
            child: ListView.builder(
                itemCount: leave.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(6.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),

                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    // color: Colors.redAccent,
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              // padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.only(left: 20, top: 15),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(50),

                                // image: DecorationImage(
                                //     fit: BoxFit.cover,
                                //     image: AssetImage(
                                //       "${paylist[index].image}",
                                //     ))
                              ),
                              child: Center(
                                child: Text(
                                  "${leave[index].duration}",
                                  style: TextStyle(color: Colors.white),
                                  textScaleFactor: 1.5,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceAround,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${leave[index].leaveType}",
                                    textScaleFactor: 1.3,
                                    
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  // InkWell(
                                  //       child: Icon(Icons.navigate_next),
                                  //     )

                                  // Padding(
                                  //   padding: EdgeInsets.only(top: 3),
                                  //   child: Text(
                                  //     "10",
                                  //     style: TextStyle(
                                  //         color: Colors.grey[500],
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(top: 3),
                                  //   child: Text(
                                  //     "\$1200",
                                  //     style: TextStyle(color: Colors.redAccent),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  );
                }),
          );
        })
      ],
    );
  }

  _headBackground(BuildContext context, {required double aspectRatio}) {
    return AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).primaryColor,
        ));
  }
}