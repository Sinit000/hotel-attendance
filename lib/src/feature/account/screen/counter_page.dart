import 'package:e_learning/src/feature/account/bloc/index.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
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
        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: BlocBuilder(
            bloc: _accountBloc,
            builder: (context, state) {
              if (state is FetchedCounter) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          children: [
                            _buildItem(
                                title: "Total Ot",
                                text: "${_accountBloc.mycounter!.otDuration}"),
                            _buildItem(
                                title: "Total PH",
                                text: "${_accountBloc.mycounter!.totalPh}"),
                            _buildItem(
                                title: "Hospitality Leave",
                                text:
                                    "${_accountBloc.mycounter!.hospitalLeave}"),
                            _buildItem(
                                title: "Marriage Leave",
                                text:
                                    "${_accountBloc.mycounter!.marriageLeave}"),
                            _buildItem(
                                title: "Feneral Leave",
                                text:
                                    "${_accountBloc.mycounter!.funeralLeave}"),
                            _buildItem(
                                title: "Maternity Leave",
                                text:
                                    "${_accountBloc.mycounter!.meternityLeave}"),
                            _buildItem(
                                title: "Peternity Leave",
                                text:
                                    "${_accountBloc.mycounter!.peternityLeave}")
                            // Container(
                            //   alignment: Alignment.center,
                            //   margin: EdgeInsets.all(30.0),
                            //   decoration: BoxDecoration(
                            //       color: Colors.green,
                            //       borderRadius: BorderRadius.circular(20)),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: <Widget>[
                            //       Text("Data"),
                            //       SizedBox(
                            //         height: 10.0,
                            //       ),
                            //       Text("Sinit")
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
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
  }

  _buildItem({required String title, required String text}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text("$text")
        ],
      ),
    );
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
