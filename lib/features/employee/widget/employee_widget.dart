// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:jcc_admin/bloc/employee/selected_employee/selected_employee_bloc.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/generated/assets.dart';

import 'package:jcc_admin/model/employee_model.dart';

class EmployeeWidget extends StatelessWidget {
  final EmployeeModel employee;
  const EmployeeWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        context.push('/employee_details');
        context.read<SelectedEmployeeBloc>().add(
          LoadSelectedEmployee(employee.email),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(15),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          color: AppColors.antiFlashWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.iconsUser),
                ),
              ),
            ),
            const SizedBox(width: 17),
            Expanded(

              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${employee.firstName} ${employee.middleName} ${employee.lastName}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkMidnightBlue
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    employee.phone,
                    style : Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Emp. ID : ${employee.employeeId}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      // Spacer(),
                      Text(
                        "Ward no : ${employee.ward}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
