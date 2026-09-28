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
  static const double _desktopBreakpoint = 1000;
  static const double _tabletBreakpoint = 600;
  static const double _desktopFormMaxWidth = 520;
  static const double _tabletFormMaxWidth = 620;

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
            if (constraints.maxWidth >= _desktopBreakpoint) {
              return _buildDesktopLayout(
                context,
                theme,
                textColor,
                constraints,
              );
            }

            return _buildCompactLayout(
              context,
              theme,
              textColor,
              constraints,
            );
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    ThemeData theme,
    Color textColor,
    BoxConstraints constraints,
  ) {
    final isDark = theme.brightness == Brightness.dark;
    final introBackground =
        isDark ? const Color(0xFF191918) : AppTheme.lightText;
    final introForeground =
        isDark ? AppTheme.darkText : AppTheme.lightBackground;

    return Row(
      key: const Key('desktopLoginLayout'),
      children: [
        Expanded(
          flex: 5,
          child: Container(
            key: const Key('desktopIntro'),
            color: introBackground,
            padding: const EdgeInsets.symmetric(
              horizontal: 64,
              vertical: 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TEAM 17',
                  style: TextStyle(
                    color: AppTheme.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.4,
                  ),
                ),
                const Spacer(),
                Text(
                  'CAMPUS\nCLUB',
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: introForeground,
                    fontWeight: FontWeight.w800,
                    height: 0.92,
                    letterSpacing: -2.4,
                    fontSize: 72,
                  ),
                ),
                const SizedBox(height: 28),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Text(
                    'Discover clubs. Find events. Stay connected to campus.',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: introForeground.withValues(alpha: 0.72),
                      fontWeight: FontWeight.w400,
                      height: 1.35,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'TIRUMALA ENGINEERING COLLEGE',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: introForeground.withValues(alpha: 0.42),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(
              horizontal: 56,
              vertical: 48,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 96,
              ),
              child: Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  key: const Key('desktopLoginForm'),
                  constraints: const BoxConstraints(
                    maxWidth: _desktopFormMaxWidth,
                  ),
                  child: _buildLoginForm(
                    context,
                    theme,
                    textColor,
                    generousHeader: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactLayout(
    BuildContext context,
    ThemeData theme,
    Color textColor,
    BoxConstraints constraints,
  ) {
    final isTablet = constraints.maxWidth >= _tabletBreakpoint;
    final horizontalPadding = isTablet ? 48.0 : 28.0;
    final topPadding = isTablet ? 56.0 : 44.0;
    final maxWidth = isTablet ? _tabletFormMaxWidth : double.infinity;
    final minimumContentHeight =
        constraints.maxHeight > 72 ? constraints.maxHeight - 72 : 0.0;

    return SingleChildScrollView(
      key: const Key('compactLoginLayout'),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        topPadding,
        horizontalPadding,
        28,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: minimumContentHeight,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: _buildLoginForm(
              context,
              theme,
              textColor,
              generousHeader: isTablet,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(
    BuildContext context,
    ThemeData theme,
    Color textColor, {
    required bool generousHeader,
  }) {
    return Column(
      key: const Key('loginForm'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
        SizedBox(height: generousHeader ? 18 : 14),
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
        SizedBox(height: generousHeader ? 48 : 42),
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
    );
  }
}
