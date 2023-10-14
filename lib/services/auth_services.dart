import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String? _authToken;

  String? get authToken => _authToken;

  Future<void> saveAuthToken(String authToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', authToken);
    _authToken = authToken;
  }

  Future<String?> fetchAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('authToken');
    return _authToken; // _authToken'ı geri döndür
  }


  Future<void> deleteAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    _authToken = null;
  }
}
