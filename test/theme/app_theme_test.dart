import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:team17_flutter_project/auth/auth_service.dart';
import 'package:team17_flutter_project/main.dart';
import 'package:team17_flutter_project/theme/app_theme.dart';

void main() {
  test('theme tokens match the approved light and dark direction', () {
    expect(
      AppTheme.light.scaffoldBackgroundColor,
      const Color(0xFFF6F6F2),
    );
    expect(
      AppTheme.dark.scaffoldBackgroundColor,
      const Color(0xFF101010),
    );
    expect(AppTheme.light.colorScheme.primary, AppTheme.accent);
    expect(AppTheme.dark.colorScheme.primary, AppTheme.accent);
  });

  testWidgets('app follows the system theme', (tester) async {
    await tester.pumpWidget(
      MyApp(authService: AuthService.unavailable()),
    );

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(app.themeMode, ThemeMode.system);
  });
}
