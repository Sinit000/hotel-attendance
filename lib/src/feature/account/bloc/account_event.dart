import 'dart:io';
import 'package:e_learning/src/feature/account/model/account_model.dart';
import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  AccountEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchAccountStarted extends AccountEvent {}

class FetchCounterStarted extends AccountEvent {}

class FetchCheckAccountStarted extends AccountEvent {
  final String todayDate;
  FetchCheckAccountStarted({required this.todayDate});
}



class AddCheckinStarted extends AccountEvent {
  final String checkinTime;
  final String lat;
  final String lon;
  final String createdDate;
  final String date;

  AddCheckinStarted({
    required this.checkinTime,
    required this.lat,
    required this.lon,
    required this.createdDate,
    required this.date,
    // required this.timetableId
  });
}

class AddCheckoutStarted extends AccountEvent {
  final String id;
  final String checkoutTime;
  final String lat;
  final String lon;
  final String createdDate;
  final String date;
  // final String timetableId;
  AddCheckoutStarted({
    required this.id,
    required this.checkoutTime,
    required this.lat,
    required this.lon,
    // required this.locationId,
    required this.date,
    required this.createdDate,
    // required this.timetableId
  });
}

class SetAccount extends AccountEvent {
  final AccountModel user;
  SetAccount({required this.user});
}

class UpdateAccount extends AccountEvent {
  final File? imageFile;
  final AccountModel user;
  UpdateAccount({required this.user, required this.imageFile});
}

class UpdateAccountStated extends AccountEvent {
  final String imgUrl;
  final File? img;
  // final String name;
  // final String phone;
  // final File imageUrl;
  // final String email;
  // final String city;
  // final String company;
  // final String address;
  // final String skill;
  // final String education;
  // final String experience;

  // final String dob;

  UpdateAccountStated({required this.img, required this.imgUrl
      //   required this.name,
      // required this.phone,
      // required this.imageUrl,
      // required this.email,
      // required this.city,
      // required this.company,
      // required this.address,
      // required this.skill,
      // required this.education,
      // required this.experience
      // required this.dob,
      });
}

class UpgradeAccountStarted extends AccountEvent {
  // final String name;
  // final String phone;

  final String subscriptionId;
  final String paymentMethod;
  final File imageUrl;
  UpgradeAccountStarted(
      {
      // required this.name,
      // required this.phone,

      required this.subscriptionId,
      required this.paymentMethod,
      required this.imageUrl});
}
