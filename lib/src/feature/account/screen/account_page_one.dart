import 'package:e_learning/src/feature/account/bloc/index.dart';
import 'package:e_learning/src/feature/account/screen/counter_page.dart';
import 'package:e_learning/src/feature/account/screen/user_info_detail.dart';
import 'package:e_learning/src/feature/auth/bloc/index.dart';
import 'package:e_learning/src/feature/changeDayof/bloc/index.dart';
import 'package:e_learning/src/feature/change_password/screen/change_password_page.dart';
import 'package:e_learning/src/feature/checkin/screen/attendance.dart';
import 'package:e_learning/src/feature/holiday/screen/holiday_page.dart';
import 'package:e_learning/src/feature/language/sreen/language.dart';

import 'package:e_learning/src/shared/widget/blank_appbar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../appLocalizations.dart';

AccountBloc accountBloc = AccountBloc();

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        appBar: blankAppBar(context),
        body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // var qr = "http://banban-hr.herokuapp.com/6";
    // var result = qr.substring(0, 30);
    // print(result);
    accountBloc.add(FetchAccountStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
    return Container(
      child: BlocBuilder(
          bloc: accountBloc,
          builder: (context, state) {
            print(state);
            if (state is FethedAccount) {
              return ListView(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: EdgeInsets.only(top: 10, left: 30),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.blue,
                            ],
                            // colors: [HexColor("#83eaf1"), HexColor("#63a4ff")],
                            // colors: [Colors.blue, Colors.lightBlue],
                            // colors: [orangeColors, orangeLightColors],
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter),
                        // borderRadius:
                        //     BorderRadius.only(bottomLeft: Radius.circular(100))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(
                          //   child: IconButton(onPressed: (){

                          //   }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
                          // ),
                          accountBloc.accountModel!.img != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    color: Colors.grey[350],
                                    child: ExtendedImage.network(
                                      "https://banban-hr.com/hotel/public/${accountBloc.accountModel!.img}",
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
                                  ),
                                )
                              : Container(
                                  height: 80,
                                  width: 80,
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        "assets/icon/Logo_BanBanHotel.png",

                                    // imageCacheHeight: 350,
                                    // imageCacheWidth: 350,
                                    image:
                                        "https://banban-hr.com/hotel/public/${accountBloc.accountModel!.img}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Text(
                                  "${accountBloc.accountModel!.name}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textScaleFactor: 1.4,
                                ),
                                Text(
                                    "${accountBloc.accountModel!.positionModel!.positionName}",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      AppLocalizations.of(context)!.translate("general")!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.3,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      // margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            children: [
                              _builContainer(
                                  iconData: Icons.account_circle_outlined,
                                  title: "Personal Info",
                                  iconColor: Colors.green,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (con) => UserInfoDetail(
                                                  accountModel:
                                                      accountBloc.accountModel!,
                                                )));
                                  }),
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Divider(
                                  height: 2.0,
                                  color: Colors.grey[400],
                                ),
                              ),
                              _builContainer(
                                  iconData: Icons.account_circle_outlined,
                                  title: "My Counter",
                                  iconColor: Colors.blue,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (con) => CounterPage()));
                                  }),
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Divider(
                                  height: 2.0,
                                  color: Colors.grey[400],
                                ),
                              ),
                              _builContainer(
                                  iconData: Icons.account_circle_outlined,
                                  title: "Publich Holiday",
                                  iconColor: Colors.pinkAccent,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (con) => HolidayPage()));
                                  }),
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Divider(
                                  height: 2.0,
                                  color: Colors.grey[400],
                                ),
                              ),
                              _builContainer(
                                  iconData: Icons.vpn_key_outlined,
                                  title:
                                      "${AppLocalizations.of(context)!.translate("changepassword")!}",
                                  iconColor: Colors.red,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (con) =>
                                                ChangeChangePasswordPage()));
                                  }),
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Divider(
                                  height: 2.0,
                                  color: Colors.grey[400],
                                ),
                              ),
                              // Container(
                              //     child: ListTile(
                              //   leading: Icon(
                              //     Icons.vpn_key_outlined,
                              //   ),
                              //   title: Text(AppLocalizations.of(context)!
                              //       .translate("changepassword")!),
                              //   trailing: Icon(
                              //     Icons.keyboard_arrow_right,
                              //     size: 30.0,
                              //   ),
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (con) =>
                              //                 ChangeChangePasswordPage()));
                              //   },
                              // )),
                              // Divider(
                              //   height: 1.0,
                              //   color: Colors.grey[400],
                              // ),
                              _builContainer(
                                  iconData: Icons.language_outlined,
                                  title:
                                      "${AppLocalizations.of(context)!.translate("chooseLang")!}",
                                  iconColor: Colors.amber,
                                  onTap: () {
                                    languageModal(context);
                                  }),
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Divider(
                                  height: 2.0,
                                  color: Colors.grey[400],
                                ),
                              ),
                              // Container(
                              //     child: ListTile(
                              //   title: Text(AppLocalizations.of(context)!
                              //       .translate("chooseLang")!),
                              //   leading: Icon(Icons.language_outlined),
                              //   // trailing: Icon(
                              //   //   Icons.keyboard_arrow_right,
                              //   //   size: 30.0,
                              //   // ),
                              //   onTap: () {
                              //     languageModal(context);
                              //   },
                              // )),
                              // Divider(
                              //   height: 1.0,
                              //   color: Colors.grey[400],
                              // ),
                              _builContainer(
                                  iconData: Icons.people_outlined,
                                  title:
                                      "${AppLocalizations.of(context)!.translate("aboutUs")!}",
                                  iconColor: Colors.blue,
                                  onTap: () {
                                    // languageModal(context);
                                  }),
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Divider(
                                  height: 2.0,
                                  color: Colors.grey[400],
                                ),
                              ),

                              // _builContainer(
                              //     iconData: Icons.help_outlined,
                              //     title:
                              //         "${AppLocalizations.of(context)!.translate("help")!}",
                              //     iconColor: Colors.pinkAccent,
                              //     onTap: () {
                              //       // languageModal(context);
                              //     }),
                              // Container(
                              //   margin: EdgeInsets.only(left: 50),
                              //   child: Divider(
                              //     height: 2.0,
                              //     color: Colors.grey[400],
                              //   ),
                              // ),
                              // Container(
                              //     child: ListTile(
                              //   title: Text(AppLocalizations.of(context)!
                              //       .translate("help")!),
                              //   leading: Icon(Icons.question_answer_outlined),
                              //   trailing: Icon(
                              //     Icons.keyboard_arrow_right,
                              //     size: 30.0,
                              //   ),
                              //   onTap: () {},
                              // )),
                              // Divider(
                              //   height: 1.0,
                              //   color: Colors.grey[400],
                              // ),
                              // Container(
                              //     child: ListTile(
                              //   title: Text("Student"),
                              //   leading: Icon(Icons.question_answer_outlined),
                              //   trailing: Icon(
                              //     Icons.keyboard_arrow_right,
                              //     size: 30.0,
                              //   ),
                              //   onTap: () {
                              //     // Navigator.push(
                              //     //     context,
                              //     //     MaterialPageRoute(
                              //     //         builder: (context) =>
                              //     //             MyLocalNotification()));
                              //   },
                              // )),
                              // Divider(
                              //   height: 1.0,
                              //   color: Colors.grey[400],
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
    );
  }

  _builContainer(
      {required String title,
      required Color iconColor,
      required IconData iconData,
      required Function? onTap}) {
    return Container(
        child: ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: iconColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(title),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        size: 30.0,
      ),
      onTap: onTap as void Function()?,
    ));
  }
}
