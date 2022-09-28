import 'package:e_learning/src/feature/auth/bloc/index.dart';
import 'package:e_learning/src/feature/change_password/bloc/index.dart';
import 'package:e_learning/src/shared/widget/blank_appbar.dart';
import 'package:e_learning/src/shared/widget/error_snackbar.dart';
import 'package:e_learning/src/shared/widget/loadin_dialog.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../appLocalizations.dart';
import 'widgets/change_password_form.dart';

class ChangeChangePasswordPage extends StatefulWidget {
  @override
  _ChangeChangePasswordPageState createState() =>
      _ChangeChangePasswordPageState();
}

class _ChangeChangePasswordPageState extends State<ChangeChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChangePasswordBloc(),
      child: Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.2),
          appBar: standardAppBar(context,
              "${AppLocalizations.of(context)!.translate("changepassword")}"),
          body: Body()),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, ChangePasswordState state) {
        if (state is Changing) {
          EasyLoading.show(status: 'loading...');
        }
        if (state is ChangeFailed) {
          EasyLoading.dismiss();
          errorSnackBar(text: state.error.toString(), context: context);
        }
        if (state is Changed) {
          EasyLoading.dismiss();
          void _popupDialog(BuildContext context) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                        "${AppLocalizations.of(context)!.translate("success")}"),
                    content: Text(
                        "${AppLocalizations.of(context)!.translate("passwordChange")}"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(LogoutPressed());
                            Navigator.of(context).pop();
                            // Navigator.of(context).pop();
                            Navigator.of(context).pop(false);
                          },
                          child: Text(
                            "${AppLocalizations.of(context)!.translate("ok")}",
                            style: TextStyle(color: Colors.blue),
                          )),
                    ],
                  );
                });
          }

          Navigator.of(context).pop();
          String _token = state.accessToken;
          // BlocProvider.of<AuthenticationBloc>(context)
          //     .add(AuthenticationStarted(token: _token));
          _popupDialog(context);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [ChangeChangePasswordForm()],
        ),
      ),
    );
  }
}
