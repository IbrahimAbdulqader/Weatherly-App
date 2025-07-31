import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit.dart';
import 'aqi_dialog.dart';
import 'info_tile.dart';

class AqiInfo extends StatelessWidget {
  const AqiInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel;
    final List<List<String>> aqiInfoList = [
      ['CO', weatherModel.airQualityModel.co.roundToDouble().toString()],
      ['NO2', weatherModel.airQualityModel.no2.roundToDouble().toString()],
      ['O3', weatherModel.airQualityModel.o3.roundToDouble().toString()],
      ['SO2', weatherModel.airQualityModel.so2.roundToDouble().toString()],
      ['PM2.5', weatherModel.airQualityModel.pm2_5.roundToDouble().toString()],
      ['PM10', weatherModel.airQualityModel.pm10.roundToDouble().toString()],
    ];

    return Column(
      children: [
        const SizedBox(height: 12),
        InfoTile(
          iconButton: SizedBox(
            width: 22,
            height: 20,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: (context),
                  builder: (BuildContext context) {
                    return const AqiDialog();
                  },
                );
              },
              child: const Icon(Icons.info_outline_rounded, size: 18),
            ),
          ),
          title: 'Simple AQI',
          info: weatherModel.airQualityModel.simplifiedAqi.toString(),
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
