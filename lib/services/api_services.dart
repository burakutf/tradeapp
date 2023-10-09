import 'package:dio/dio.dart';
import 'package:tradeapp/models/crypto_data.dart';
import 'package:tradeapp/models/profile.dart';
import 'package:tradeapp/services/auth_services.dart';

class ApiService {
  late Dio _dio;

  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: "http://127.0.0.1:8000/api",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    );
    _dio = Dio(options);
  }
  Future<bool> login({String? email, String? password}) async {
    try {
      final Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };

      Response response = await _dio.post(
        "/login/",
        data: data,
      );

      // Burada API'den dönen yanıtı kontrol edebilirsiniz
      if (response.statusCode == 200) {
        AuthService().saveAuthToken(response.data['token']);
        return true; // Giriş başarılı
      } else {
        return false; // Giriş başarısız
      }
    } catch (e) {
      return false; // Hata durumunda giriş başarısız
    }
  }

  Future<List<CryptoData>> getCryptoData(
      {String? searchTerm, String? timePeriod, String? screener}) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (searchTerm != null) {
        queryParameters['search'] = searchTerm;
      }
      if (timePeriod != null) {
        queryParameters['time_period'] = timePeriod;
      }
      if (screener != null) {
        queryParameters['screener'] = screener;
      }

      Response response = await _dio.get(
        "/trading/analysis/",
        queryParameters: queryParameters,
      );

      return (response.data as List)
          .map((item) => CryptoData.fromJson(item))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<UserData>> getUserProfile() async {
    try {
      final authToken = await AuthService().fetchAuthToken();
      if (authToken != null) {
        Response response = await _dio.get(
          "/profile/me",
          options: Options(
            headers: {
              'Authorization': 'Token $authToken',
            },
          ),
        );
        return (response.data as List)
            .map((item) => UserData.fromJson(item))
            .toList();
      } else {
        throw Exception(
            "Auth token is null"); // Eğer authToken null ise bir hata fırlat
      }
    } catch (e) {
      return []; // Hata olursa boş bir liste döndür
    }
  }
Future<void> updateUserProfile(Map<String, dynamic> updatedFields) async {
  final authToken = await AuthService().fetchAuthToken();
  if (authToken != null) {
    final response = await _dio.patch(
      "/profile/me",
      options: Options(
        headers: {
          'Authorization': 'Token $authToken',
        },
      ),
      data: updatedFields,
    );

    if (response.statusCode == 200) {
      // İstek başarılı bir şekilde tamamlandı, istediğiniz şekilde geri bildirim sağlayabilirsiniz.
    } else {
      // başarısıs istek 
    }
  } else {
    // ('Auth token is null');
  }
}

}
