import 'package:e_learning/src/feature/permission/bloc/index.dart';
import 'package:e_learning/src/feature/subtype/bloc/index.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../appLocalizations.dart';

class Subleavetype extends StatefulWidget {
  final String id;
  const Subleavetype({required this.id});

  @override
  State<Subleavetype> createState() => _SubleavetypeState();
}

class _SubleavetypeState extends State<Subleavetype> {
  SubtypeBloc _leaveBloc = SubtypeBloc();
  @override
  void initState() {
    _leaveBloc.add(FetchSubtypeStarted(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("sub_leavetype")!}"),
      body: BlocBuilder(
          bloc: _leaveBloc,
          builder: (context, state) {
            if (state is FetchedSubtype) {
              return ListView.builder(
                  itemCount: _leaveBloc.subtype.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.withOpacity(0.2)
                              // width: 5,
                              ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(children: [
                            Row(
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.translate("type_one")!} : ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "${_leaveBloc.subtype[index].leaveType} ",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.translate("duration")!} : ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "${_leaveBloc.subtype[index].duration} ",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       "${AppLocalizations.of(context)!.translate("deduction")!} : ",
                            //       style: TextStyle(color: Colors.black),
                            //     ),
                            //     Text(
                            //       "${_leaveBloc.subtype[index].} ",
                            //       style: TextStyle(color: Colors.black),
                            //     ),
                            //   ],
                            // ),
                          ]),
                        ),
                      ),
                    );
                  });
            }
            if (state is ErrorFetchingSubtype) {
              return Center(
                child: TextButton(
                    onPressed: () {
                      _leaveBloc.add(FetchSubtypeStarted(id: widget.id));
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    child: Text(
                        "${AppLocalizations.of(context)!.translate("retry")!}")),
              );
            }
            return Center(
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          }),
    );
  }
}
