import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  String? _authToken;

  String? get authToken => _authToken;

  Future<void> saveAuthToken(String authToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', authToken);
    _authToken = authToken;
    notifyListeners(); // Değişikliği dinleyen widgetlara bildir
  }

  Future<String?> fetchAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('authToken');
    notifyListeners();
    return _authToken; // _authToken'ı geri döndür
  }


  Future<void> deleteAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    _authToken = null;
    notifyListeners(); // Değişikliği dinleyen widgetlara bildir
  }
}
