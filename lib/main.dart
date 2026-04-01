import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/role_selection_screen.dart';
import 'screens/mother_dashboard_screen.dart';
import 'theme/app_theme.dart';
import 'providers/onboarding_provider.dart';
import 'providers/dashboard_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: MaterialApp(
        title: 'Phase 1 App',
        theme: AppTheme.themeData,
        home: isLoggedIn ? const MotherDashboardScreen() : const RoleSelectionScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
