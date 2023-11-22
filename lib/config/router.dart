import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/common/widget/app_scaffold.dart';
import 'package:jcc_admin/common/widget/scroll_to_hide_widget.dart';
import 'package:jcc_admin/features/complaint/screens/complaint_details.dart';
import 'package:jcc_admin/features/complaint/screens/complaint_screen.dart';
import 'package:jcc_admin/features/complaint/screens/complaint_view.dart';
import 'package:jcc_admin/features/employee/screens/employee_create.dart';
import 'package:jcc_admin/features/employee/screens/employee_details.dart';
import 'package:jcc_admin/features/employee/screens/employee_edit.dart';
import 'package:jcc_admin/features/employee/screens/employee_screen.dart';
import 'package:jcc_admin/features/home/sreens/home_screen.dart';
import 'package:jcc_admin/features/login/screens/login_screen.dart';
import 'package:jcc_admin/features/notification/screens/notification_screen.dart';
import 'package:jcc_admin/features/profile/screens/user_profile.dart';
import 'package:jcc_admin/features/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _controller = ScrollController();
final _bottomNavKey = GlobalKey<ScrollToHideWidgetState>();

final router = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/complaintView/:id',
      builder: (context, state) => ComplaintView(
        id: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/user_profile',
      builder: (context, state) => const UserProfile(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/complaint_details',
      builder: (context, state) {
        return const ComplaintDetails();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/employee_create',
      builder: (context, state) => const EmployeeCreate(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/employee_details',
      builder: (context, state) => const EmployeeDetails(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/employee_edit/:password',
      builder: (context, state) => EmployeeEdit(
        password: state.pathParameters['password']!,
      ),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppScaffold(
        bottomNavKey: _bottomNavKey,
        controller: _controller,
        child: child,
      ),
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/home',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: HomeScreen(
                controller: _controller,
                bottomNavKey: _bottomNavKey,
              ),
              transitionDuration: Duration.zero,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/complaint_screen',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: ComplaintScreen(
                controller: _controller,
                bottomNavKey: _bottomNavKey,
              ),
              transitionDuration: Duration.zero,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            );
          },
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'complaint_details',
              builder: (context, state) => ComplaintDetails(),
            ),
          ],
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/employee_screen',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: EmployeeScreen(
                controller: _controller,
                bottomNavKey: _bottomNavKey,
              ),
              transitionDuration: Duration.zero,
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return child;
              },
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/notifications',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: NotificationScreen(
                controller: _controller,
                bottomNavKey: _bottomNavKey,
              ),
              transitionDuration: Duration.zero,
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return child;
              },
            );
          },
        ),
      ],
    ),
  ],
);
