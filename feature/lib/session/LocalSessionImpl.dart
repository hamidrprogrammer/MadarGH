
// import 'package:shared_preferences/shared_preferences.dart';

import 'LocalSessionRepository.dart';

class LocalSessionImpl extends LocalSessionRepository {
  // SharedPreferences? _prefs;

  Future getPrefs() async {
    // _prefs ??= await SharedPreferences.getInstance();
    return "";
  }

  @override
  Future<String> getData(String key) async {
    return (await getPrefs()).getString(key) ?? '';
  }

  @override
  void insertData(Map<String, String> data) async {
    var pref = (await getPrefs());
    for (var element in data.entries) {
      pref.setString(element.key, element.value);
    }
  }

  @override
  Future<bool> clearSession() async{
    // await _prefs?.clear();
    return true;
  }
}