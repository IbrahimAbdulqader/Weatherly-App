import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../cubits/weather/get_weather_cubit.dart';
import 'info_tile.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    var searchedCities =
        BlocProvider.of<GetWeatherCubit>(context).searchedCitiesList;
    var citiesData = BlocProvider.of<GetWeatherCubit>(context).citiesDataMap;
    var currentCityData = citiesData[searchedCities[index]];

    final List<List<String>> weatherInfoList = [
      [
        'Real Feel',
        '${currentCityData!.weatherInfoModel.realFeel.toString()}°',
      ],
      ['Humidity', '${currentCityData.weatherInfoModel.humidity.toString()}%'],
      ['UV', currentCityData.weatherInfoModel.uv.toString()],
      [
        'Pressure',
        '${currentCityData.weatherInfoModel.pressure.round().toString()}mbar',
      ],
      [
        'Chance of Rain',
        '${currentCityData.weatherInfoModel.chanceOfRain.toString()}%',
      ],
      [
        'Chance of Snow',
        '${currentCityData.weatherInfoModel.chanceOfSnow.toString()}%',
      ],
      [
        'Wind Direction',

        currentCityData.weatherInfoModel.windDirection.toString(),
      ],
    ];

    return Column(
      children: [
        SizedBox(height: 12.h),
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
