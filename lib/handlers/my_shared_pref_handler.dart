// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferenceHandler {
  Future<dynamic> getValue(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      return sharedPreferences.get(key) as dynamic;
    } catch (e) {
      debugPrint("The key was not found in SharedPreferences");
      debugPrint("Error: $e");
    }
    return null;
  }

  /// Sets the [key] with the [value]
  /// Only works if value is of type: `bool`, `int`, `double`, `String`, `List<String>`
  void setValue(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is List<String>) {
      sharedPreferences.setStringList(key, value);
    } else {
      debugPrint("The type must be 'bool, int, double, String, List<String>'");
    }
  }
}
