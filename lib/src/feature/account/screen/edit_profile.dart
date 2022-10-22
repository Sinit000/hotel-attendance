import 'dart:io';

import 'package:e_learning/src/feature/account/bloc/account_event.dart';
import 'package:e_learning/src/feature/account/bloc/account_state.dart';
import 'package:e_learning/src/feature/account/bloc/index.dart';
import 'package:e_learning/src/feature/account/model/account_model.dart';
import 'package:e_learning/src/feature/account/screen/account_page_one.dart';
import 'package:e_learning/src/feature/checkin/screen/attendance.dart';
import 'package:e_learning/src/shared/widget/error_snackbar.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:e_learning/src/utils/share/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../appLocalizations.dart';

class EditProfile extends StatefulWidget {
  final AccountModel accountModel;
  const EditProfile({required this.accountModel});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, ""),
      body: BlocListener(
        bloc: accountBloc,
        listener: (context, state) {
          if (state is UpdatingAccount) {
            EasyLoading.show(status: "loading...");
            // loadingDialogs(context);
          }
          if (state is ErrorUpdatingAccount) {
            EasyLoading.dismiss();
            errorSnackBar(text: state.error.toString(), context: context);
          }
          if (state is UpdatedAccount) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Sucess");
            // EasyLoading.dismiss();
            Navigator.pop(context);
            Navigator.pop(context);

            print("success");
          }
        },
        child: Container(
          child: ListView(
            children: [
              GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: Container(
                      width: (MediaQuery.of(context).size.width / 10) * 8,
                      child: (_image == null)
                          ? widget.accountModel.img == null
                              ? Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 10) *
                                          4,
                                  height:
                                      (MediaQuery.of(context).size.width / 10) *
                                          4,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.grey[600],
                                      size: (MediaQuery.of(context).size.width /
                                              10) *
                                          3,
                                    ),
                                  ),
                                )
                              : FadeInImage.assetNetwork(
                                  placeholder:
                                      "assets/icon/Logo_BanBanHotel.png",

                                  // imageCacheHeight: 350,
                                  // imageCacheWidth: 350,
                                  image: "https://banban-hr.com/hotel/public/${widget.accountModel.img}",
                                  fit: BoxFit.fill,
                                  imageErrorBuilder:
                                      (context, error, StackTrace) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 20),
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  10) *
                                              4,
                                      height:
                                          (MediaQuery.of(context).size.width /
                                                  10) *
                                              4,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Colors.grey[600],
                                          size: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10) *
                                              3,
                                        ),
                                      ),
                                    );
                                  },
                                )
                          : Container(
                              // height: MediaQuery.of(context).size.width / 3,
                              width:
                                  (MediaQuery.of(context).size.width / 10) * 7,
                              child: Image.file(_image!)))),
              SizedBox(height: 60),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                width: double.infinity,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.lightBlue)),
                    color: Colors.lightBlue,
                    onPressed: () {
                      String url = "";
                      if (widget.accountModel.img == null) {
                        url = "";
                      } else {
                        url = widget.accountModel.img!;
                      }
                      accountBloc
                          .add(UpdateAccountStated(img: _image, imgUrl: url));
                    },
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("submit")!} ",
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        // _imgFromGallery();
                        Helper.imgFromGallery((image) {
                          setState(() {
                            _image = image;
                          });
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Helper.imgFromCamera((image) {
                        setState(() {
                          _image = image;
                        });
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
