import 'package:e_learning/src/feature/auth/bloc/index.dart';
import 'package:e_learning/src/feature/login_register/bloc/register/index.dart';
import 'package:e_learning/src/shared/widget/loadin_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../../appLocalizations.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController? _phoneNumberController = TextEditingController();
  late TextEditingController? _passwordController = TextEditingController();
  late TextEditingController? _nameController = TextEditingController();
  late TextEditingController? _emailCtrl = TextEditingController();
  //     TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, dynamic state) {
        if (state is Registering) {
          loadingDialogs(context);
        } else if (state is Registered) {
        
          Navigator.of(context).pop();
         
        }
      },
      child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: AppLocalizations.of(context)!.translate("name")),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate("nameRequired");
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: AppLocalizations.of(context)!.translate("phone")),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate("phoneNumberRequired");
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: "Email Address"),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate("phoneNumberRequired");
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _passwordController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText:
                      AppLocalizations.of(context)!.translate("password")),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate("passRequired");
                } else if (value.length < 8) {
                  return AppLocalizations.of(context)!
                      .translate("passwordLength");
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: AppLocalizations.of(context)!
                      .translate("confirmPassword")),
              validator: (value) {
              
                return null;
              },
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              height: 50,
              width: double.infinity,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    // side: BorderSide(color: Colors.red)
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    if (_formKey!.currentState!.validate()) {
                      BlocProvider.of<RegisterBloc>(context).add(
                          RegisterPressed(
                              email: _emailCtrl!.text,
                              name: _nameController!.text,
                              phoneNumber: _phoneNumberController!.text,
                              password: _passwordController!.text));
                    }
                  },
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "${AppLocalizations.of(context)!.translate("register")}",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Colors.white),
                  )),
            )
            // pressButton(
            //     context: context,
            //     title: "${AppLocalizations.of(context)!.translate("register")}",
            //     onTap: () {
            //       if (_formKey!.currentState!.validate()) {
            //         BlocProvider.of<RegisterBloc>(context).add(RegisterPressed(
            //             name: _nameController!.text,
            //             phoneNumber: _phoneNumberController!.text,
            //             password: _passwordController!.text));
            //       }
            //        else {
            //         errorSnackBar(
            //             text: "Please input all fields", context: context);
            //       }
            //     })
            // Container(
            //   width: double.infinity,
            //   child: FlatButton(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(5),
            //         // side: BorderSide(color: Colors.red)
            //       ),
            //       color: Colors.blue,
            //       onPressed: () {
            //         if (_formKey.currentState.validate()) {
            //           BlocProvider.of<RegisterBloc>(context).add(
            //               RegisterPressed(
            //                   name: _nameController.text,
            //                   phoneNumber: _phoneNumberController.text,
            //                   password: _passwordController.text));
            //         }
            //       },
            //       padding: EdgeInsets.symmetric(vertical: 10),
            //       child: Text(
            //         AppLocalizations.of(context).translate("register"),
            //         textScaleFactor: 1.2,
            //         style: TextStyle(
            //           color: Colors.white,
            //         ),
            //       )),
            // ),
          ])),
    );
  }
}
