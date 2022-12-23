import 'package:batch_student_starter/app/theme.dart';
import 'package:batch_student_starter/screen/dashboard.dart';
import 'package:flutter/material.dart';

import '../screen/login.dart';
import '../screen/register.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Batch',
      debugShowCheckedModeBanner: false,
      theme: getApplicationThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/registerScreen': (context) => const RegisterScreen(),
        '/dashboardScreen': (context) => const DashboardScreen(),
      },
    );
  }
}
