import 'package:e_learning/src/feature/auth/bloc/index.dart';
import 'package:e_learning/src/feature/login_register/bloc/login/index.dart';
import 'package:e_learning/src/feature/login_register/bloc/register/index.dart';
import 'package:e_learning/src/feature/login_register/screens/login_page.dart';

import 'package:e_learning/src/feature/login_register/screens/widgets/login_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../appLocalizations.dart';

class LoginRegisterPage extends StatefulWidget {
  final bool isLogin;
  LoginRegisterPage({this.isLogin = true});
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  bool? isLogin;
  @override
  void initState() {
    if (isLogin == null) {
      isLogin = widget.isLogin;
    } else {
      isLogin = widget.isLogin;
    }
    print(isLogin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage();
    
  }
}
