import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    Future.delayed(const Duration(milliseconds: 500), () {
      context.go('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
