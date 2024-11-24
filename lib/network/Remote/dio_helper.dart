import 'package:dio/dio.dart';
import '../endpoints.dart';

class DioHelper {
  static late Dio dio;

  static void initDio() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getCurrentData({required String city}) async {
    return await dio.get("current.json", queryParameters: {
      "key": apiKey,
      "q": city,
    });
  }

  static Future<Response> getForecastData({required String city}) async {
    return await dio.get("forecast.json", queryParameters: {
      "key": apiKey,
      "q": city,
      "days": 7,
    });
  }
}
