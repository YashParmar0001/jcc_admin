// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jcc_admin/bloc/employee/edit_employee/edit_employee_bloc.dart';
import 'package:jcc_admin/bloc/employee/edit_employee/edit_employee_form_bloc.dart';
import 'package:jcc_admin/bloc/employee/selected_employee/selected_employee_bloc.dart';
import 'package:jcc_admin/common/widget/primary_button.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/generated/assets.dart';
import 'package:jcc_admin/utils/generation_utils.dart';
import 'package:jcc_admin/utils/ui_utils.dart';

class EmployeeEdit extends StatefulWidget {
  const EmployeeEdit({super.key, required this.password});

  final String password;

  @override
  State<EmployeeEdit> createState() => _EmployeeEditState();
}

class _EmployeeEditState extends State<EmployeeEdit> {
  File? imageFile;
  final picker = ImagePicker();
  late String password;
  bool isEmailChanged = false;

  @override
  void initState() {
    password = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final employee =
        (context.read<SelectedEmployeeBloc>().state as SelectedEmployeeLoaded)
            .employee;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Employee",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: BlocProvider(
        create: (context) {
          final prefilledEmployeeData = (context
                  .read<SelectedEmployeeBloc>()
                  .state as SelectedEmployeeLoaded)
              .employee;
          return EditEmployeeFormBloc(prefilledEmployeeData);
        },
        child: Builder(
          builder: (context) {
            final editBloc = context.read<EditEmployeeFormBloc>();

            return FormBlocListener<EditEmployeeFormBloc, Map<String, dynamic>,
                String>(
              onSubmitting: (context, state) {},
              onFailure: (context, state) {},
              onSuccess: (context, state) {
                final employeeData = state.successResponse!;
                employeeData['password'] = password;
                employeeData['department'] = employee.department;
                employeeData['photoUrl'] = employee.photoUrl;

                dev.log(employeeData.toString(), name: "Employee data");

                isEmailChanged = employee.email != employeeData['email'];
                if (isEmailChanged) employeeData['oldEmail'] = employee.email;
                context.read<EditEmployeeBloc>().add(
                      EditEmployee(
                        employeeData: employeeData,
                        image: imageFile,
                        isEmailChanged: isEmailChanged,
                      ),
                    );
              },
              child: BlocListener<EditEmployeeBloc, EditEmployeeState>(
                listener: (context, state) {
                  if (state is EmployeeEditing) {
                    UIUtils.showAlertDialog(context, "Editing Employee...");
                  } else if (state is EmployeeEditSuccess) {
                    if (isEmailChanged) {
                      context
                          .read<SelectedEmployeeBloc>()
                          .add(LoadSelectedEmployee(state.email));
                    }
                    context.pop();
                    context.pop();
                  } else if (state is EmployeeEditFailure) {
                    context.pop();
                    UIUtils.showSnackBar(
                      context,
                      'Error in editing employee: ${state.error}',
                    );
                  }
                },
                child: BlocBuilder<EditEmployeeFormBloc, FormBlocState>(
                  builder: (context, state) {
                    if (state is FormBlocLoading) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Please wait'),
                          ],
                        ),
                      );
                    } else if (state is FormBlocLoadFailed) {
                      return Center(
                        child: ElevatedButton(
                          onPressed:
                              context.read<EditEmployeeFormBloc>().reload,
                          child: const Text('Reload'),
                        ),
                      );
                    } else if (state is FormBlocSubmitting) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text('Updating employee details'),
                          ],
                        ),
                      );
                    }

                    return SingleChildScrollView(
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
                              bloc: editBloc.firstName,
                              hint: 'Enter first name...',
                              keyboardType: TextInputType.name,
                              capitalization: TextCapitalization.sentences,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            _buildTextField(
                              label: "Middle Name:",
                              bloc: editBloc.middleName,
                              hint: 'Enter middle name...',
                              keyboardType: TextInputType.name,
                              capitalization: TextCapitalization.sentences,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            _buildTextField(
                              label: "Last Name:",
                              bloc: editBloc.lastName,
                              hint: 'Enter last name...',
                              keyboardType: TextInputType.name,
                              capitalization: TextCapitalization.sentences,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            _buildTextField(
                              label: "Employee ID:",
                              bloc: editBloc.employeeId,
                              hint: 'Enter employee id...',
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            _buildTextField(
                                label: 'Phone No:',
                                bloc: editBloc.phone,
                                hint: 'Enter phone no...',
                                keyboardType: TextInputType.number,
                                prefixText: '+91 | '),
                            const SizedBox(
                              height: 15,
                            ),
                            _buildTextField(
                              label: "Email:",
                              bloc: editBloc.email,
                              hint: 'Enter email...',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            _buildDropdownField(
                              bloc: editBloc.ward,
                              hint: "-- select ward no --",
                              label: "Ward No:",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            _buildUploadProfileSection(employee.photoUrl),
                            const SizedBox(
                              height: 15,
                            ),
                            _buildPasswordGenerationField(password, () {
                              setState(() {
                                password =
                                    GenerationUtils.generate8DigitPassword();
                              });
                            }),
                            const SizedBox(
                              height: 15,
                            ),
                            PrimaryButton(
                              onTap: editBloc.submit,
                              title: 'Apply Changes',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUploadProfileSection(String photoUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upload Employee Profile:',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            if (imageFile != null)
              IconButton(onPressed: removeImage, icon: Icon(Icons.clear)),
          ],
        ),
        if (imageFile == null)
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
              image: (imageFile == null)
                  ? DecorationImage(
                      image: NetworkImage(photoUrl),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: FileImage(imageFile!),
                      fit: BoxFit.cover,
                    ),
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
    );
  }

  void removeImage() {
    setState(() {
      imageFile = null;
    });
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

  Widget _buildPasswordGenerationField(
      String password, VoidCallback onRefresh) {
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
              onTap: onRefresh,
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
