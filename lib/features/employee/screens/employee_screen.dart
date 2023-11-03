import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/bloc/employee/employee_bloc.dart';
import 'package:jcc_admin/common/widget/menu_drawer.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/features/employee/widget/employee_widget.dart';
import 'package:jcc_admin/generated/assets.dart';
import '../../../common/widget/scroll_to_hide_widget.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({
    super.key,
    required this.controller,
    required this.bottomNavKey,
  });

  final ScrollController controller;
  final GlobalKey<ScrollToHideWidgetState> bottomNavKey;

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 85,
        ),
        child: FloatingActionButton.extended(
          label: Text(
            "Register Employee",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
          ),
          icon: SvgPicture.asset(Assets.iconsEdit),
          onPressed: () {
            context.push('/employee_create');
          },
          backgroundColor: AppColors.darkMidnightBlue,
        ),
      ),
      drawer: const MenuDrawer(),
      onDrawerChanged: (isOpened) {
        if (isOpened) {
          if (widget.bottomNavKey.currentState != null) {

            if (widget.bottomNavKey.currentState!.isVisible) {
              widget.bottomNavKey.currentState!.hide();
            }
          } else {
          }
        } else {
          if (widget.bottomNavKey.currentState != null) {
            if (!widget.bottomNavKey.currentState!.isVisible) {
              widget.bottomNavKey.currentState!.show();
            }
          } else {
          }
        }
      },
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: SvgPicture.asset(
              Assets.iconsMenu,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text(
          'Employee',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
          ),
        ),
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading || state is EmployeeInitial) {
            const CircularProgressIndicator();
          } else if (state is EmployeeLoaded) {
            if (state.employeeList.isEmpty) {
              return Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Center(
                    child: Text("No Employee Found"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Nothing to Show',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                child: ListView.builder(
                  controller: widget.controller,
                  itemBuilder: (context, index) {
                    return EmployeeWidget(
                      employeeModel: state.employeeList[index],
                    );
                  },
                  itemCount: state.employeeList.length,
                ),
              );
            }
          } else if (state is EmployeeError) {
            return Text(state.error);
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}