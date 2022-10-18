import 'package:e_learning/src/config/routes/routes.dart';
import 'package:e_learning/src/feature/auth/bloc/authentication_bloc.dart';
import 'package:e_learning/src/feature/overtime/screen/widget/component_widget.dart';
import 'package:e_learning/src/feature/permission/bloc/index.dart';
import 'package:e_learning/src/feature/permission/screen/leave_type_page.dart';
import 'package:e_learning/src/shared/widget/delay_widget.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../appLocalizations.dart';

LeaveBloc leaveBloc = LeaveBloc();

class LeavePage extends StatelessWidget {
  const LeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(BlocProvider.of<AuthenticationBloc>(context)
    //     .state
    //     .user!
    //     .roleName!
    //     .toLowerCase()
    //     .contains('cheif'));
    // print(BlocProvider.of<AuthenticationBloc>(context).state.user!.roleName!);
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          // "${BlocProvider.of<AuthenticationBloc>(context).state.user!.roleName}",
          "${AppLocalizations.of(context)!.translate("leave")!}",
          style:
              TextStyle(color: Colors.white, fontFamily: 'BattambangRegular'),
          textScaleFactor: 1.1,
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LeavetypePage()));
              },
              child: Icon(Icons.restore)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      // appBar: standardAppBar(
      //     context, "${AppLocalizations.of(context)!.translate("leave")!}"),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: Theme.of(context).primaryColor,
          ),
          ListView(
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              SizedBox(height: 20),
              // delayedWidget(
              //   child: ComponentWidget(
              //     name:
              //         "${AppLocalizations.of(context)!.translate("contract")!}",
              //     onPressed: () {
              //       // Navigator.of(context).pushNamed(contract);
              //     },
              //   ),
              // ),
              SizedBox(height: 20),
              BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user!
                          .roleName!
                          .toLowerCase()
                          .contains('cheif') ||
                      BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user!
                          .roleName!
                          .toLowerCase()
                          .contains('department')
                  ? delayedWidget(
                      child: ComponentWidget(
                        name:
                            "${AppLocalizations.of(context)!.translate("all_leave")!}",
                        onPressed: () {
                          Navigator.of(context).pushNamed(allleave);
                        },
                      ),
                    )
                  : Container(),
              BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user!
                          .roleName!
                          .toLowerCase()
                          .contains('cheif') ||
                      BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user!
                          .roleName!
                          .toLowerCase()
                          .contains('department')
                  ? SizedBox(height: 20)
                  : Container(),
              delayedWidget(
                child: ComponentWidget(
                  name:
                      "${AppLocalizations.of(context)!.translate("my_leave")!}",
                  onPressed: () {
                    Navigator.of(context).pushNamed(myleave);
                  },
                ),
              ),
              BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user!
                          .roleName!
                          .toLowerCase()
                          .contains('cheif') ||
                      BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user!
                          .roleName!
                          .toLowerCase()
                          .contains('department')
                  ? SizedBox(height: 20)
                  : Container(),
              BlocProvider.of<AuthenticationBloc>(context)
                      .state
                      .user!
                      .roleName!
                      .toLowerCase()
                      .contains('security')
                  ? SizedBox(height: 20)
                  : Container(),
              BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user!
                          .roleName!
                          .toLowerCase()
                          .contains('cheif') ||
                      BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user!
                          .roleName!
                          .toLowerCase()
                          .contains('security')
                  ? delayedWidget(
                      child: ComponentWidget(
                        name:
                            "${AppLocalizations.of(context)!.translate("all_leaveout")!}",
                        onPressed: () {
                          if (BlocProvider.of<AuthenticationBloc>(context)
                              .state
                              .user!
                              .roleName!
                              .toLowerCase()
                              .contains('security')) {
                            Navigator.of(context).pushNamed(allLeaveoutS);
                          } else {
                            Navigator.of(context).pushNamed(allLeaveoutC);
                          }
                        },
                      ),
                    )
                  : Container(),

              SizedBox(height: 20),
              delayedWidget(
                child: ComponentWidget(
                  name:
                      "${AppLocalizations.of(context)!.translate("my_leaveout")!}",
                  onPressed: () {
                    Navigator.of(context).pushNamed(myleaveout);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class LeavePage extends StatelessWidget {
//   final String mydate;
//   const LeavePage({this.mydate = "This week"});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             brightness: Brightness.light,
//             elevation: 0,
//             backgroundColor: Theme.of(context).primaryColor,
//             centerTitle: true,
//             title: Text(
//               'Manage Leave',
//               style: TextStyle(color: Colors.white),
//             ),
//             bottom: TabBar(
//               indicatorColor: Colors.grey,
//               indicatorWeight: 2,
//               tabs: [
//                 Tab(
//                   child:
//                       Text("All Leave", style: TextStyle(color: Colors.white)),
//                 ),
//                 Tab(
//                   child:
//                       Text("My Leave", style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//             titleSpacing: 20,
//           ),
//           body: TabBarView(
//             children: [AllLeave(), MyLeave()],
//           ),
//         ));
//   }
// }
