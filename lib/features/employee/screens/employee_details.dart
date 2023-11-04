// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/bloc/employee/employee_bloc.dart';
import 'package:jcc_admin/generated/assets.dart';
import 'package:jcc_admin/model/employee_model.dart';
import 'package:jcc_admin/repositories/employee_repository.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({super.key, required this.id});

  final String id;

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  late EmployeeModel employeeModel;


  @override
  Widget build(BuildContext context) {
    print("Hello");
    employeeModel = (context.read<EmployeeBloc>().state as EmployeeLoaded)
          .employeeList
          .firstWhere((element) => element.employeeId == widget.id) ;
      print(employeeModel.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmployeeDetails'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text("Edit"),
                ),
                PopupMenuItem(
                  child: Text("Delete"),
                  onTap: () async {
                    final email = employeeModel.email;
                    await FirebaseFirestore.instance
                        .collection('employees')
                        .doc('${employeeModel.email}')
                        .delete();
                    context.pop();
                  },
                ),
              ];
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/department/water.png",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Image.asset(
                    Assets.iconsLogo,
                    width: double.infinity,
                  ),
                  _buildEmployDataField(
                      title: "Full name ", data: "${employeeModel.firstName} ${employeeModel.middleName} ${employeeModel.lastName}"),
                  _buildEmployDataField(
                      title: "Employee ID", data: "${employeeModel.employeeId}"),
                  _buildEmployDataField(
                      title: "Mobile No", data: "${employeeModel.phone}"),
                  _buildEmployDataField(
                      title: "Email", data: "${employeeModel.email}"),
                  _buildEmployDataField(title: "Department", data: "Coding"),
                  _buildEmployDataField(title: "Post", data: "Pro Developer"),
                  _buildEmployDataField(
                      title: "Ward no", data: "${employeeModel.ward}"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEmployDataField({required String title, required String data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
