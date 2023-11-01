import 'package:flutter/material.dart';
import 'package:jcc_admin/config/router.dart';
import 'package:jcc_admin/firebase_options.dart';
import 'package:jcc_admin/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
