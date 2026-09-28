import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:team17_flutter_project/auth/auth_service.dart';
import 'package:team17_flutter_project/main.dart';
import 'package:team17_flutter_project/theme/app_theme.dart';

void main() {
  test('light and dark themes use the locked visual tokens', () {
    expect(AppTheme.light.scaffoldBackgroundColor, const Color(0xFFF6F6F2));
    expect(AppTheme.dark.scaffoldBackgroundColor, const Color(0xFF101010));
    expect(AppTheme.light.colorScheme.primary, const Color(0xFFD63A2F));
    expect(AppTheme.dark.colorScheme.primary, const Color(0xFFD63A2F));
  });

  testWidgets('app follows the system theme', (tester) async {
    final authService = AuthService.fromJson(
      '[{"username":"24NE1A42E7","password":"123456"}]',
    );

    await tester.pumpWidget(MyApp(authService: authService));

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.system);
  });
}
