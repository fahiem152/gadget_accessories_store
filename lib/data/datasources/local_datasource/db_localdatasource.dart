import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DBLocalDatasource {
  static late SharedPreferences db;
  static init() async {
    db = await SharedPreferences.getInstance();
  }

  static setLoginGoogle(bool isGoogle) {
    db.setBool('isGoogle', isGoogle);
  }

  static bool? getLoginGoogle() {
    final isGoogle = db.getBool('isGoogle');
    if (isGoogle != null) {
      return isGoogle;
    } else {
      return false;
    }
  }
}
