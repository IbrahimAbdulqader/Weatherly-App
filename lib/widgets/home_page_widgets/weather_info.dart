import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit.dart';
import 'info_tile.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel;
    final List<List<String>> weatherInfoList = [
      ['Real Feel', '${weatherModel.weatherInfoModel.realFeel.toString()}°'],
      ['Humidity', '${weatherModel.weatherInfoModel.humidity.toString()}%'],
      ['UV', weatherModel.weatherInfoModel.uv.toString()],
      [
        'Pressure',
        '${weatherModel.weatherInfoModel.pressure.round().toString()}mbar',
      ],
      [
        'Chance of Rain',
        '${weatherModel.weatherInfoModel.chanceOfRain.toString()}%',
      ],
      [
        'Chance of Snow',
        '${weatherModel.weatherInfoModel.chanceOfSnow.toString()}%',
      ],
      [
        'Wind Direction',
        weatherModel.weatherInfoModel.windDirection.toString(),
      ],
    ];

    return Column(
      children: [
        const SizedBox(height: 12),
        ...List.generate(weatherInfoList.length, (index) {
          return InfoTile(
            title: weatherInfoList[index][0],
            info: weatherInfoList[index][1],
          );
        }),
      ],
    );
  }
}
