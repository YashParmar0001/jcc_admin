import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_color.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key, required this.child}) : super(key: key);

  final Widget child;

  final outlinedIcon = [
    SvgPicture.asset('assets/icons/home.svg',
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
    SvgPicture.asset('assets/icons/complaints.svg',
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
    SvgPicture.asset('assets/icons/employee.svg',
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
    SvgPicture.asset('assets/icons/notifications.svg',
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
  ];

  final filledIcons = [
    SvgPicture.asset('assets/icons/home.svg',
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
    SvgPicture.asset('assets/icons/complaints.svg',
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
    SvgPicture.asset('assets/icons/employee.svg',
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
    SvgPicture.asset('assets/icons/notifications.svg',
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                spreadRadius: 0.5,
                offset: const Offset(0, 0))
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
              _buildBottomNavigationBarItem(
                index: 0,
                label: 'Home',
              ),
              _buildBottomNavigationBarItem(
                index: 1,
                label: 'Complaints',
              ),
              _buildBottomNavigationBarItem(
                index: 2,
                label: 'Employee',
              ),
              _buildBottomNavigationBarItem(
                index: 3,
                label: 'Notification',
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({required int index,required String label}){
    return BottomNavigationBarItem(
      icon: outlinedIcon[index],
      activeIcon: filledIcons[index],
      label: label,
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouterState router = GoRouterState.of(context);
    final String location = router.matchedLocation;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/complaint')) {
      return 1;
    }
    if (location.startsWith('/employee')) {
      return 2;
    }
    if (location.startsWith('/notification')) {
      return 3;
    }
    return 0;
  }

  void onTap(int value, BuildContext context) {
    switch (value) {
      case 0:
        return context.go('/home');
      case 1:
        return context.go('/complaint');
      case 2:
        return context.go('/employee');
      default:
        return context.go('/notification');
    }
  }
}
