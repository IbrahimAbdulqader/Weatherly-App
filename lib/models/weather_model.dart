import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_info_model.dart';

import 'aqi_model.dart';

class WeatherModel {
  final String cityName;
  final String? icon;
  final double currentTemp;
  final double maxTemp;
  final double minTemp;
  final String weatherCondition;
  final List<String> forecastDates;
  final List<String> weekdaysCondition;
  final List<double> weekdaysMinTemp;
  final List<double> threeDayMaxTemp;
  final List<DateTime> hours;
  final List<double> hourlyTemp;
  final AirQualityModel airQualityModel;
  final WeatherInfoModel weatherInfoModel;

  WeatherModel({
    required this.cityName,
    required this.icon,
    required this.currentTemp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherCondition,
    required this.forecastDates,
    required this.threeDayMaxTemp,
    required this.weekdaysMinTemp,
    required this.weekdaysCondition,
    required this.hours,
    required this.hourlyTemp,
    required this.airQualityModel,
    required this.weatherInfoModel,
  });
  factory WeatherModel.fromJson(json) {
    List<String> forecastWeekdays = [];
    List<String> weekdaysCondition = [];
    List<double> weekdaysMinTemp = [];
    List<double> weekdaysMaxTemp = [];
    List<DateTime> hours = [DateTime.now()];
    List<double> hourlyTemp = [
      json['forecast']['forecastday'][0]['hour'][DateTime.now().hour]['temp_c'],
    ];

    for (var i = 0; i < 3; i++) {
      final rawDate = json['forecast']['forecastday'][i]['date'];
      weekdaysCondition.add(
        json['forecast']['forecastday'][i]['day']['condition']['text'],
      );
      weekdaysMaxTemp.add(
        json['forecast']['forecastday'][i]['day']['maxtemp_c'],
      );
      weekdaysMinTemp.add(
        json['forecast']['forecastday'][i]['day']['mintemp_c'],
      );
      DateTime date = DateTime.parse(rawDate);
      String weekday = DateFormat('EEEE').format(date);
      forecastWeekdays.add(weekday);
    }

    for (int j = 0; j < 2; j++) {
      for (int i = 0; i < 24; i++) {
        hours.add(
          DateTime.parse(json['forecast']['forecastday'][j]['hour'][i]['time']),
        );
        hourlyTemp.add(json['forecast']['forecastday'][j]['hour'][i]['temp_c']);
      }
    }

    return WeatherModel(
      cityName: json['location']['name'],
      icon: json['current']['condition']['icon'],
      currentTemp: json['current']['temp_c'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      weatherCondition:
          json['forecast']['forecastday'][0]['day']['condition']['text'],
      forecastDates: forecastWeekdays,
      weekdaysCondition: weekdaysCondition,
      threeDayMaxTemp: weekdaysMaxTemp,
      weekdaysMinTemp: weekdaysMinTemp,
      hours: hours,
      hourlyTemp: hourlyTemp,
      weatherInfoModel: WeatherInfoModel.fromJson(json),
      airQualityModel: AirQualityModel.fromJson(json),
    );
  }
}
