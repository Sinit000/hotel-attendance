import 'package:e_learning/src/feature/auth/bloc/authentication_bloc.dart';
import 'package:e_learning/src/feature/notification/bloc/index.dart';

import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../appLocalizations.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationBloc _notificationBloc = NotificationBloc();
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    _notificationBloc.add(InitailizeNotificationStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("notification")!}"),
      body: Container(
        child: BlocConsumer(
            bloc: _notificationBloc,
            builder: (context, state) {
              if (state is InitializingNotification) {
                return Center(
                  // child: CircularProgressIndicator(),
                  child: Lottie.asset('assets/animation/loader.json',
                      width: 200, height: 200),
                );
              }
              if (state is ErrorFetchingNotification) {
                return Center(
                  child: Text(state.error.toString()),
                );
              } else {
                if (_notificationBloc.notificationModel.length == 0) {
                  return Center(
                    child: Text("No Data"),
                  );
                }
                return SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    cacheExtent: 1,
                    onRefresh: () {
                      _notificationBloc.add(RefreshNotificationStarted());
                    },
                    onLoading: () {
                      _notificationBloc.add(FetchNotificationStarted());
                    },
                    child: ListView.builder(
                        itemCount: _notificationBloc.notificationModel.length,
                        itemBuilder: (context, index) {
                          // for(int i=0; i<_notificationBloc.notificationModel.length; i++){
                          //     if(_notificationBloc.notificationModel[i].userId==BlocProvider.of<AuthenticationBloc>(context).state.user!.id){

                          //     }
                          // }
                          print(BlocProvider.of<AuthenticationBloc>(context)
                              .state
                              .user!
                              .id);
                          return InkWell(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (con)=>));
                            },
                            child: Card(
                              child: Container(
                                // margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.date_range,
                                            size: 18.0,
                                            color: Colors.orange[900],
                                          ),
                                          _notificationBloc
                                                      .notificationModel[index]
                                                      .date ==
                                                  null
                                              ? Text("")
                                              : Text(
                                                  " " +
                                                      '${_notificationBloc.notificationModel[index].date}',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          // Icon(
                                          //   Icons.date_range,
                                          //   size: 18.0,
                                          //   color: Colors.orange[900],
                                          // ),
                                          Text(
                                            " " +
                                                _notificationBloc
                                                    .notificationModel[index]
                                                    .title,
                                            style: TextStyle(
                                                color: Colors.orange[900]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }));
              }
            },
            listener: (context, state) {
              print("state");
              print(state);
              if (state is FetchedNotification) {
                _refreshController.loadComplete();
                _refreshController.refreshCompleted();
              }
              if (state is EndOfNotificationList) {
                _refreshController.loadNoData();
              }
            }),
      ),
    );
    return Scaffold(
      appBar: standardAppBar(context, "Notification"),
      body: Container(
        child: BlocBuilder<NotificationBloc, NotificationState>(
            bloc: BlocProvider.of<NotificationBloc>(context),
            builder: (context, state) {
              if (state is FetchedNotification) {
                if (BlocProvider.of<NotificationBloc>(context)
                        .notificationModel
                        .length ==
                    0) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No notification",
                          style: TextStyle(color: Colors.grey[400]))
                    ],
                  ));
                }
                return Container(
                  child: ListView.builder(
                      itemCount: BlocProvider.of<NotificationBloc>(context)
                          .notificationModel
                          .length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (con)=>));
                          },
                          child: Card(
                            child: Container(
                              // margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          size: 18.0,
                                          color: Colors.orange[900],
                                        ),
                                        Text(
                                          " " + '02/28/2022',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        // Icon(
                                        //   Icons.date_range,
                                        //   size: 18.0,
                                        //   color: Colors.orange[900],
                                        // ),
                                        Text(
                                          " " +
                                              BlocProvider.of<NotificationBloc>(
                                                      context)
                                                  .notificationModel[index]
                                                  .title,
                                          style: TextStyle(
                                              color: Colors.orange[900]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
              if (state is ErrorFetchingNotification) {
                return Center(
                    child: Container(child: Text(state.error.toString())));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
