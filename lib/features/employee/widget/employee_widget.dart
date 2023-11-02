// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:jcc_admin/model/employee_model.dart';

class EmployeeWidget extends StatelessWidget {
  final EmployeeModel employeeModel;
  const EmployeeWidget({super.key, required this.employeeModel});

  @override
  Widget build(BuildContext context) {
    return Container(height: 20, color: Colors.blue,);
  }
}
