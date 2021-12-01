import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSecretValues {
  AppSecretValues({
    required this.baseUrl,
  });

  final String baseUrl;
}

class AppSecretConfig {
  AppSecretValues values;
  final SharedPreferences preferences;
  static AppSecretConfig? _instance;

  factory AppSecretConfig(
      {required AppSecretValues values,
      required SharedPreferences preferences}) {
    _instance ??= AppSecretConfig._internal(values, preferences);
    return _instance!;
  }

  AppSecretConfig._internal(this.values, this.preferences);

  static AppSecretConfig get instance {
    return _instance!;
  }
}
