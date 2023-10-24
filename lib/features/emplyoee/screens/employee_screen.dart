import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/features/emplyoee/widget/employee_widget.dart';
import 'package:jcc_admin/model/employee_model.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

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
      ward: "23",
      password: "password",
    ),
    const EmployeeModel(
      firstName: "Ukani",
      middleName: "Bhavy",
      lastName: "N",
      employeeId: "45454",
      phone: "976431045",
      email: "",
      ward: "23",
      password: "password",
    ),
    const EmployeeModel(
      firstName: "Ukani",
      middleName: "Bhavy",
      lastName: "N",
      employeeId: "45454",
      phone: "976431045",
      email: "",
      ward: "23",
      password: "password",
    ),
    const EmployeeModel(
      firstName: "Ukani",
      middleName: "Bhavy",
      lastName: "N",
      employeeId: "45454",
      phone: "976431045",
      email: "",
      ward: "23",
      password: "password",
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
          return GestureDetector(
            onTap: () {
              context.push('/employeeDetails');
            },
            child: EmployeeWidget(employeeModel: employeeData[index]),
          );
        },
      ),
    );
  }
}
