import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();

  AuthSession? _session;
  bool _isBootstrapping = true;

  @override
  void initState() {
    super.initState();
    _bootstrapSession();
  }

  Future<void> _bootstrapSession() async {
    final restoredSession = await _authService.restoreSession();
    if (!mounted) {
      return;
    }
    setState(() {
      _session = restoredSession;
      _isBootstrapping = false;
    });
  }

  void _handleAuthenticated(AuthSession session) {
    setState(() {
      _session = session;
    });
  }

  Future<void> _handleLogout() async {
    await _authService.logout();
    if (!mounted) {
      return;
    }
    setState(() {
      _session = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    );

    Widget home;
    if (_isBootstrapping) {
      home = const _SplashScreen();
    } else if (_session == null) {
      home = LoginScreen(onAuthenticated: _handleAuthenticated);
    } else {
      home = HomeScreen(session: _session!, onLogout: _handleLogout);
    }

    return MaterialApp(title: 'GC App', theme: theme, home: home);
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
