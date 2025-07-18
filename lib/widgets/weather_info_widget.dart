import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel;
    bool fullIconUrl = weatherModel.icon!.contains('https:');
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Text(
                weatherModel.cityName,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                  foreground:
                      Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Colors.grey,
                ),
              ),
              Text(
                weatherModel.cityName,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            ' updated at ${weatherModel.date.hour}:${weatherModel.date.minute}',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),

          Row(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 86,
                height: 86,
                child:
                    fullIconUrl != false
                        ? Image.network('weatherModel.icon')
                        : Image.network('https:${weatherModel.icon}'),
              ),
              Text(
                weatherModel.avgTemp.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 64,
                ),
              ),
              Column(
                spacing: 10,
                children: [
                  Text(
                    'Min Temp: ${weatherModel.minTemp.round().toString()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Min Temp: ${weatherModel.maxTemp.round().toString()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Text(
            weatherModel.weatherCondition,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 46,
            ),
          ),
        ],
      ),
    );
  }
}

DateTime stringToDateTime(String value) {
  return DateTime.parse(value);
}
