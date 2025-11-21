import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../cubits/weather/get_weather_cubit.dart';

class MainTempWidget extends StatefulWidget {
  const MainTempWidget({super.key, required this.index});
  final int index;

  @override
  State<MainTempWidget> createState() => _MainTempWidgetState();
}

class _MainTempWidgetState extends State<MainTempWidget> {
  @override
  Widget build(BuildContext context) {
    var citiesDataMap = BlocProvider.of<GetWeatherCubit>(context).citiesDataMap;
    var searchedCities =
        BlocProvider.of<GetWeatherCubit>(context).searchedCitiesList;
    var currentCityData = citiesDataMap[searchedCities[widget.index]];

    return Stack(
      children: [
        Positioned(
          top: 100.h,
          left: 200.w,
          child: Container(
            width: 45.w,
            height: 75.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 125.r,
                  spreadRadius: 65.r,
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: GradientText(
                    currentCityData!.currentTemp.round().toString(),

                    style: TextStyle(
                      fontSize: 128.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    gradientDirection: GradientDirection.ttb,
                    stops: const [0, .5, .75],
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white.withAlpha(0),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 55.h),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 44.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: '°',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 50.sp,
                          ),
                        ),
                        const TextSpan(text: 'c'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26.sp,
                ),
                children: [
                  TextSpan(
                    text: '${currentCityData.maxTemp.round().toString()}°',
                  ),
                  const TextSpan(
                    text: '/',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: '${currentCityData.minTemp.round().toString()}°',
                  ),
                ],
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              currentCityData.weatherCondition.toLowerCase() == 'sunny' &&
                      currentCityData.isDay == 0
                  ? 'Clear'
                  : currentCityData.weatherCondition,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 28.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
