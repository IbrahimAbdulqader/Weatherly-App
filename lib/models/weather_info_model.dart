class WeatherInfoModel {
  final int humidity;
  final double realFeel;
  final double uv;
  final double pressure;
  final int chanceOfRain;
  final int chanceOfSnow;
  final String windDirection;

  WeatherInfoModel({
    required this.realFeel,
    required this.humidity,
    required this.uv,
    required this.pressure,
    required this.chanceOfRain,
    required this.chanceOfSnow,
    required this.windDirection,
  });

  factory WeatherInfoModel.fromJson(json) {
    return WeatherInfoModel(
      realFeel: json['current']['feelslike_c'],
      humidity: json['current']['humidity'],
      uv: json['current']['uv'],
      pressure: json['current']['pressure_mb'],
      windDirection: json['current']['wind_dir'],
      chanceOfRain:
          json['forecast']['forecastday'][0]['day']['daily_chance_of_rain'],
      chanceOfSnow:
          json['forecast']['forecastday'][0]['day']['daily_chance_of_snow'],
    );
  }
}
