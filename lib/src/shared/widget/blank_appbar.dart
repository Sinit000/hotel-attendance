import 'package:flutter/material.dart';

AppBar blankAppBar(context) {
  return AppBar(
    brightness: Brightness.light,
    elevation: 0,
    backgroundColor: Theme.of(context).primaryColor,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}
