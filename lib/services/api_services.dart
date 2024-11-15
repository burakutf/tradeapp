import 'package:dio/dio.dart';
import 'package:tradeapp/models/crypto_data.dart';
import 'package:tradeapp/models/notification.dart';
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
      baseUrl: "https://cvgezgini.com/api",
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
          return 'Login failed. Check your E-mail or Password.';
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
      'new_password': password
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

  Future<Map<String, dynamic>?> createNotification({
    String? objectId,
    String? objectName,
  }) async {
    final authToken = await AuthService().fetchAuthToken();

    final Map<String, dynamic> data = {
      'trade_object': objectId,
      'send_type': 0,
      'title': '$objectName Notification Created'
    };

    try {
      Response response = await _dio.post(
        "/user/notification/",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        return {'message': 'Create your notification'};
      } else {
        final errorResponse = response.data[0];
        return {'error': '$errorResponse'};
      }
    } catch (e) {
      return null; // Hata durumunda işlem başarısız
    }
  }

  Future<Map<String, dynamic>?> updatePassword({
    String? oldPassword,
    String? newPassword,
  }) async {
    final authToken = await AuthService().fetchAuthToken();

    final Map<String, dynamic> data = {
      'old_password': oldPassword,
      'new_password': newPassword
    };

    try {
      Response response = await _dio.put(
        "/update-password/",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        return {'message': 'Changed your password'};
      } else {
        final errorResponse = response.data[0];
        return {'error': '$errorResponse'};
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
  Future<Map<String, dynamic>?> removeUserProfile(int? id) async {
    try {
      final authToken = await AuthService().fetchAuthToken();
      if (authToken != null) {
        Response response = await _dio.delete(
          "/profile/me/$id/",
          options: Options(
            headers: {
              'Authorization': 'Token $authToken',
            },
          ),
        );
        if (response.statusCode==200) {
          
        return {'message': 'delete your account'};
        }
      } else {
        throw Exception(
            "Auth token is null"); // Eğer authToken null ise bir hata fırlat
      }
    } catch (e) {
      return null; // Hata olursa boş bir liste döndür
    }
    return null;
  }
  Future<List<NotificationModel>> userNotification() async {
    try {
      final authToken = await AuthService().fetchAuthToken();
      if (authToken != null) {
        Response response = await _dio.get(
          "/user/notification",
          options: Options(
            headers: {
              'Authorization': 'Token $authToken',
            },
          ),
        );
        return (response.data as List)
            .map((item) => NotificationModel.fromJson(item))
            .toList();
      } else {
        throw Exception(
            "Auth token is null"); // Eğer authToken null ise bir hata fırlat
      }
    } catch (e) {
      return []; // Hata olursa boş bir liste döndür
    }
  }


}
