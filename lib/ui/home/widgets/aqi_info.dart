import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../cubits/weather/get_weather_cubit.dart';
import '../../aqi/screen/aqi_screen.dart';
import 'info_tile.dart';

class AqiInfo extends StatelessWidget {
  const AqiInfo({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    var searchedCities =
        BlocProvider.of<GetWeatherCubit>(context).searchedCitiesList;
    var citiesData = BlocProvider.of<GetWeatherCubit>(context).citiesDataMap;
    var currentCityData = citiesData[searchedCities[index]];
    final List<List<String>> aqiInfoList = [
      ['CO', currentCityData!.airQualityModel.co.roundToDouble().toString()],
      ['NO2', currentCityData.airQualityModel.no2.roundToDouble().toString()],
      ['O3', currentCityData.airQualityModel.o3.roundToDouble().toString()],
      ['SO2', currentCityData.airQualityModel.so2.roundToDouble().toString()],
      [
        'PM2.5',
        currentCityData.airQualityModel.pm2_5.roundToDouble().toString(),
      ],
      ['PM10', currentCityData.airQualityModel.pm10.roundToDouble().toString()],
    ];

    return Column(
      children: [
        SizedBox(height: 12.h),
        InfoTile(
          iconButton: SizedBox(
            width: 22.w,
            height: 20.h,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AqiScreen();
                    },
                  ),
                );
              },
              child: Icon(
                Icons.info_outline_rounded,
                size: 18.sp,
                color: Colors.white,
              ),
            ),
          ),
          title: 'Simple AQI',
          info: currentCityData.airQualityModel.simplifiedAqi.toString(),
        ),
        ...List.generate(aqiInfoList.length, (index) {
          return InfoTile(
            title: aqiInfoList[index][0],
            info: aqiInfoList[index][1],
          );
        }),
      ],
    );
  }
}
