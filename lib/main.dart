import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jcc_admin/bloc/complaint/complaint_bloc.dart';
import 'package:jcc_admin/bloc/complaint/selected_complaint/selected_complaint_bloc.dart';
import 'package:jcc_admin/bloc/employee/delete_employee/delete_employee_bloc.dart';
import 'package:jcc_admin/bloc/employee/employee_bloc.dart';
import 'package:jcc_admin/bloc/employee/register/employee_register_bloc.dart';
import 'package:jcc_admin/bloc/employee/selected_employee/selected_employee_bloc.dart';
import 'package:jcc_admin/bloc/login/login_bloc.dart';
import 'package:jcc_admin/config/router.dart';
import 'package:jcc_admin/firebase_options.dart';
import 'package:jcc_admin/repositories/complaint_repository.dart';
import 'package:jcc_admin/repositories/employee_repository.dart';
import 'package:jcc_admin/repositories/login_repository.dart';
import 'package:jcc_admin/repositories/notification_repository.dart';
import 'package:jcc_admin/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'bloc/complaint/stats/complaint_stats_bloc.dart';
import 'config/onesignal_config.dart';
import 'dart:developer' as dev;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // OneSignal.Notifications.clearAll();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(OneSignalConfig.oneSignalAppId);
  OneSignal.Notifications.requestPermission(true);
  dev.log("${OneSignal.Notifications.permission}");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loginRepository = LoginRepository();
    final employeeRepository = EmployeeRepository();
    final complaintRepository = ComplaintRepository();
    final notificationRepository = NotificationRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(loginRepository: loginRepository),
        ),
        BlocProvider(
          create: (context) => ComplaintBloc(
            complaintRepository: complaintRepository,
          ),
        ),
        BlocProvider(
          create: (context) => SelectedComplaintBloc(
            complaintRepository: complaintRepository,
            notificationRepository: notificationRepository,
          ),
        ),
        BlocProvider(
          create: (context) =>
              SelectedEmployeeBloc(employeeRepository: employeeRepository),
        ),
        BlocProvider(
          create: (context) =>
              DeleteEmployeeBloc(employeeRepository: employeeRepository),
        ),
        BlocProvider(
          create: (context) => EmployeeBloc(
            employeeRepository: employeeRepository,
          ),
        ),
        BlocProvider(
          create: (context) => EmployeeRegisterBloc(
            employeeRepository: employeeRepository,
          ),
        ),
        BlocProvider(
          create: (context) =>
              ComplaintStatsBloc(complaintRepository: complaintRepository)
                ..add(GetComplaintStats()),
        ),
      ],
      child: MaterialApp.router(
        theme: AppTheme.getTheme(),
        routerConfig: router,
      ),
    );
  }
}
