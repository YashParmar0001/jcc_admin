// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jcc_admin/bloc/employee/employee_register_form/complaint_register_form_bloc.dart';
import 'package:jcc_admin/bloc/employee/register/employee_register_bloc.dart';
import 'package:jcc_admin/bloc/login/login_bloc.dart';
import 'package:jcc_admin/common/widget/primary_button.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/generated/assets.dart';
import 'package:jcc_admin/utils/generation_utils.dart';
import 'package:jcc_admin/utils/ui_utils.dart';

class EmployeeCreate extends StatefulWidget {
  const EmployeeCreate({super.key});

  @override
  State<EmployeeCreate> createState() => _EmployeeCreateState();
}

class _EmployeeCreateState extends State<EmployeeCreate> {
  File? imageFile;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final password = GenerationUtils.generate8DigitPassword();

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
                employeeData['password'] = password;
                employeeData['department'] =
                    (context.read<LoginBloc>().state as LoggedIn)
                        .employee
                        .department;

                dev.log(employeeData.toString(), name: "Employee data");
                context.read<EmployeeRegisterBloc>().add(
                      RegisterEmployee(
                        employeeData: employeeData,
                        image: imageFile!,
                      ),
                    );
              },
              child: BlocListener<EmployeeRegisterBloc, EmployeeRegisterState>(
                listener: (context, state) {
                  if (state is EmployeeRegistering) {
                    UIUtils.showAlertDialog(context, "Registering Employee...");
                  } else if (state is EmployeeRegisterSuccess) {
                    context.pop();
                    context.go('/employee_screen');
                  } else if (state is EmployeeRegisterFailure) {}
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField(
                          label: "First Name:",
                          bloc: registerBloc.firstName,
                          hint: 'Enter first name...',
                          keyboardType: TextInputType.name,
                          capitalization: TextCapitalization.sentences,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildTextField(
                          label: "Middle Name:",
                          bloc: registerBloc.middleName,
                          hint: 'Enter middle name...',
                          keyboardType: TextInputType.name,
                          capitalization: TextCapitalization.sentences,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildTextField(
                          label: "Last Name:",
                          bloc: registerBloc.lastName,
                          hint: 'Enter last name...',
                          keyboardType: TextInputType.name,
                          capitalization: TextCapitalization.sentences,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildTextField(
                          label: "Employee ID:",
                          bloc: registerBloc.employeeId,
                          hint: 'Enter employee id...',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildTextField(
                            label: 'Phone No:',
                            bloc: registerBloc.phone,
                            hint: 'Enter phone no...',
                            keyboardType: TextInputType.number,
                            prefixText: '+91 | '),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildTextField(
                          label: "Email:",
                          bloc: registerBloc.email,
                          hint: 'Enter email...',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildDropdownField(
                          bloc: registerBloc.ward,
                          hint: "-- select ward no --",
                          label: "Ward No:",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload Employee Profile:',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AspectRatio(
                              aspectRatio: 260 / 180,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: AppColors.grey,
                                  image: (imageFile != null)
                                      ? DecorationImage(
                                          image: FileImage(
                                            imageFile!,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: getImage,
                                    icon: SvgPicture.asset(
                                      Assets.iconsCircleAdd,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildPasswordGenerationField(password),
                        const SizedBox(
                          height: 15,
                        ),
                        PrimaryButton(
                          onTap: registerBloc.submit,
                          title: 'Add',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
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

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    XFile? xFilePick = pickedFile;
    setState(
      () {
        if (xFilePick != null) {
          imageFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Widget _buildPasswordGenerationField(String password) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password:',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              password,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.black.withOpacity(0.7),
                  ),
            ),
            InkWell(
              onTap: () {
                setState(() {});
              },
              // child: Icon(Icons.refresh),
              child: SvgPicture.asset(Assets.iconsReload),
            ),
          ],
        ),
      ],
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
    required TextInputType keyboardType,
    String? prefixText,
    TextCapitalization? capitalization,
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
        TextFieldBlocBuilder(
          textFieldBloc: bloc,
          textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: 'Roboto',
              ),
          keyboardType: keyboardType,
          textCapitalization: capitalization ?? TextCapitalization.none,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.black60,
                ),
            prefixText: prefixText,
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
