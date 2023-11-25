import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/bloc/auth/auth_bloc.dart' as auth_bloc;
import 'package:jcc_admin/bloc/login/login_bloc.dart';

import '../bloc/complaint/complaint_bloc.dart';
import '../bloc/complaint/recent_complaints/recent_complaints_bloc.dart';
import '../bloc/complaint/stats/complaint_stats_bloc.dart';
import '../bloc/employee/employee_bloc.dart';
import '../bloc/notifications/notification_bloc.dart';
import '../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<auth_bloc.AuthBloc, auth_bloc.AuthState>(
          listener: (context, state) {
            if (state is auth_bloc.UnAuthenticated) {
              context.go('/login');
            }else if (state is auth_bloc.Authenticated) {
              context.read<LoginBloc>().add(LogIn(email: state.email));
            }
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoggedIn) {
              context.read<ComplaintStatsBloc>().add(GetComplaintStats());
              context.read<ComplaintBloc>().add(
                LoadComplaint(
                  department: state.employee.department,
                ),
              );
              context.read<RecentComplaintsBloc>().add(LoadRecentComplaints());
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
            }else if (state is NotRegistered) {
              context.read<auth_bloc.AuthBloc>().add(auth_bloc.LogOut());
            }
          },
        ),
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.iconsLogo),
              const SizedBox(
                height: 5,
              ),
              const CircularProgressIndicator(),
              const Text('Please wait'),
            ],
          ),
        ),
      ),
    );
  }
}
