import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jcc_admin/config/router.dart';
import 'package:jcc_admin/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.getTheme(),
      routerConfig: router,

    );
  }
}
