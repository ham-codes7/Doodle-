import 'package:flutter/material.dart';
import 'screens/role_selection_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phase 1 App',
      theme: AppTheme.themeData,
      home: const RoleSelectionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
