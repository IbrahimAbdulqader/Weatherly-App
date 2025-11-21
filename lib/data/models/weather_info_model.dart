class InfoModel {
  final int humidity;
  final double realFeel;
  final double uv;
  final double pressure;
  final int chanceOfRain;
  final int chanceOfSnow;
  final String windDirection;

  InfoModel({
    required this.realFeel,
    required this.humidity,
    required this.uv,
    required this.pressure,
    required this.chanceOfRain,
    required this.chanceOfSnow,
    required this.windDirection,
  });

  Map<String, dynamic> toMap() {
    return {
      'realFeel': realFeel,
      'humidity': humidity,
      'uv': uv,
      'pressure': pressure,
      'chanceOfRain': chanceOfRain,
      'chanceOfSnow': chanceOfSnow,
      'windDirection': windDirection,
    };
  }

  factory InfoModel.fromMap(Map<String, dynamic> map) {
    return InfoModel(
      realFeel: (map['realFeel'] as num).toDouble(),
      humidity: map['humidity'],
      uv: (map['uv'] as num).toDouble(),
      pressure: (map['pressure'] as num).toDouble(),
      chanceOfRain: map['chanceOfRain'],
      chanceOfSnow: map['chanceOfSnow'],
      windDirection: map['windDirection'],
    );
  }

  factory InfoModel.fromJson(json) {
    return InfoModel(
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
