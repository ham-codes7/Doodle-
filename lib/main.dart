import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/role_selection_screen.dart';
import 'screens/mother_dashboard_screen.dart';
import 'screens/partner_dashboard_screen.dart';
import 'theme/app_theme.dart';
import 'providers/onboarding_provider.dart';
import 'providers/dashboard_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final OnboardingProvider _onboardingProvider = OnboardingProvider();
  final DashboardProvider _dashboardProvider = DashboardProvider();
  bool _isChecking = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final bool loggedIn = await _onboardingProvider.checkLoginState();
    if (mounted) {
      setState(() {
        _isLoggedIn = loggedIn;
        _isChecking = false;
      });
    }
  }

  Widget _getHomeScreen() {
    if (_isChecking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!_isLoggedIn) {
      return const RoleSelectionScreen();
    }

    final role = _onboardingProvider.userRole?.toLowerCase();
    if (role == 'partner') {
      return const PartnerDashboardScreen();
    }
    return const MotherDashboardScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _onboardingProvider),
        ChangeNotifierProvider.value(value: _dashboardProvider),
      ],
      child: MaterialApp(
        title: 'Phase 1 App',
        theme: AppTheme.themeData,
        home: _getHomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
