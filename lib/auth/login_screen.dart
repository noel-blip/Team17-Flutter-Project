import 'package:flutter/material.dart';

import '../home/placeholder_home_screen.dart';
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
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _obscurePassword = true;
  bool _buttonPressed = false;
  bool _verified = false;
  String? _usernameError;
  String? _passwordError;
  String? _generalError;

  @override
  void initState() {
    super.initState();
    _usernameFocus.addListener(_refreshFocusState);
    _passwordFocus.addListener(_refreshFocusState);
  }

  void _refreshFocusState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _usernameFocus
      ..removeListener(_refreshFocusState)
      ..dispose();
    _passwordFocus
      ..removeListener(_refreshFocusState)
      ..dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_verified) {
      return;
    }

    FocusScope.of(context).unfocus();

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    String? usernameError;
    String? passwordError;

    if (username.isEmpty) {
      usernameError = 'Enter your student ID or email';
    }
    if (password.isEmpty) {
      passwordError = 'Enter your password';
    }

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
        _generalError = 'Login is temporarily unavailable';
      });
      return;
    }

    if (!widget.authService.authenticate(username, password)) {
      setState(() {
        _passwordError = "Credentials don't match";
      });
      return;
    }

    setState(() {
      _verified = true;
      _usernameError = null;
      _passwordError = null;
      _generalError = null;
    });

    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (!mounted) {
      return;
    }

    await Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 220),
        reverseTransitionDuration: const Duration(milliseconds: 180),
        pageBuilder: (context, animation, secondaryAnimation) {
          return const PlaceholderHomeScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          );
        },
      ),
    );
  }

  InputBorder _underline(
    BuildContext context, {
    required bool focused,
    required bool error,
  }) {
    final theme = Theme.of(context);
    final color = error
        ? theme.colorScheme.error
        : focused
            ? theme.colorScheme.primary
            : theme.dividerColor;

    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: focused || error ? 1.8 : 1.0,
      ),
    );
  }

  Widget _fieldLabel(String label) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: theme.textTheme.labelMedium,
    );
  }

  Widget _usernameField() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel('Student ID / Email'),
        const SizedBox(height: 7),
        TextField(
          key: const Key('usernameField'),
          controller: _usernameController,
          focusNode: _usernameFocus,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          autofillHints: const [
            AutofillHints.username,
            AutofillHints.email,
          ],
          cursorColor: theme.colorScheme.primary,
          style: theme.textTheme.bodyLarge,
          onSubmitted: (_) => _passwordFocus.requestFocus(),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(bottom: 10),
            errorText: _usernameError,
            errorMaxLines: 2,
            border: _underline(
              context,
              focused: false,
              error: _usernameError != null,
            ),
            enabledBorder: _underline(
              context,
              focused: false,
              error: _usernameError != null,
            ),
            focusedBorder: _underline(
              context,
              focused: true,
              error: _usernameError != null,
            ),
            errorBorder: _underline(
              context,
              focused: false,
              error: true,
            ),
            focusedErrorBorder: _underline(
              context,
              focused: true,
              error: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordField() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel('Password'),
        const SizedBox(height: 7),
        TextField(
          key: const Key('passwordField'),
          controller: _passwordController,
          focusNode: _passwordFocus,
          obscureText: _obscurePassword,
          enableSuggestions: false,
          autocorrect: false,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.password],
          cursorColor: theme.colorScheme.primary,
          style: theme.textTheme.bodyLarge,
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(bottom: 10),
            errorText: _passwordError,
            errorMaxLines: 2,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 56,
              minHeight: 36,
            ),
            suffixIcon: TextButton(
              key: const Key('passwordVisibilityButton'),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              style: TextButton.styleFrom(
                minimumSize: const Size(56, 36),
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(_obscurePassword ? 'SHOW' : 'HIDE'),
            ),
            border: _underline(
              context,
              focused: false,
              error: _passwordError != null,
            ),
            enabledBorder: _underline(
              context,
              focused: false,
              error: _passwordError != null,
            ),
            focusedBorder: _underline(
              context,
              focused: true,
              error: _passwordError != null,
            ),
            errorBorder: _underline(
              context,
              focused: false,
              error: true,
            ),
            focusedErrorBorder: _underline(
              context,
              focused: true,
              error: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _continueButton() {
    return Listener(
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
        curve: Curves.easeOut,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            key: const Key('continueButton'),
            onPressed: _verified ? null : _submit,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 160),
              child: Text(
                _verified ? 'Verified ✓' : 'Continue',
                key: ValueKey<bool>(_verified),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(28, 42, 28, 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 74,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACCESS',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Sign in',
                      style: theme.textTheme.displaySmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Use your student ID or email to continue.',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 52),
                    _usernameField(),
                    const SizedBox(height: 30),
                    _passwordField(),
                    const SizedBox(height: 18),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 160),
                      child: _generalError == null
                          ? const SizedBox.shrink()
                          : Padding(
                              key: ValueKey<String>(_generalError!),
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                _generalError!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 18),
                    _continueButton(),
                    const SizedBox(height: 22),
                    Center(
                      child: Text(
                        'Demo access',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                        ),
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
