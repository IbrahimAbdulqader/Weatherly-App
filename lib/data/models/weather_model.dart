import 'package:weather_app/data/models/weather_info_model.dart';
import 'package:weather_app/data/models/weather_parser.dart';
import 'aqi_model.dart';

class WeatherModel {
  final String cityName;
  final double currentTemp;
  final double maxTemp;
  final double minTemp;
  final int isDay;
  final String weatherCondition;
  final List<String> forecastDates;
  final List<String> weekdaysCondition;
  final List<double> weekdaysMinTemp;
  final List<double> weekdaysMaxTemp;
  final List<DateTime> hours;
  final List<double> hourlyTemp;
  final AQIModel airQualityModel;
  final InfoModel weatherInfoModel;

  WeatherModel({
    required this.cityName,
    required this.currentTemp,
    required this.maxTemp,
    required this.minTemp,
    required this.isDay,
    required this.weatherCondition,
    required this.forecastDates,
    required this.weekdaysMaxTemp,
    required this.weekdaysMinTemp,
    required this.weekdaysCondition,
    required this.hours,
    required this.hourlyTemp,
    required this.airQualityModel,
    required this.weatherInfoModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'currentTemp': currentTemp,
      'maxTemp': maxTemp,
      'minTemp': minTemp,
      'isDay': isDay,
      'weatherCondition': weatherCondition,
      'forecastDates': forecastDates,
      'weekdaysCondition': weekdaysCondition,
      'weekdaysMinTemp': weekdaysMinTemp,
      'threeDayMaxTemp': weekdaysMaxTemp,
      'hours': hours.map((e) => e.toIso8601String()).toList(),
      'hourlyTemp': hourlyTemp,
      'airQualityModel': airQualityModel.toMap(),
      'weatherInfoModel': weatherInfoModel.toMap(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      cityName: map['cityName'],
      currentTemp: (map['currentTemp'] as num).toDouble(),
      maxTemp: (map['maxTemp'] as num).toDouble(),
      minTemp: (map['minTemp'] as num).toDouble(),
      isDay: map['isDay'],
      weatherCondition: map['weatherCondition'],
      forecastDates: List<String>.from(map['forecastDates']),
      weekdaysCondition: List<String>.from(map['weekdaysCondition']),
      weekdaysMinTemp:
          (map['weekdaysMinTemp'] as List)
              .map((e) => (e as num).toDouble())
              .toList(),
      weekdaysMaxTemp:
          (map['threeDayMaxTemp'] as List)
              .map((e) => (e as num).toDouble())
              .toList(),
      hours: (map['hours'] as List).map((e) => DateTime.parse(e)).toList(),
      hourlyTemp:
          (map['hourlyTemp'] as List)
              .map((e) => (e as num).toDouble())
              .toList(),
      airQualityModel: AQIModel.fromMap(map['airQualityModel']),
      weatherInfoModel: InfoModel.fromMap(map['weatherInfoModel']),
    );
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherParser.parse(json);
  }
}
