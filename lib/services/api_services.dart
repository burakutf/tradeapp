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
      validateStatus: (status) {
        return status! < 500;
      },
      baseUrl: "http://127.0.0.1:8000/api",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    );
    _dio = Dio(options);
  }
  Future<String> login({String? email, String? password}) async {
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
        return 'success'; // Giriş başarılı
      } else {
        // Giriş başarısız
        final errorResponse = response.data;
        if (errorResponse != null && errorResponse.containsKey('detail')) {
          return errorResponse['detail']; // Hata detayını döndür
        } else {
          return 'Giriş başarısız. E-mail veya Şifreyi kontrol ediniz.';
        }
      }
    } catch (e) {
      return 'Giriş başarısız. Bir hata oluştu.';
    }
  }

  Future<bool> register({
    String? email,
    String? password,
    String? name,
    String? surname,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'email': email,
        'password': password,
        'first_name': name,
        'last_name': surname,
      };

      Response response = await _dio.post(
        "/register/",
        data: data,
      );

      if (response.statusCode == 201) {
        return true; // Kayıt başarılı
      } else {
        return false; // Kayıt başarısız
      }
    } catch (e) {
      return false; // Hata durumunda kayıt başarısız
    }
  }

Future<Map<String, dynamic>?> emailVerificationCode({
  String? email,
  String? status,
  String? code,
}) async {
  final Map<String, dynamic> data = {
    'email': email,
    'status': status,
  };

  // Eğer code değeri boş veya null değilse, data veri yapısına ekleyin
  if (code != null && code.isNotEmpty) {
    data['code'] = code;
  }
  
  try {
    Response response = await _dio.post(
      "/email/verification/code/",
      data: data,
    );
    if (response.statusCode == 200) {
      return {'message': 'Kullanıcı başarıyla onaylandı'};
    } else {
      final errorResponse = response.data;
      if (errorResponse != null && errorResponse.containsKey('error')) {
        return {'error': errorResponse['error']};
      } else {
        return null;
      }
    }
  } catch (e) {
    return null; // Hata durumunda işlem başarısız
  }
}
Future<Map<String, dynamic>?> forgotPasswordWithEmail({
  String? email,
  String? password,
  String? code,
}) async {
  final Map<String, dynamic> data = {
    'email': email,
    'code': code,
    'new_password':password
  };


  try {
    Response response = await _dio.post(
      "/forgot-password/email/",
      data: data,
    );
    if (response.statusCode == 200) {
      return {'message': 'Changed your password'};
    } else {
      final errorResponse = response.data;
      if (errorResponse != null && errorResponse.containsKey('error')) {
        return {'error': errorResponse['error']};
      } else {
        return null;
      }
    }
  } catch (e) {
    return null; // Hata durumunda işlem başarısız
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
