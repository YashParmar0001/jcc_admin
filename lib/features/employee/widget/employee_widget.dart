// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/generated/assets.dart';

import 'package:jcc_admin/model/employee_model.dart';

class EmployeeWidget extends StatelessWidget {
  final EmployeeModel employeeModel;
  const EmployeeWidget({super.key, required this.employeeModel});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        context.push('/employeeView/${employeeModel.employeeId}');
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(15),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.geryis),
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
                    '${employeeModel.firstName} ${employeeModel.middleName} ${employeeModel.lastName}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkMidnightBlue
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    employeeModel.phone,
                    style : Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Emp. ID : ${employeeModel.employeeId}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      // Spacer(),
                      Text(
                        "Ward no : ${employeeModel.ward}",
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
