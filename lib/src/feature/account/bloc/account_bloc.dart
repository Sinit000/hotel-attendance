import 'dart:developer';

import 'package:e_learning/src/feature/account/bloc/index.dart';
import 'package:e_learning/src/feature/account/model/account_model.dart';
import 'package:e_learning/src/feature/account/model/counter_model.dart';
import 'package:e_learning/src/feature/account/repository/account_repository.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountRepository _accountRepository = AccountRepository();
  AccountModel? accountModel;
  AccountModel? check;
  CounterModel? mycounter;
  // CheckInOutRepository checkInOutRepository = CheckInOutRepository();

  @override
  AccountBloc() : super(FethchingAccount());
  String today = "";

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is FetchAccountStarted) {
      yield FethchingAccount();
      try {
        // Future.delayed(Duration(microseconds: 200));
        accountModel = await _accountRepository.getAccount();

        yield FethedAccount();
      } catch (e) {
        print(e.toString());
        yield ErrorFethchingAccount(error: e.toString());
      }
    }
    // if(event is FetchEmployeeDetailStarted){
    //   yield FethchingAccount();
    //   try {
    //     accountModel = await _accountRepository.
    //   } catch (e) {
    //     print(e.toString());
    //     yield ErrorFethchingAccount(error: e.toString());
    //   }
    // }
    if (event is FetchCounterStarted) {
      yield FetchingCounter();
      try {
        // Future.delayed(Duration(microseconds: 200));
        mycounter = await _accountRepository.getCounter();

        yield FetchedCounter();
      } catch (e) {
        print(e.toString());
        yield ErrorFethchingAccount(error: e.toString());
      }
    }
    if (event is FetchCheckAccountStarted) {
      yield FetchingCheckAccount();
      try {
        // Future.delayed(Duration(microseconds: 200));
        check = await _accountRepository.check(todayDate: event.todayDate);

        yield FetchedCheckAccount();
      } catch (e) {
        print(e.toString());
        yield ErrorFethchingAccount(error: e.toString());
      }
    }
    if (event is AddCheckinStarted) {
      yield AddingCheckin();
      try {
        today = event.createdDate.substring(0, 10);
        print(event.lat);
        print(event.lon);
        print(event.checkinTime);
        print(event.createdDate);
        print(event.date);
        await _accountRepository.checkin(
            date: event.date,
            createDate: event.createdDate,
            checkinTime: event.checkinTime,
            lat: event.lat,
            lon: event.lon,
            qrId: event.qrId
            // locationId: event.locationId,
            // date: event.date,
            // timetableId: event.timetableId
            );
        yield AddedCheckin();
        yield FetchingCheckAccount();

        check = await _accountRepository.check(todayDate: today);

        yield FetchedCheckAccount();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingCheckInOut(error: e.toString());
      }
    }
    if (event is AddCheckoutStarted) {
      yield AddingCheckout();
      try {
        today = event.createdDate.substring(0, 10);
        await _accountRepository.checkout(
            date: event.date,
            id: event.id,
            checkoutTime: event.checkoutTime,
            lat: event.lat,
            lon: event.lon,
            qrId: event.qrId
            // locationId: event.locationId,
            // date: event.date,
            // timetableId: event.timetableId
            );
        yield AddedCheckin();
        yield FetchingCheckAccount();
        check = await _accountRepository.check(todayDate: today);
        yield FetchedCheckAccount();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingCheckInOut(error: e.toString());
      }
    }

    if (event is UpdateAccountStated) {
      yield UpdatingAccount();
      String? _image;
      try {
        if (event.img == null) {
          _image = event.imgUrl;
        } else {
          print(event.img);
          _image = await uploadImage(image: event.img!);
        }

        print(_image);
        await _accountRepository.updateAccount(imageUrl: _image);

        // await _accountRepository.updateAccount(
        //     name: event.name,
        //     phone: event.phone,
        //     email: event.email,
        //     city: event.city,
        //     company: event.company,
        //     address: event.address,
        //     skills: event.skill,
        //     educations: event.education,
        //     experiences: event.experience,
        //     imageUrl: image);
        //event.user.image = imageUrl;
        //await _accountRepository.updateAccount(event.user);
        yield UpdatedAccount();
        yield FethchingAccount();
        accountModel = await _accountRepository.getAccount();
        yield FethedAccount();
      } catch (e) {
        log(e.toString());
        yield ErrorUpdatingAccount(error: e.toString());
      }
    }
    //   if (event is UpgradeAccountStarted) {
    //     yield UpgradingAccount();
    //     try {
    //       final String image = await uploadImage(image: event.imageUrl);
    //       print(image);

    //       await _accountRepository.upgradeAccount(
    //           subscriptionId: event.subscriptionId,
    //           paymentMethod: event.paymentMethod,
    //           imageUrl: image);

    //       yield UpgradedAccount();
    //       yield FethchingAccount();
    //       accountModel = await _accountRepository.getAccount();
    //       yield FethedAccount();
    //     } catch (e) {
    //       print(e.toString());
    //       yield ErrorUpdatingAccount(error: e.toString());
    //     }
    //   }
  }
}
