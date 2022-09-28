import 'package:e_learning/src/feature/account/bloc/index.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  AccountBloc _accountBloc = AccountBloc();
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    _accountBloc.add(FetchCounterStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context, "Counter page"),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        child: BlocBuilder(
            bloc: _accountBloc,
            builder: (context, state) {
              if (state is FetchedCounter) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _itemTile(
                              name: "Total Ot",
                              number: "${_accountBloc.mycounter!.otDuration}"),
                          _itemTile(
                              name: "Total PH",
                              number: "${_accountBloc.mycounter!.totalPh}"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _itemTile(
                              name: "Hospitality Leave",
                              number:
                                  "${_accountBloc.mycounter!.hospitalLeave}"),
                          _itemTile(
                              name: "Marriage Leave",
                              number:
                                  "${_accountBloc.mycounter!.marriageLeave}"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _itemTile(
                              name: "Feneral Leave",
                              number:
                                  "${_accountBloc.mycounter!.funeralLeave}"),
                          _itemTile(
                              name: "Maternity Leave",
                              number:
                                  "${_accountBloc.mycounter!.meternityLeave}"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _itemTile(
                              name: "Peternity Leave",
                              number:
                                  "${_accountBloc.mycounter!.peternityLeave}"),
                        ],
                      ),
                    ],
                  ),
                );
              }
              if (state is ErrorFethchingAccount) {
                return Center(
                  child: Text(state.error.toString()),
                );
              }
              return Center(
                // child: CircularProgressIndicator(),
                child: Lottie.asset('assets/animation/loader.json',
                    width: 200, height: 200),
              );
            }),
      ),
    );
    // BlocProvider.of<AccountBloc>(context).add(FetchCounterStarted());
    return Scaffold(
        appBar: standardAppBar(context, "Counter page"),
        body: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: BlocConsumer(
              bloc: BlocProvider.of<AccountBloc>(context),
              builder: (context, state) {
                if (state is ErrorFethchingAccount) {
                  return Center(
                    child: Text(state.error.toString()),
                  );
                }
                if (state is FetchedCounter) {
                  return SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    onLoading: () {
                      // _employeeBloc.add(FetchEmloyeeStarted());
                    },
                    onRefresh: () {
                      // _employeeBloc.add(RefreshEmployeeStarted());
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              _itemTile(
                                  name: "Total Ot",
                                  number:
                                      "${BlocProvider.of<AccountBloc>(context).mycounter!.otDuration}"),
                              _itemTile(
                                  name: "Total PH",
                                  number:
                                      "${BlocProvider.of<AccountBloc>(context).mycounter!.totalPh}"),
                            ],
                          ),
                          // _itemTile(
                          //     name: "Hospitality Leave",
                          //     number:
                          //         "${BlocProvider.of<AccountBloc>(context).mycounter!.hospitalLeave}"),
                          // _itemTile(
                          //     name: "Marriage Leave",
                          //     number:
                          //         "${BlocProvider.of<AccountBloc>(context).mycounter!.marriageLeave}"),
                          // _itemTile(
                          //     name: "Feneral Leave",
                          //     number:
                          //         "${BlocProvider.of<AccountBloc>(context).mycounter!.funeralLeave}"),
                          // _itemTile(
                          //     name: "Maternity Leave",
                          //     number:
                          //         "${BlocProvider.of<AccountBloc>(context).mycounter!.meternityLeave}"),
                          // _itemTile(
                          //     name: "Peternity Leave",
                          //     number:
                          //         "${BlocProvider.of<AccountBloc>(context).mycounter!.peternityLeave}"),
                        ],
                      ),
                    ),
                  );
                }
                return Center(
                  // child: CircularProgressIndicator(),
                  child: Lottie.asset('assets/animation/loader.json',
                      width: 200, height: 200),
                );
              },
              listener: (context, state) {
                // if (state is FetchedEmployee) {
                //   _refreshController.loadComplete();
                //   _refreshController.refreshCompleted();
                // }
                // if (state is EndofEmployeeList) {
                //   _refreshController.loadNoData();
                // }
              }),
        ));
  }

  _itemTile({
    required String name,
    required String number,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      alignment: Alignment.center,
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     // color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 0,
        //     blurRadius: 3,
        //     offset: Offset(0, 0), // changes position of shadow
        //   ),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   width: 80,
          //   height: 80,
          //   // child: ClipRRect(
          //   //   borderRadius: BorderRadius.circular(50),
          //   //   // child: Image.asset(
          //   //   //     "assets/icon/avartar.png"),
          //   //   child: Image.asset("assets/icon/avartar.png"),
          //   // ),
          // ),

          // Container(
          //   padding: EdgeInsets.only(top: 5),
          //   child: Text("Admin Rock"),
          // ),
          Container(
            padding: EdgeInsets.only(top: 5, left: 10, right: 5),
            child: Center(
              child: Text(
                name,
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          //  position == "Checkout"
          //       ? Container(
          //           child: ElevatedButton(
          //               child: Text(widget.title, style: TextStyle()),
          //               style: ButtonStyle(
          //                   foregroundColor: MaterialStateProperty.all<Color>(
          //                       Colors.white),
          //                   backgroundColor: MaterialStateProperty.all<Color>(
          //                       Colors.amber),
          //                   shape: MaterialStateProperty.all<
          //                           RoundedRectangleBorder>(
          //                       RoundedRectangleBorder(
          //                           borderRadius: BorderRadius.circular(18),
          //                           side: BorderSide(color: Colors.amber)))),
          //               onPressed: () {}),
          //         )
          //       :
          Container(
            padding: EdgeInsets.only(top: 5, left: 10, right: 5),
            child: Center(
              child: Text(number),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _accountBloc.close();
    super.dispose();
  }
}
