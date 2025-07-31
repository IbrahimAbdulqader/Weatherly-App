class AirQualityModel {
  AirQualityModel({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.simplifiedAqi,
  });
  final double co;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final int simplifiedAqi;

  factory AirQualityModel.fromJson(json) {
    return AirQualityModel(
      co: json['current']['air_quality']['co'],
      no2: json['current']['air_quality']['no2'],
      o3: json['current']['air_quality']['o3'],
      so2: json['current']['air_quality']['so2'],
      pm2_5: json['current']['air_quality']['pm2_5'],
      pm10: json['current']['air_quality']['pm10'],
      simplifiedAqi: json['current']['air_quality']['us-epa-index'],
    );
  }
}
