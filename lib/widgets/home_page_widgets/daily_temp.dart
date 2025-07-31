import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/cubits/get_weather_cubit.dart';

import 'hourlyLineChart.dart';

class DailyTemp extends StatelessWidget {
  const DailyTemp({super.key});

  @override
  Widget build(BuildContext context) {
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel;
    String today = DateFormat(
      'EEEE',
    ).format(DateTime(now.year, now.month, now.day));
    String tomorrow = DateFormat('EEEE').format(
      DateTime(now.year, now.month, now.day).add(const Duration(days: 1)),
    );
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (BuildContext context, int i) {
        return ListTile(
          leading: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset('assets/gifs/Weather Day - clear sky.gif'),
          ),

          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weatherModel.forecastDates[i] == today
                        ? 'Today'
                        : weatherModel.forecastDates[i] == tomorrow
                        ? 'Tomorrow'
                        : weatherModel.forecastDates[i],
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    weatherModel.weekdaysCondition[i],
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          trailing: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              children: [
                TextSpan(
                  text:
                      '${weatherModel.threeDayMaxTemp[i].round().toString()}°',
                ),
                const TextSpan(
                  text: '/',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text:
                      '${weatherModel.weekdaysMinTemp[i].round().toString()}°',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
