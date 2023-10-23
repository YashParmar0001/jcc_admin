import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/features/complaint/screens/complaint_screen.dart';
import 'package:jcc_admin/features/emplyoee/screens/employee_create.dart';
import 'package:jcc_admin/features/notification/screens/notification_screen.dart';

import '../features/base/screens/base_screen.dart';
import '../features/emplyoee/screens/employee_screen.dart';
import '../features/home/sreens/home_screen.dart';
import '../features/login/screens/login_screen.dart';
import '../features/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKay = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/newEmployee',
      builder: (context, state) => EmployeeCreate(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKay,
      builder: (context, state, child) => BaseScreen(child: child),
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKay,
          path: '/home',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const HomeScreen(),
              transitionDuration: Duration.zero,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKay,
          path: '/complaint',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const ComplaintScreen(),
              transitionDuration: Duration.zero,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKay,
          path: '/employee',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const EmployeeScreen(),
              transitionDuration: Duration.zero,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            );
          },
        ),GoRoute(
          parentNavigatorKey: _shellNavigatorKay,
          path: '/notification',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const NotificationScreen(),
              transitionDuration: Duration.zero,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            );
          },
        ),
      ],
    ),
  ],
);
