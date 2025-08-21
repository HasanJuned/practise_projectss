import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class InformationController {
  List<Map<String, String>> list = [];

  /// Save data
  Future<void> setData(List<Map<String, String>> newList) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(newList);
    await prefs.setString('info', jsonString);
    list = newList;
  }

  /// Load data
  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('info');
    if (jsonString != null) {
      List decoded = jsonDecode(jsonString);
      list = decoded.map((e) => Map<String, String>.from(e)).toList();
    } else {
      list = [];
    }
  }

  Future<void> removeAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }



}
