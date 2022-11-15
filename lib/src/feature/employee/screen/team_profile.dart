import 'package:e_learning/src/feature/account/screen/user_info_detail.dart';
import 'package:e_learning/src/feature/employee/bloc/employee_bloc.dart';
import 'package:e_learning/src/feature/employee/bloc/index.dart';
import 'package:e_learning/src/feature/employee/screen/team_profile_detail.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../appLocalizations.dart';

class TeamProfile extends StatefulWidget {
  const TeamProfile({Key? key}) : super(key: key);

  @override
  State<TeamProfile> createState() => _TeamProfileState();
}

class _TeamProfileState extends State<TeamProfile> {
  EmployeeBloc _employeeBloc = EmployeeBloc();
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    _employeeBloc.add(InitializeEmployeeStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        appBar: standardAppBar(context,
            "${AppLocalizations.of(context)!.translate("team_profile")!}"),
        body: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: BlocConsumer(
              bloc: _employeeBloc,
              builder: (context, state) {
                if (state is InitializingEmployee) {
                  return Center(
                    // child: CircularProgressIndicator(),
                    child: Lottie.asset('assets/animation/loader.json',
                        width: 200, height: 200),
                  );
                }
                if (state is ErrorFetchingEmployee) {
                  return Center(
                    child: TextButton(
                        onPressed: () {
                          _employeeBloc.add(InitializeEmployeeStarted());
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
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onLoading: () {
                    _employeeBloc.add(FetchEmloyeeStarted());
                  },
                  onRefresh: () {
                    _employeeBloc.add(RefreshEmployeeStarted());
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          cacheExtent: 0,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          // padding: EdgeInsets.only(left: 10, top: 10, right: 0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 6.5 / 6,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: _employeeBloc.emploList.length,
                          itemBuilder: (context, index) {
                            return _attendanceTile(
                                id: _employeeBloc.emploList[index].id!,
                                name: _employeeBloc.emploList[index].name!,
                                img: _employeeBloc.emploList[index].img,
                                position:
                                    "${AppLocalizations.of(context)!.translate("view")!}");
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              listener: (context, state) {
                if (state is FetchedEmployee) {
                  _refreshController.loadComplete();
                  _refreshController.refreshCompleted();
                }
                if (state is EndofEmployeeList) {
                  _refreshController.loadNoData();
                }
              }),
        ));
  }

  _attendanceTile({
    required String name,
    required String position,
    required String id,
    required String? img,
  }) {
    return AspectRatio(
      aspectRatio: 4 / 4.5,
      child: Card(
        // color: Colors.greenAccent.withOpacity(0.5),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  // child: Image.asset(
                  //     "assets/icon/avartar.png"),
                  child: img != null
                      ? Container(
                          color: Colors.grey[350],
                          child: ExtendedImage.network(
                            "https://banban-hr.com/hotel/public/$img",
                            // err: Container(
                            //   child: Image.asset("assets/img/store/shop-hint.jpg"),
                            // ),
                            cacheWidth: 1000,
                            // cacheHeight: 400,
                            enableMemoryCache: true,
                            clearMemoryCacheWhenDispose: true,
                            clearMemoryCacheIfFailed: false,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        )
                      : Image.asset("assets/icon/avartar.png"),
                ),
              ),

              // Container(
              //   padding: EdgeInsets.only(top: 5),
              //   child: Text("Admin Rock"),
              // ),
              Container(
                padding: EdgeInsets.only(top: 5, left: 10, right: 5),
                child: Center(
                  child: Text(name),
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
                child: ElevatedButton(
                    child: Text(position, style: TextStyle()),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    side: BorderSide(color: Colors.green)))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileTeamDetail(
                                    name: name,
                                    id: id,
                                  )));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
