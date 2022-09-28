import 'dart:developer';
import 'package:e_learning/src/feature/account/model/account_model.dart';
import 'package:e_learning/src/feature/employee/bloc/index.dart';
import 'package:e_learning/src/feature/employee/model/employee_model.dart';
import 'package:e_learning/src/feature/employee/repository/employee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(FetchingEmployee());
  EmployeeRepository _departmentRepository = EmployeeRepository();
  List<AccountModel> emploList = [];
  // List<RoleModel> roleList = [];
  int rowperpage = 12;
  // String? image;
  int page = 1;
  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event) async* {
    // if (event is FetchRoleStarted) {
    //   yield FetchingRole();
    //   try {
    //     if (roleList.length != 0) {
    //       roleList.clear();
    //     }
    //     roleList = await _departmentRepository.getRole();
    //     yield FetchedRole();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErrorFetchingRole(error: e.toString());
    //   }
    // }
    if (event is FetchEmloyeeStarted) {
      yield FetchingEmployee();
      try {
        print(page);
        print(emploList.length);
        List<AccountModel> _departmentList = await _departmentRepository
            .getEmployeeByDepartment(rowPerpage: rowperpage, page: page);

        emploList.addAll(_departmentList);
        page++;
        print(page);
        print(emploList.length);
        // yield FetchedEmployee();
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          print(emploList.length);
          yield EndofEmployeeList();
        } else {
          yield FetchedEmployee();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingEmployee(error: e.toString());
      }
    }
    if (event is InitializeEmployeeStarted) {
      yield InitializingEmployee();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        print(page);
        emploList.clear();
        List<AccountModel> _departmentList = await _departmentRepository
            .getEmployeeByDepartment(rowPerpage: rowperpage, page: page);

        emploList.addAll(_departmentList);
        page++;
        print(page);
        print(emploList.length);
        yield InitializedEmployee();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingEmployee(error: e.toString());
      }
    }
    if (event is RefreshEmployeeStarted) {
      yield FetchingEmployee();
      try {
        page = 1;
        if (emploList.length != 0) {
          emploList.clear();
        }
        List<AccountModel> _departmentList = await _departmentRepository
            .getEmployeeByDepartment(rowPerpage: rowperpage, page: page);

        emploList.addAll(_departmentList);
        page++;
        yield FetchedEmployee();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingEmployee(error: e.toString());
      }
    }
    if (event is FetchAllEmployeeByDepartmentStarted) {
      yield FetchingEmployee();
      try {
        if (emploList.length != 0) {
          emploList.clear();
        }
        emploList = await _departmentRepository.getEmployeeByDepartmentAll();
        yield FetchedEmployee();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingEmployee(error: e.toString());
      }
    }

    // if (event is AddEmployeeStarted) {
    //   yield AddingEmployee();
    //   try {
    //     if (event.img == null) {
    //       image = "";
    //     } else {
    //       image = await uploadImage(image: event.img!);
    //       print(image);
    //     }
    //     await _departmentRepository.addEmployee(
    //         roleId: event.roleId,
    //         name: event.name,
    //         gender: event.gender,
    //         dob: event.dob,
    //         email: event.email,
    //         officeTel: event.officeTel,
    //         img: image!,
    //         username: event.username,
    //         password: event.password,
    //         positionId: event.positionId,
    //         departmentId: event.departmentId,
    //         // storeId: event.storeId,
    //         phoneNumber: event.phoneNumber,
    //         address: event.address);
    //     yield AddedEmployee();
    //     yield FetchingEmployee();
    //     print(emploList.length);
    //     emploList.clear();
    //     page = 1;
    //     List<EmployeeModel> _departmentList = await _departmentRepository
    //         .getEmployee(rowPerpage: rowperpage, page: page);

    //     emploList.addAll(_departmentList);
    //     page++;
    //     print(emploList.length);
    //     yield FetchedEmployee();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErorrAddingEmployee(error: e.toString());
    //   }
    // }
    // if (event is UpdateEmployeeStarted) {
    //   yield AddingEmployee();
    //   try {
    //     // if don't file image
    //     if (event.img == null) {
    //       image = event.imgUrl;
    //     } else {
    //       image = await uploadImage(image: event.img!);
    //     }
    //     await _departmentRepository.editEmployee(
    //         roleId: event.roleId,
    //         id: event.id,
    //         name: event.name,
    //         gender: event.gender,
    //         dob: event.dob,
    //         email: event.email,
    //         officeTel: event.officeTel,
    //         img: image!,
    //         // username: event.username,
    //         // password: event.password,
    //         positionId: event.positionId,
    //         departmentId: event.departmentId,
    //         // storeId: event.storeId,
    //         phoneNumber: event.phoneNumber,
    //         address: event.address);
    //     yield AddedEmployee();
    //     yield FetchingEmployee();
    //     print(emploList.length);
    //     emploList.clear();
    //     page = 1;
    //     List<EmployeeModel> _departmentList = await _departmentRepository
    //         .getEmployee(rowPerpage: rowperpage, page: page);

    //     emploList.addAll(_departmentList);
    //     page++;
    //     print(emploList.length);
    //     yield FetchedEmployee();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErorrAddingEmployee(error: e.toString());
    //   }
    // }
    // if (event is DeleteEmployeeStarted) {
    //   yield AddingEmployee();
    //   try {
    //     await _departmentRepository.deleteEmployee(id: event.id);
    //     // yield FetchingEmployee();

    //     yield AddedEmployee();
    //     yield FetchingEmployee();
    //     print(emploList.length);
    //     emploList.clear();
    //     page = 1;
    //     List<EmployeeModel> _departmentList = await _departmentRepository
    //         .getEmployee(rowPerpage: rowperpage, page: page);

    //     emploList.addAll(_departmentList);
    //     page++;
    //     print(emploList.length);
    //     yield FetchedEmployee();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErorrAddingEmployee(error: e.toString());
    //   }
    // }
    // if (event is ChangePasswordButtonPressed) {
    //   yield Changing();
    //   try {
    //     await Future.delayed(Duration(milliseconds: 500));
    //     final String accessToken = await _departmentRepository.resetPassword(
    //       id: event.id,
    //       // oldpassowrd: event.oldpass,
    //       newpassowrd: event.newpass,
    //     );
    //     yield Changed(accessToken: accessToken);
    //   } catch (e) {
    //     yield ChangeFailed(error: e.toString());
    //   }
    // }
    // if (event is AdminPasswordStarted) {
    //   yield Changing();
    //   try {
    //     await Future.delayed(Duration(milliseconds: 500));
    //     final UserModel _userModel =
    //         await _departmentRepository.resetAdminPassword(
    //       oldpassowrd: event.oldpass,
    //       newpassowrd: event.newpass,
    //     );
    //     print(_userModel);
    //     yield ChangedAdmin(userModel: _userModel);
    //   } catch (e) {
    //     yield ChangeFailed(error: e.toString());
    //   }
    // }

    // if (event is AddCheckinStarted) {
    //   yield AddingCheckin();
    //   try {
    //     await _departmentRepository.checkin(
    //         checkinTime: event.checkinTime, employeeId: event.employeeId);
    //     yield AddedCheckin();
    //     yield FetchingEmployee();
    //     print(emploList.length);
    //     emploList.clear();
    //     page = 1;
    //     List<EmployeeModel> _departmentList = await _departmentRepository
    //         .getEmployee(rowPerpage: rowperpage, page: page);

    //     emploList.addAll(_departmentList);
    //     page++;
    //     print(emploList.length);
    //     yield FetchedEmployee();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErrorAddingCheckInOut(error: e.toString());
    //   }
    // }
    // if (event is AddCheckoutStarted) {
    //   yield AddingCheckin();
    //   try {
    //     await _departmentRepository.checkout(
    //         id: event.id,
    //         checkoutTime: event.checkoutTime,
    //         employeeId: event.employeeId);
    //     yield AddedCheckin();
    //     yield FetchingEmployee();
    //     print(emploList.length);
    //     emploList.clear();
    //     page = 1;
    //     List<EmployeeModel> _departmentList = await _departmentRepository
    //         .getEmployee(rowPerpage: rowperpage, page: page);

    //     emploList.addAll(_departmentList);
    //     page++;
    //     print(emploList.length);
    //     yield FetchedEmployee();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErrorAddingCheckInOut(error: e.toString());
    //   }
    // }
  }
}
