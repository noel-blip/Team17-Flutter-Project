import 'package:flutter_test/flutter_test.dart';
import 'package:team17_flutter_project/auth/auth_service.dart';

void main() {
  const validJson = '''
[
  {
    "id": "DEMO",
    "value": "TEAM17"
  }
]
''';

  test('valid JSON loads and authenticates the demo account', () {
    final service = AuthService.fromJson(validJson);

    expect(service.isAvailable, isTrue);
    expect(service.authenticate('DEMO', 'TEAM17'), isTrue);
  });

  test('wrong password is rejected', () {
    final service = AuthService.fromJson(validJson);

    expect(service.authenticate('DEMO', 'wrong'), isFalse);
  });

  test('unknown user is rejected', () {
    final service = AuthService.fromJson(validJson);

    expect(service.authenticate('UNKNOWN', 'TEAM17'), isFalse);
  });

  test('malformed JSON fails safely', () {
    final service = AuthService.fromJson('{not-json');

    expect(service.isAvailable, isFalse);
    expect(service.authenticate('DEMO', 'TEAM17'), isFalse);
  });

  test('empty data fails safely', () {
    final service = AuthService.fromJson('[]');

    expect(service.isAvailable, isFalse);
  });
}
