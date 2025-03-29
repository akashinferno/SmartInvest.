import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_invest_1/auth/wrapper.dart';
import 'package:smart_invest_1/pages/splash_screen.dart';
import 'utils/theme.dart';
import 'widgets/bottom_navbar.dart';
// import 'pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SmartInvestApp());
}

class SmartInvestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: SplashScreen(),
    );
  }
}
