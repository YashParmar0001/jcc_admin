// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/bloc/employee/employee_bloc.dart';
import 'package:jcc_admin/bloc/login/login_bloc.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/generated/assets.dart';
import 'package:jcc_admin/model/employee_model.dart';
import 'package:jcc_admin/repositories/employee_repository.dart';
import 'package:jcc_admin/utils/ui_utils.dart';

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
    employeeModel = (context.read<EmployeeBloc>().state as EmployeeLoaded)
        .employeeList
        .firstWhere((element) => element.employeeId == widget.id);
    print(employeeModel.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(
            Assets.iconsBackArrow,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          'Employee Details',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.iconsEdit,
                        colorFilter: const ColorFilter.mode(
                          AppColors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Edit"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: AppColors.black50,
                    ),
                  ),
                  height: 1,
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.iconsDeleteBg,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Delete"),
                    ],
                  ),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            SizedBox(
              height: 138,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                UIUtils.getThumbnailName(employeeModel.department),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          Assets.iconsUser,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
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
                  _buildEmployDataField(title: "Post", data: "Employee"),
                  _buildEmployDataField(
                      title: "Ward no", data: "${employeeModel.ward}"),
                ],
              ),
            )
          ],
        ),
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
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.darkMidnightBlue50,
              ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          data,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.darkMidnightBlue,
                fontWeight: FontWeight.w300,
              ),
        ),
        SizedBox(height: 15)
      ],
    );
  }
}
