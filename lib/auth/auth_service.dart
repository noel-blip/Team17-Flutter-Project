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
  AuthService._({
    required List<Credential> credentials,
    required this.isAvailable,
  }) : _credentials = List.unmodifiable(credentials);

  factory AuthService.fromJson(String source) {
    try {
      final decoded = jsonDecode(source);

      if (decoded is! List) {
        return AuthService.unavailable();
      }

      final credentials = <Credential>[];

      for (final item in decoded) {
        if (item is! Map<String, dynamic>) {
          return AuthService.unavailable();
        }

        final username = item['username'];
        final password = item['password'];

        if (username is! String ||
            password is! String ||
            username.trim().isEmpty ||
            password.isEmpty) {
          return AuthService.unavailable();
        }

        credentials.add(
          Credential(
            username: username.trim(),
            password: password,
          ),
        );
      }

      if (credentials.isEmpty) {
        return AuthService.unavailable();
      }

      return AuthService._(
        credentials: credentials,
        isAvailable: true,
      );
    } catch (_) {
      return AuthService.unavailable();
    }
  }

  factory AuthService.unavailable() {
    return AuthService._(
      credentials: const [],
      isAvailable: false,
    );
  }

  static Future<AuthService> loadFromAsset(String assetPath) async {
    try {
      final source = await rootBundle.loadString(assetPath);
      return AuthService.fromJson(source);
    } catch (_) {
      return AuthService.unavailable();
    }
  }

  final List<Credential> _credentials;
  final bool isAvailable;

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
