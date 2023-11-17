import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:jcc_admin/constants/string_constants.dart';
import 'dart:developer' as dev;

import 'package:jcc_admin/model/employee_model.dart';

class EditEmployeeFormBloc extends FormBloc<Map<String, dynamic>, String> {
  EditEmployeeFormBloc(this.prefilledEmployeeData) : super(isLoading: true) {
    addFieldBlocs(fieldBlocs: [
      firstName,
      middleName,
      lastName,
      employeeId,
      phone,
      email,
      ward,
    ]);
  }

  final EmployeeModel prefilledEmployeeData;

  final ward =
      SelectFieldBloc(items: CommonDataConstants.wardNameList.toList());

  final firstName = TextFieldBloc();
  final middleName = TextFieldBloc();
  final lastName = TextFieldBloc();
  final employeeId = TextFieldBloc();
  final phone = TextFieldBloc();
  final email = TextFieldBloc();

  @override
  FutureOr<void> onLoading() {
    try {
      firstName.updateInitialValue(prefilledEmployeeData.firstName);
      middleName.updateInitialValue(prefilledEmployeeData.middleName);
      lastName.updateInitialValue(prefilledEmployeeData.lastName);
      employeeId.updateInitialValue(prefilledEmployeeData.employeeId);
      phone.updateInitialValue(prefilledEmployeeData.phone);
      email.updateInitialValue(prefilledEmployeeData.email);
      ward.updateInitialValue(prefilledEmployeeData.ward);
      emitLoaded();
    }catch(e) {
      dev.log('Got loading error: $e', name: 'Employee');
      emitLoadFailed();
    }
  }

  @override
  FutureOr<void> onSubmitting() {
    try {
      final data = {
        'firstName': firstName.value,
        'middleName': middleName.value,
        'lastName': lastName.value,
        'employeeId': employeeId.value,
        'phone': phone.value,
        'email': email.value,
        'ward': ward.value,
        'department': '-',
        'type': 'employee',
        'password': '-',
      };
      emitSuccess(successResponse: data);
    } catch (e) {
      dev.log('Got error in complaint register: $e',
          name: 'Employee form bloc');
      emitFailure(failureResponse: 'Error: $e');
    }
  }
}
