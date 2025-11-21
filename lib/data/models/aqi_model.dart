class AQIModel {
  AQIModel({
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

  Map<String, dynamic> toMap() {
    return {
      'co': co,
      'no2': no2,
      'o3': o3,
      'so2': so2,
      'pm2_5': pm2_5,
      'pm10': pm10,
      'simplifiedAqi': simplifiedAqi,
    };
  }

  factory AQIModel.fromMap(Map<String, dynamic> map) {
    return AQIModel(
      co: (map['co'] as num).toDouble(),
      no2: (map['no2'] as num).toDouble(),
      o3: (map['o3'] as num).toDouble(),
      so2: (map['so2'] as num).toDouble(),
      pm2_5: (map['pm2_5'] as num).toDouble(),
      pm10: (map['pm10'] as num).toDouble(),
      simplifiedAqi: map['simplifiedAqi'],
    );
  }

  factory AQIModel.fromJson(json) {
    return AQIModel(
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
