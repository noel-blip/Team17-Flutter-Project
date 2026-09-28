import 'package:flutter/material.dart';

import '../home/placeholder_home_screen.dart';
import '../theme/app_theme.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.authService,
  });

  final AuthService authService;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _buttonPressed = false;
  bool _verified = false;

  String? _usernameError;
  String? _passwordError;
  String? _generalError;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_verified) {
      return;
    }

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    final usernameError =
        username.isEmpty ? 'Enter your student ID or email' : null;
    final passwordError =
        password.isEmpty ? 'Enter your password' : null;

    setState(() {
      _usernameError = usernameError;
      _passwordError = passwordError;
      _generalError = null;
    });

    if (usernameError != null || passwordError != null) {
      return;
    }

    if (!widget.authService.isAvailable) {
      setState(() {
        _generalError = 'Login data is unavailable';
      });
      return;
    }

    if (!widget.authService.authenticate(username, password)) {
      setState(() {
        _generalError = "Credentials don't match";
      });
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _verified = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 450));

    if (!mounted) {
      return;
    }

    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const PlaceholderHomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.brightness == Brightness.dark
        ? AppTheme.darkText
        : AppTheme.lightText;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final minimumContentHeight =
                constraints.maxHeight > 72 ? constraints.maxHeight - 72 : 0.0;

            return SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(28, 44, 28, 28),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: minimumContentHeight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ACCESS',
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Sign in',
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1.1,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Use your student ID or email to continue.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: textColor.withValues(alpha: 0.60),
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 42),
                    TextField(
                      key: const Key('usernameField'),
                      controller: _usernameController,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [
                        AutofillHints.username,
                        AutofillHints.email,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Student ID / Email',
                        errorText: _usernameError,
                      ),
                    ),
                    const SizedBox(height: 22),
                    TextField(
                      key: const Key('passwordField'),
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: _passwordError,
                        suffixIcon: TextButton(
                          key: const Key('passwordVisibilityButton'),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Text(
                            _passwordVisible ? 'HIDE' : 'SHOW',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 160),
                      alignment: Alignment.topLeft,
                      child: _generalError == null
                          ? const SizedBox(height: 28)
                          : Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Text(
                                _generalError!,
                                key: const Key('generalError'),
                                style: const TextStyle(
                                  color: AppTheme.accent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                    ),
                    Listener(
                      onPointerDown: (_) {
                        if (!_verified) {
                          setState(() => _buttonPressed = true);
                        }
                      },
                      onPointerUp: (_) {
                        if (_buttonPressed) {
                          setState(() => _buttonPressed = false);
                        }
                      },
                      onPointerCancel: (_) {
                        if (_buttonPressed) {
                          setState(() => _buttonPressed = false);
                        }
                      },
                      child: AnimatedScale(
                        scale: _buttonPressed ? 0.985 : 1,
                        duration: const Duration(milliseconds: 90),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            key: const Key('continueButton'),
                            onPressed: _verified ? null : _submit,
                            child: Text(
                              _verified ? 'Verified ✓' : 'Continue',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: Text(
                        'Demo access · DEMO / TEAM17',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: textColor.withValues(alpha: 0.48),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
