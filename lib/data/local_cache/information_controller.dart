import 'package:shared_preferences/shared_preferences.dart';

class InformationController {
  List<String> list = [];

  /// set
  Future<void> setData(List<String> newList) async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('info', newList);
    list = newList;

  }

  /// get
  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    list = prefs.getStringList('info') ?? [];
  }

  Future<void> removeAllData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }



}
