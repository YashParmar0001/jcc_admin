// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/bloc/employee/employee_bloc.dart';
import 'package:jcc_admin/generated/assets.dart';
import 'package:jcc_admin/model/employee_model.dart';
import 'package:jcc_admin/repositories/employee_repository.dart';

class EmployeeDetails extends StatefulWidget {
  EmployeeDetails({super.key, required this.id});

  String id;

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
        .firstWhere((element) => element.email == widget.id);
    print(employeeModel.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EmployeeDetails',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
          ),
        ),
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
          SvgPicture.asset(
            'assets/departmentThumbnail/flood_control.svg',
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
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      Assets.iconsUser,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  _buildEmployDataField(
                      title: "Full name ",
                      data:
                          "${employeeModel.firstName} ${employeeModel.middleName} ${employeeModel.lastName}"),
                  _buildEmployDataField(
                      title: "Employee ID",
                      data: "${employeeModel.employeeId}"),
                  _buildEmployDataField(
                      title: "Mobile No", data: "${employeeModel.phone}"),
                  _buildEmployDataField(
                      title: "Email", data: "${employeeModel.email}"),
                  _buildEmployDataField(
                      title: "Department", data: "${employeeModel.department}"),
                  _buildEmployDataField(
                      title: "Post", data: "${employeeModel.type}"),
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
