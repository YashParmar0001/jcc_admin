import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/common/widget/app_scaffold.dart';
import 'package:jcc_admin/features/complaint/screens/complaint_screen.dart';
import 'package:jcc_admin/features/home/sreens/home_screen.dart';
import 'package:jcc_admin/features/login/screens/login_screen.dart';
import 'package:jcc_admin/features/notification/screens/notification_screen.dart';
import 'package:jcc_admin/features/splash_screen.dart';
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

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
      path: '/complaintView',
      builder: (context, state) => const Text("Complaint View"),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
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
          parentNavigatorKey: _shellNavigatorKey,
          path: '/complaints',
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
          parentNavigatorKey: _shellNavigatorKey,
          path: '/notifications',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const NotificationScreen(),
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