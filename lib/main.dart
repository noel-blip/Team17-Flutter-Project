import 'package:flutter/material.dart';

import 'auth/auth_service.dart';
import 'auth/login_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = await AuthService.loadFromAsset(
    'assets/credentials.json',
  );

  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authService});

  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team 17',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: LoginScreen(authService: authService),
    );
  }
}
