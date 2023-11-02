// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:jcc_admin/bloc/employee/employee_register_form/complaint_register_form_bloc.dart';
import 'package:jcc_admin/bloc/employee/register/employee_register_bloc.dart';
import 'package:jcc_admin/common/widget/primary_button.dart';
import 'package:jcc_admin/constants/app_color.dart';

class EmployeeCreate extends StatefulWidget {
  const EmployeeCreate({super.key});

  @override
  State<EmployeeCreate> createState() => _EmployeeCreateState();
}

class _EmployeeCreateState extends State<EmployeeCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Employee",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: BlocProvider(
        create: (context) => EmployeeRegisterFormBloc(),
        child: Builder(
          builder: (context) {
            final registerBloc = context.read<EmployeeRegisterFormBloc>();

            return FormBlocListener<EmployeeRegisterFormBloc,
                Map<String, dynamic>, String>(
              onSubmitting: (context, state) {},
              onFailure: (context, state) {},
              onSuccess: (context, state) {
                final employeeData = state.successResponse!;
                dev.log(employeeData.toString(), name: "Employee data");
                context.read<EmployeeRegisterBloc>().add(
                      RegisterEmployee(employeeData: employeeData),
                    );
              },
              child: BlocListener<EmployeeRegisterBloc, EmployeeRegisterState>(
                listener: (context, state) {
                  if (state is EmployeeRegistering) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Registering Employee..."),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is EmployeeRegisterSuccess) {
                    Navigator.of(context).pop();
                    GoRouter.of(context).go('/home');
                  } else if (state is EmployeeRegisterFailure) {}
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField(
                            label: "First name:",
                            bloc: registerBloc.firstName,
                            hint: 'Enter first name...'),
                        _buildTextField(
                            label: "Middle name:",
                            bloc: registerBloc.middleName,
                            hint: 'Enter middle name...'),
                        _buildTextField(
                            label: "last name:",
                            bloc: registerBloc.lastName,
                            hint: 'Enter last name...'),
                        _buildTextField(
                            label: "Employee ID:",
                            bloc: registerBloc.employeeId,
                            hint: 'Enter employee id...'),
                        _buildPhoneNoField(
                          label: "Phone No:",
                          bloc: registerBloc.phone,
                          hint: "Enter phone no...",
                        ),
                        _buildTextField(
                          label: "Email:",
                          bloc: registerBloc.email,
                          hint: 'Enter email...',
                        ),
                        _buildDropdownField(
                          bloc: registerBloc.department,
                          hint: "-- select department --",
                          label: "Department:",
                        ),
                        _buildDropdownField(
                          bloc: registerBloc.ward,
                          hint: "-- select ward no --",
                          label: "Ward No:",
                        ),
                        _buildDropdownField(
                          bloc: registerBloc.type,
                          hint: "-- select post --",
                          label: "Post",
                        ),
                        PrimaryButton(
                          onTap: registerBloc.submit,
                          title: 'Add',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required SelectFieldBloc bloc,
    required String hint,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownFieldBlocBuilder(
          selectFieldBloc: bloc,
          textOverflow: TextOverflow.ellipsis,
          textStyle: Theme.of(context).textTheme.headlineSmall,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.black60,
                ),
          ),
          itemBuilder: (context, value) {
            return FieldItem(child: Text(value.toString()));
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextFieldBloc bloc,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          label,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFieldBlocBuilder(
          textFieldBloc: bloc,
          textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: 'Roboto',
              ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.black60,
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNoField({
    required String label,
    required TextFieldBloc bloc,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          label,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFieldBlocBuilder(
          textFieldBloc: bloc,
          textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: 'Roboto',
              ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.black60,
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }
}
