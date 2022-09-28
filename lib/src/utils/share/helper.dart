import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

import 'package:e_learning/src/feature/auth/bloc/index.dart';
import 'package:e_learning/src/utils/share/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Helper {
  static String convertToKhmerPhoneNumber({required String number}) {
    return number;
  }

  static List<String> convertStringtoListString({required String data}) {
    return json.decode(data);
  }

  static String convertListStringtoString({required List<String> data}) {
    String result = '"["';
    result += data.join('","');
    result += '"]"';
    return result;
  }

  static void imgFromGallery(onPicked(File image)) async {
    final picker = ImagePicker();
    PickedFile? imageP =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    final File image = File(imageP!.path);
    onPicked(image);
  }

  static void imgFromCamera(onPicked(File image)) async {
    final picker = ImagePicker();
    PickedFile? imageP =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    final File image = File(imageP!.path);
    onPicked(image);
  }
   String intToStringWithPrefixZero(int value) {
    if (value.toString().length == 1) {
      return "0" + value.toString();
    }
    return value.toString();
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }
   static handleState(
      {required ErrorState state, required BuildContext context}) {
    print(state.error.runtimeType);
    log(state.error.toString());
    if (state.error.toString() == "401") {
      print("d");
      BlocProvider.of<AuthenticationBloc>(context).add(LogoutPressed());
    } else {
      print("d2");
      return;
    }
  }

}
