import 'package:intl/intl.dart';
import 'package:weather_app/data/models/weather_info_model.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'aqi_model.dart';

class WeatherParser {
  static WeatherModel parse(Map<String, dynamic> json) {
    List<String> weekdaysForecast = [];
    List<String> weekdaysCondition = [];
    List<double> weekdaysMinTemp = [];
    List<double> weekdaysMaxTemp = [];
    List<DateTime> hours = [DateTime.now()];
    List<double> hourlyTemp = [
      json['forecast']['forecastday'][0]['hour'][DateTime.now().hour]['temp_c']
          .toDouble(),
    ];

    for (var i = 0; i < 3; i++) {
      final rawDate = json['forecast']['forecastday'][i]['date'];
      weekdaysCondition.add(
        json['forecast']['forecastday'][i]['day']['condition']['text'],
      );
      weekdaysMaxTemp.add(
        (json['forecast']['forecastday'][i]['day']['maxtemp_c'] as num)
            .toDouble(),
      );
      weekdaysMinTemp.add(
        (json['forecast']['forecastday'][i]['day']['mintemp_c'] as num)
            .toDouble(),
      );
      DateTime date = DateTime.parse(rawDate);
      String weekday = DateFormat('EEEE').format(date);
      weekdaysForecast.add(weekday);
    }
    for (int j = 0; j < 2; j++) {
      for (int i = 0; i < 24; i++) {
        hours.add(
          DateTime.parse(json['forecast']['forecastday'][j]['hour'][i]['time']),
        );
        hourlyTemp.add(
          (json['forecast']['forecastday'][j]['hour'][i]['temp_c'] as num)
              .toDouble(),
        );
      }
    }
    return WeatherModel(
      cityName: json['location']['name'],
      currentTemp: (json['current']['temp_c'] as num).toDouble(),
      maxTemp:
          (json['forecast']['forecastday'][0]['day']['maxtemp_c'] as num)
              .toDouble(),
      minTemp:
          (json['forecast']['forecastday'][0]['day']['mintemp_c'] as num)
              .toDouble(),
      isDay: json['current']['is_day'] ?? 1,
      weatherCondition:
          json['forecast']['forecastday'][0]['day']['condition']['text'],
      forecastDates: weekdaysForecast,
      weekdaysCondition: weekdaysCondition,
      weekdaysMaxTemp: weekdaysMaxTemp,
      weekdaysMinTemp: weekdaysMinTemp,
      hours: hours,
      hourlyTemp: hourlyTemp,
      weatherInfoModel: InfoModel.fromJson(json),
      airQualityModel: AQIModel.fromJson(json),
    );
  }
}
