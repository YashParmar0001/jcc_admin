// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/bloc/employee/delete_employee/delete_employee_bloc.dart';
import 'package:jcc_admin/bloc/employee/selected_employee/selected_employee_bloc.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/generated/assets.dart';
import 'package:jcc_admin/utils/ui_utils.dart';

import 'dart:developer' as dev;

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({super.key});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteEmployeeBloc, DeleteEmployeeState>(
      listener: (context, state) {
        if (state is DeletingEmployee) {
          UIUtils.showAlertDialog(context, 'Deleting Employee...');
        } else if (state is EmployeeDeleted) {
          context
              .read<SelectedEmployeeBloc>()
              .add(InitializeSelectedEmployee());
          context.go('/employee_screen');
        } else if (state is EmployeeDeletionError) {
          context.pop();
          UIUtils.showSnackBar(
            context,
            'Error in employee deletion: ${state.message}',
          );
        }
      },
      child: Scaffold(
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
                    height: 1,
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: AppColors.black50,
                      ),
                    ),
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
                      final state = context.read<SelectedEmployeeBloc>().state;
                      if (state is SelectedEmployeeLoaded) {
                        final email = state.employee.email;

                        context
                            .read<DeleteEmployeeBloc>()
                            .add(DeleteEmployee(email));
                      }
                    },
                  ),
                ];
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocBuilder<SelectedEmployeeBloc, SelectedEmployeeState>(
            builder: (context, state) {
              if (state is SelectedEmployeeLoading ||
                  state is SelectedEmployeeInitial) {
                return const CircularProgressIndicator();
              } else if (state is SelectedEmployeeError) {
                return Text(state.message);
              } else if (state is SelectedEmployeeLoaded) {
                final employee = state.employee;

                return Stack(
                  children: [
                    SizedBox(
                      height: 138,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        UIUtils.getThumbnailName(employee.department),
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
                                clipBehavior: Clip.hardEdge,
                                child: CachedNetworkImage(
                                  imageUrl: employee.photoUrl,
                                  imageBuilder: (context, imageProvider) {
                                    return Image(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return Image.asset(
                                      Assets.imagesDefaultProfile,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Image.asset(
                                      Assets.imagesDefaultProfile,
                                      fit: BoxFit.cover,
                                    );
                                  },
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
                                "${employee.firstName} ${employee.middleName} ${employee.lastName}",
                          ),
                          _buildEmployDataField(
                            title: "Employee ID",
                            data: employee.employeeId,
                          ),
                          _buildEmployDataField(
                            title: "Mobile No",
                            data: employee.phone,
                          ),
                          _buildEmployDataField(
                            title: "Email",
                            data: employee.email,
                          ),
                          _buildEmployDataField(
                            title: "Department",
                            data: employee.department,
                          ),
                          _buildEmployDataField(
                            title: "Post",
                            data: "Employee",
                          ),
                          _buildEmployDataField(
                            title: "Ward no",
                            data: employee.ward,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return const Text('Unknown state');
              }
            },
          ),
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
