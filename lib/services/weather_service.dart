import 'package:dio/dio.dart';
import 'package:weather_app/consts/api_consts.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherService {
  final Dio dio;
  WeatherService(this.dio);
  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio.get(
        '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=3&aqi=yes',
      );

      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['error']['message'] ??
          'There Was An Error, Try Again Later';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('There Was An Error, Try Again Later');
    }
  }
}
