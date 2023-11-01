import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/constants/string_constants.dart';
import 'package:jcc_admin/generated/assets.dart';

class AppBottomNavigationBar extends StatelessWidget {
  AppBottomNavigationBar({super.key});

  final outlinedIcon = [
    SvgPicture.asset(
      Assets.iconsHome,
      colorFilter: const ColorFilter.mode(AppColors.black60, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      Assets.iconsComplaints,
      colorFilter: const ColorFilter.mode(AppColors.black60, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      Assets.iconsNotifications,
      colorFilter: const ColorFilter.mode(AppColors.black60, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      Assets.iconsEmployee,
      colorFilter: const ColorFilter.mode(AppColors.black60, BlendMode.srcIn),
    ),
  ];

  final filledIcons = [
    SvgPicture.asset(
      Assets.iconsHome,
      colorFilter: const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      Assets.iconsComplaints,
      colorFilter: const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      Assets.iconsEmployee,
      colorFilter: const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
    ),
    SvgPicture.asset(
      Assets.iconsNotifications,
      colorFilter: const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
          currentIndex: _calculateSelectedIndex(context),
          onTap: (value) => onTap(value, context),
          items: [
            _buildBottomNavigationBarItem(index: 0),
            _buildBottomNavigationBarItem(index: 1),
            _buildBottomNavigationBarItem(index: 2),
            _buildBottomNavigationBarItem(index: 3),
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
    if (location.startsWith('/complaint_screen')) {
      return 1;
    }
    if (location.startsWith('/employee_screen')) {
      return 2;
    }
    if (location.startsWith('/notifications')) {
      return 3;
    }
    return 0;
  }

  void onTap(int value, BuildContext context) {
    switch (value) {
      case 0:
        return context.go('/home');
      case 1:
        return context.go('/complaint_screen');
      case 2:
        return context.go('/employee_screen');
      case 3:
        return context.go('/notifications');
      default:
        return context.go('/home');
    }
  }
}
