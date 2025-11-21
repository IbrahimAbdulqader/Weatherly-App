import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/cubits/weather/get_weather_cubit.dart';
import 'package:weather_app/util/weather_conditions.dart';
import 'hourly_line_chart.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';

class DailyTemp extends StatelessWidget {
  const DailyTemp({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    var citiesData = BlocProvider.of<GetWeatherCubit>(context).citiesDataMap;
    var searchedCities =
        BlocProvider.of<GetWeatherCubit>(context).searchedCitiesList;
    var currentCityData = citiesData[searchedCities[index]];
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
            width: 30.w,
            height: 30.h,
            child: DotLottieLoader.fromAsset(
              currentCityData!.isDay == 0
                  ? 'assets/lottie/night_${getWeatherAnimationAsset(currentCityData.weekdaysCondition[i])}.lottie'
                  : 'assets/lottie/${getWeatherAnimationAsset(currentCityData.weekdaysCondition[i])}.lottie',
              frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                } else {
                  return Container();
                }
              },
            ),
          ),

          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentCityData.forecastDates[i] == today
                        ? 'Today'
                        : currentCityData.forecastDates[i] == tomorrow
                        ? 'Tomorrow'
                        : currentCityData.forecastDates[i],
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  SizedBox(
                    width: 160.w,
                    child: Text(
                      currentCityData.weekdaysCondition[i].toLowerCase() ==
                                  'sunny' &&
                              currentCityData.isDay == 0
                          ? 'Clear'
                          : currentCityData.weekdaysCondition[i],
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              ),
              children: [
                TextSpan(
                  text:
                      '${currentCityData.weekdaysMaxTemp[i].round().toString()}°',
                ),
                const TextSpan(
                  text: '/',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text:
                      '${currentCityData.weekdaysMinTemp[i].round().toString()}°',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
