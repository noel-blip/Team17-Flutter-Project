import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:team17_flutter_project/auth/auth_service.dart';
import 'package:team17_flutter_project/auth/login_screen.dart';
import 'package:team17_flutter_project/theme/app_theme.dart';

AuthService _demoAuth() => AuthService.fromJson(
      '[{"username":"24NE1A42E7","password":"123456"}]',
    );

Widget _app({AuthService? authService}) {
  return MaterialApp(
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    home: LoginScreen(authService: authService ?? _demoAuth()),
  );
}

void main() {
  testWidgets('renders the locked A plus tiny B login content', (tester) async {
    await tester.pumpWidget(_app());

    expect(find.text('ACCESS'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(
      find.text('Use your student ID or email to continue.'),
      findsOneWidget,
    );
    expect(find.text('Student ID / Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('SHOW'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    expect(find.text('Demo access'), findsOneWidget);
  });

  testWidgets('password starts hidden and SHOW toggles to HIDE', (tester) async {
    await tester.pumpWidget(_app());

    final fieldBefore = tester.widget<TextField>(
      find.byKey(const Key('passwordField')),
    );
    expect(fieldBefore.obscureText, isTrue);

    await tester.tap(find.byKey(const Key('passwordVisibilityButton')));
    await tester.pump();

    final fieldAfter = tester.widget<TextField>(
      find.byKey(const Key('passwordField')),
    );
    expect(fieldAfter.obscureText, isFalse);
    expect(find.text('HIDE'), findsOneWidget);
  });

  testWidgets('empty submit shows exact field validation copy', (tester) async {
    await tester.pumpWidget(_app());

    await tester.tap(find.byKey(const Key('continueButton')));
    await tester.pump();

    expect(find.text('Enter your student ID or email'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
  });

  testWidgets('wrong credentials stay on login and show mismatch', (tester) async {
    await tester.pumpWidget(_app());

    await tester.enterText(
      find.byKey(const Key('usernameField')),
      '24NE1A42E7',
    );
    await tester.enterText(
      find.byKey(const Key('passwordField')),
      'wrong',
    );
    await tester.tap(find.byKey(const Key('continueButton')));
    await tester.pump();

    expect(find.text("Credentials don't match"), findsOneWidget);
    expect(find.text('Authentication successful'), findsNothing);
  });

  testWidgets('unavailable credential source fails safely', (tester) async {
    await tester.pumpWidget(
      _app(authService: AuthService.fromJson('{broken')),
    );

    await tester.enterText(
      find.byKey(const Key('usernameField')),
      '24NE1A42E7',
    );
    await tester.enterText(
      find.byKey(const Key('passwordField')),
      '123456',
    );
    await tester.tap(find.byKey(const Key('continueButton')));
    await tester.pump();

    expect(find.text('Login is temporarily unavailable'), findsOneWidget);
    expect(find.text('Authentication successful'), findsNothing);
  });

  testWidgets('valid credentials show Verified then navigate', (tester) async {
    await tester.pumpWidget(_app());

    await tester.enterText(
      find.byKey(const Key('usernameField')),
      '24NE1A42E7',
    );
    await tester.enterText(
      find.byKey(const Key('passwordField')),
      '123456',
    );
    await tester.tap(find.byKey(const Key('continueButton')));
    await tester.pump();

    expect(find.text('Verified ✓'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    expect(find.text('Authentication successful'), findsOneWidget);
  });

  testWidgets('small-height layout remains scrollable without overflow', (
    tester,
  ) async {
    await tester.pumpWidget(
      Center(
        child: SizedBox(
          width: 360,
          height: 420,
          child: _app(),
        ),
      ),
    );

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byKey(const Key('passwordField')));
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
