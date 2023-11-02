// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jcc_admin/bloc/complaint/complaint_bloc.dart';
import 'package:jcc_admin/bloc/login/login_bloc.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/utils/ui_utils.dart';

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
      body: BlocListener<LoginBloc, LoginState>(
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
            context.read<ComplaintBloc>().add(LoadComplaint(
                  state.employee.department,
                ));
            context.go('/home');
          }
        },
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
                  //Container button with blue color and text as login with 70px height
                  InkWell(
                    onTap: () {
                      context.read<LoginBloc>().add(
                            LogIn(
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
