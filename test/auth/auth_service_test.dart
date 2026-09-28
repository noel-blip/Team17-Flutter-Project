import 'package:flutter_test/flutter_test.dart';
import 'package:team17_flutter_project/auth/auth_service.dart';

void main() {
  const demoJson = '''
[
  {"username":"24NE1A42E7","password":"123456"},
  {"username":"student@example.com","password":"secret"}
]
''';

  test('valid JSON parses credentials and authenticates matching user', () {
    final service = AuthService.fromJson(demoJson);

    expect(service.isAvailable, isTrue);
    expect(service.credentials, hasLength(2));
    expect(service.authenticate('24NE1A42E7', '123456'), isTrue);
  });

  test('wrong password is rejected', () {
    final service = AuthService.fromJson(demoJson);

    expect(service.authenticate('24NE1A42E7', 'wrong'), isFalse);
  });

  test('unknown user is rejected', () {
    final service = AuthService.fromJson(demoJson);

    expect(service.authenticate('UNKNOWN', '123456'), isFalse);
  });

  test('username whitespace is ignored but password stays exact', () {
    final service = AuthService.fromJson(demoJson);

    expect(service.authenticate(' 24NE1A42E7 ', '123456'), isTrue);
    expect(service.authenticate('24NE1A42E7', ' 123456 '), isFalse);
  });

  test('malformed JSON fails safely without throwing through the app', () {
    final service = AuthService.fromJson('{bad json');

    expect(service.isAvailable, isFalse);
    expect(service.credentials, isEmpty);
    expect(service.authenticate('24NE1A42E7', '123456'), isFalse);
    expect(service.errorMessage, isNotNull);
  });

  test('JSON with no valid credentials is unavailable', () {
    final service = AuthService.fromJson('[{"username":"missingPassword"}]');

    expect(service.isAvailable, isFalse);
    expect(service.credentials, isEmpty);
  });
}
