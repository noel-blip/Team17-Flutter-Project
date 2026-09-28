import 'dart:convert';

import 'package:flutter/services.dart';

class Credential {
  const Credential({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class AuthService {
  AuthService._(
    List<Credential> credentials, {
    this.errorMessage,
  }) : _credentials = List<Credential>.unmodifiable(credentials);

  final List<Credential> _credentials;
  final String? errorMessage;

  List<Credential> get credentials => _credentials;

  bool get isAvailable => errorMessage == null && _credentials.isNotEmpty;

  factory AuthService.fromJson(String source) {
    try {
      final decoded = jsonDecode(source);
      if (decoded is! List) {
        return AuthService._(
          const <Credential>[],
          errorMessage: 'Credential data must be a JSON list.',
        );
      }

      final credentials = <Credential>[];
      for (final entry in decoded) {
        if (entry is! Map) {
          continue;
        }

        final username = entry['username'];
        final password = entry['password'];
        if (username is String &&
            username.trim().isNotEmpty &&
            password is String &&
            password.isNotEmpty) {
          credentials.add(
            Credential(
              username: username.trim(),
              password: password,
            ),
          );
        }
      }

      if (credentials.isEmpty) {
        return AuthService._(
          const <Credential>[],
          errorMessage: 'No valid credentials were found.',
        );
      }

      return AuthService._(credentials);
    } on Object {
      return AuthService._(
        const <Credential>[],
        errorMessage: 'Credential data could not be read.',
      );
    }
  }

  static Future<AuthService> loadFromAsset([
    String assetPath = 'assets/credentials.json',
  ]) async {
    try {
      final source = await rootBundle.loadString(assetPath);
      return AuthService.fromJson(source);
    } on Object {
      return AuthService._(
        const <Credential>[],
        errorMessage: 'Credential data could not be loaded.',
      );
    }
  }

  bool authenticate(String username, String password) {
    if (!isAvailable) {
      return false;
    }

    final normalizedUsername = username.trim();
    return _credentials.any(
      (credential) =>
          credential.username == normalizedUsername &&
          credential.password == password,
    );
  }
}
