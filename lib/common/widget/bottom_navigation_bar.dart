// this file created by jay pedhadiya

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/constants/string_constants.dart';

class AppBottomNavigationBar extends StatelessWidget {
  AppBottomNavigationBar({super.key});

  final outlinedIcon = [
    SvgPicture.asset(
      'assets/icons/home.svg',
      colorFilter: const ColorFilter.mode(AppColors.black60, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      'assets/icons/complaints.svg',
      colorFilter: const ColorFilter.mode(AppColors.black60, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      'assets/icons/employee.svg',
      colorFilter: const ColorFilter.mode(AppColors.black60, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      'assets/icons/notification.svg',
      colorFilter: const ColorFilter.mode(AppColors.black60, BlendMode.srcIn),
    ),
  ];

  final filledIcons = [
    SvgPicture.asset(
      'assets/icons/home.svg',
      colorFilter: const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      'assets/icons/complaints.svg',
      colorFilter: const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      'assets/icons/employee.svg',
      colorFilter: const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      'assets/icons/notification.svg',
      colorFilter: const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: 0.5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      height: 75,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          backgroundColor: AppColors.antiFlashWhite,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.blue,
          unselectedItemColor: AppColors.black60,
          showUnselectedLabels: true,
          unselectedLabelStyle: Theme.of(context).textTheme.titleLarge,
          selectedLabelStyle: Theme.of(context).textTheme.headlineSmall,
          currentIndex: _calculateSelectedIndex(context),
          onTap: (value) => onTap(value, context),
          items: [
            _buildBottomNavigationBarItem(index: 0),
            _buildBottomNavigationBarItem(index: 1),
            _buildBottomNavigationBarItem(index: 2),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({required int index}) {
    return BottomNavigationBarItem(
      icon: outlinedIcon[index],
      activeIcon: filledIcons[index],
      label: CommonDataConstants.bottomNavigation[index],
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouterState router = GoRouterState.of(context);
    final String location = router.matchedLocation;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/complaints')) {
      return 1;
    }
    if (location.startsWith('/employee')) {
      return 2;
    }
    if (location.startsWith('/notification')) {
      return 2;
    }
    return 0;
  }

  void onTap(int value, BuildContext context) {
    switch (value) {
      case 0:
        return context.go('/home');
      case 1:
        return context.go('/complaints');
      case 2:
        return context.go('/Employee');
      default:
        return context.go('/Notification');
    }
  }
}
