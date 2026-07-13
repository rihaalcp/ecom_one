import 'package:flutter/material.dart';
import 'frondend/theme/app_theme.dart';
import 'frondend/clients/screens/home_screen.dart';

void main() {
  runApp(const LuminaApp());
}

class LuminaApp extends StatelessWidget {
  const LuminaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumina - Premium eCommerce',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // Home is the app's entry point. Cart & Profile (reached via the
      // AppBar icons or bottom nav) route to Login/Register first when
      // the user isn't authenticated yet.
      home: const HomeScreen(),
    );
  }
}
