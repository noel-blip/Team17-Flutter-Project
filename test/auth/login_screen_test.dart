import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:team17_flutter_project/auth/auth_service.dart';
import 'package:team17_flutter_project/auth/login_screen.dart';

AuthService _service() {
  return AuthService.fromJson(
    '''
[
  {
    "id": "DEMO",
    "value": "TEAM17"
  }
]
''',
  );
}

Widget _app(AuthService service) {
  return MaterialApp(
    home: LoginScreen(authService: service),
  );
}

void main() {
  testWidgets('renders the approved login content', (tester) async {
    await tester.pumpWidget(_app(_service()));

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
    expect(find.textContaining('Demo access'), findsOneWidget);
  });

  testWidgets('password starts hidden and SHOW toggles to HIDE', (tester) async {
    await tester.pumpWidget(_app(_service()));

    TextField passwordField = tester.widget<TextField>(
      find.byKey(const Key('passwordField')),
    );
    expect(passwordField.obscureText, isTrue);

    await tester.tap(find.byKey(const Key('passwordVisibilityButton')));
    await tester.pump();

    passwordField = tester.widget<TextField>(
      find.byKey(const Key('passwordField')),
    );
    expect(passwordField.obscureText, isFalse);
    expect(find.text('HIDE'), findsOneWidget);
  });

  testWidgets('empty fields show the approved validation copy', (tester) async {
    await tester.pumpWidget(_app(_service()));

    await tester.tap(find.byKey(const Key('continueButton')));
    await tester.pump();

    expect(
      find.text('Enter your student ID or email'),
      findsOneWidget,
    );
    expect(find.text('Enter your password'), findsOneWidget);
  });

  testWidgets('wrong credentials stay on login with feedback', (tester) async {
    await tester.pumpWidget(_app(_service()));

    await tester.enterText(
      find.byKey(const Key('usernameField')),
      'DEMO',
    );
    await tester.enterText(
      find.byKey(const Key('passwordField')),
      'wrong',
    );
    await tester.tap(find.byKey(const Key('continueButton')));
    await tester.pump();

    expect(find.text("Credentials don't match"), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('unavailable login data fails safely', (tester) async {
    await tester.pumpWidget(_app(AuthService.unavailable()));

    await tester.enterText(
      find.byKey(const Key('usernameField')),
      'DEMO',
    );
    await tester.enterText(
      find.byKey(const Key('passwordField')),
      'TEAM17',
    );
    await tester.tap(find.byKey(const Key('continueButton')));
    await tester.pump();

    expect(find.text('Login data is unavailable'), findsOneWidget);
  });

  testWidgets('valid credentials verify and navigate', (tester) async {
    await tester.pumpWidget(_app(_service()));

    await tester.enterText(
      find.byKey(const Key('usernameField')),
      'DEMO',
    );
    await tester.enterText(
      find.byKey(const Key('passwordField')),
      'TEAM17',
    );
    await tester.tap(find.byKey(const Key('continueButton')));
    await tester.pump();

    expect(find.text('Verified ✓'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text("You're in."), findsOneWidget);
    expect(
      find.textContaining('Authentication verified'),
      findsOneWidget,
    );
  });

  testWidgets('small phone height remains scrollable without overflow', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 500));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(_app(_service()));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });
}
