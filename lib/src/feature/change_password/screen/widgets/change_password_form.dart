import 'package:e_learning/src/feature/change_password/bloc/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../appLocalizations.dart';

class ChangeChangePasswordForm extends StatefulWidget {
  @override
  _ChangeChangePasswordFormState createState() =>
      _ChangeChangePasswordFormState();
}

class _ChangeChangePasswordFormState extends State<ChangeChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _currentChangePasswordController = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _newChangePasswordController = TextEditingController();
  final _comfirmNewChangePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 80, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Center(
            //   child: Text(
            //     "${AppLocalizations.of(context)!.translate("changepassword")}",
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontWeight: FontWeight.bold,
            //       letterSpacing: 0,
            //     ),
            //     textScaleFactor: 1.4,
            //     // textAlign: TextAlign.center,
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // TextFormField(
            //   controller: _usernameCtrl,
            //   keyboardType: TextInputType.text,
            //   decoration: InputDecoration(
            //       contentPadding: EdgeInsets.all(15),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(5.0),
            //         ),
            //         borderSide: new BorderSide(
            //           width: 1,
            //         ),
            //       ),
            //       isDense: true,
            //       labelText: "User name"),
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return 'username is required';
            //     }
            //     return null;
            //   },
            // ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _currentChangePasswordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey.shade400)),
                  enabledBorder: InputBorder.none,
                  // isDense: true,
                  contentPadding: const EdgeInsets.only(
                    left: 14.0,
                  ),
                  labelText:
                      "${AppLocalizations.of(context)!.translate("oldpassword")}"),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'old password is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _newChangePasswordController,
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey.shade400)),
                enabledBorder: InputBorder.none,
                // isDense: true,
                contentPadding: const EdgeInsets.only(
                  left: 14.0,
                ),
                labelText:
                    "${AppLocalizations.of(context)!.translate("newpassword")}",
                // filled: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "New password is required";
                } else {
                  if (value.length < 5) {
                    return "At least 5 charaters";
                  }
                  return null;
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey.shade400)),
                  enabledBorder: InputBorder.none,
                  // isDense: true,
                  contentPadding: const EdgeInsets.only(
                    left: 14.0,
                  ),
                  labelText:
                      "${AppLocalizations.of(context)!.translate("confirmnewPassword")}",
                  //  filled: true,
                ),
                obscureText: true,
                controller: _comfirmNewChangePasswordController,
                validator: (value) {
                  if (value!.isNotEmpty &&
                      _newChangePasswordController.value.text.isNotEmpty) {
                    if (value != _newChangePasswordController.value.text) {
                      return 'password are not match!';
                    }
                  } else if (value.isEmpty &&
                      _newChangePasswordController.value.text.isNotEmpty) {
                    return 'Confirm password is required';
                  }
                  return null;
                }),
            SizedBox(height: MediaQuery.of(context).size.height / 6),

            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  // color: Theme.of(context).primaryColor,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ChangePasswordBloc>(context)
                          .add(ChangePasswordButtonPressed(
                        oldpass: _currentChangePasswordController.text,
                        newpass: _newChangePasswordController.text,
                      ));
                    }
                  },
                  child: Text(
                    "${AppLocalizations.of(context)!.translate("changepassword")}"
                        .toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      // letterSpacing: 1,
                      // fontWeight: FontWeight.w400,
                    ),
                    textScaleFactor: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
