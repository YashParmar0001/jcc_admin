import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/common/widget/scroll_to_hide_widget.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/model/employee_model.dart';

import '../widget/employee_widget.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen(
      {super.key, required this.controller, required this.bottomNavKey});

  final ScrollController controller;
  final GlobalKey<ScrollToHideWidgetState> bottomNavKey;

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  List<EmployeeModel> employeeData = [
    const EmployeeModel(
      firstName: "Ukani",
      middleName: "Bhavy",
      lastName: "N",
      employeeId: "45454",
      phone: "976431045",
      email: "",
      department: '',
      ward: "ward",
      password: "password",
      type: 'employee',
    ),
    const EmployeeModel(
      firstName: "Ukani",
      middleName: "Bhavy",
      lastName: "N",
      employeeId: "45454",
      phone: "976431045",
      email: "",
      department: '',
      ward: "ward",
      password: "password",
      type: 'employee',
    ),
    const EmployeeModel(
      firstName: "Ukani",
      middleName: "Bhavy",
      lastName: "N",
      employeeId: "45454",
      phone: "976431045",
      email: "",
      department: '',
      ward: "ward",
      password: "password",
      type: 'employee',
    ),
    const EmployeeModel(
      firstName: "Ukani",
      middleName: "Bhavy",
      lastName: "N",
      employeeId: "45454",
      phone: "976431045",
      email: "",
      department: '',
      ward: "ward",
      password: "password",
      type: 'employee',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmployeeScreen'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.darkMidnightBlue,
        onPressed: () {
          context.push('/newEmployee');
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(
          "Add Employees",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: employeeData.length,
        itemBuilder: (context, index) {
          return EmployeeWidget(employeeModel: employeeData[index]);
        },
      ),
    );
  }
}