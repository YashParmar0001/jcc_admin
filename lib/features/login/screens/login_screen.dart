// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jcc_admin/bloc/auth/auth_bloc.dart' as auth_bloc;
import 'package:jcc_admin/bloc/complaint/complaint_bloc.dart';
import 'package:jcc_admin/bloc/complaint/recent_complaints/recent_complaints_bloc.dart';
import 'package:jcc_admin/bloc/complaint/stats/complaint_stats_bloc.dart';
import 'package:jcc_admin/bloc/login/login_bloc.dart';
import 'package:jcc_admin/bloc/notifications/notification_bloc.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/utils/ui_utils.dart';

import '../../../bloc/employee/employee_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: MultiBlocListener(
        listeners: [
          BlocListener<auth_bloc.AuthBloc, auth_bloc.AuthState>(
            listener: (context, state) {
              if (state is auth_bloc.Authenticated) {
                context.pop();
                context.read<LoginBloc>().add(LogIn(email: state.email));
              } else if (state is auth_bloc.UnAuthenticated) {
                context.pop();
                UIUtils.showSnackBar(
                  context,
                  'Something went wrong while logging you in!',
                );
              }else if (state is auth_bloc.Authenticating) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Center(child: const CircularProgressIndicator());
                  },
                );
              }
            },
          ),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoggingIn) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Center(child: const CircularProgressIndicator());
                  },
                );
              } else if (state is NotRegistered) {
                context.pop();
                UIUtils.showSnackBar(
                  context,
                  'You are not registered as employee!',
                );
              } else if (state is LoggedIn) {
                context.read<ComplaintStatsBloc>().add(GetComplaintStats());
                context.read<ComplaintBloc>().add(
                      LoadComplaint(
                        department: state.employee.department,
                      ),
                    );
                context
                    .read<RecentComplaintsBloc>()
                    .add(LoadRecentComplaints());
                context.read<NotificationBloc>().add(
                      LoadNotifications(
                        state.employee.department,
                      ),
                    );
                if (state.employee.type == 'hod') {
                  context
                      .read<EmployeeBloc>()
                      .add(LoadEmployee(state.employee.department));
                }
                context.go('/home');
              }
            },
          ),
        ],
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/backgrounds/login_background.svg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Center(
            //   child: Image.asset("assets/logo/logo.png"),
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter email address",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: emailController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Password:",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: passwordController,
                    cursorColor: Colors.black,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      context.read<auth_bloc.AuthBloc>().add(
                            auth_bloc.LogIn(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    },
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.darkMidnightBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
