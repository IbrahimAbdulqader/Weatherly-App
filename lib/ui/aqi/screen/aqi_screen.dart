import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/cubits/weather/get_weather_cubit.dart';
import 'package:weather_app/ui/aqi/widgets/text_cell.dart';
import 'package:weather_app/ui/shared/widgets/custom_text.dart';

class AqiScreen extends StatelessWidget {
  const AqiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var citiesData = BlocProvider.of<GetWeatherCubit>(context).citiesDataMap;
    var searchedCities =
        BlocProvider.of<GetWeatherCubit>(context).searchedCitiesList;
    var currentIndex = BlocProvider.of<GetWeatherCubit>(context).currentIndex;
    var currentCityData = citiesData[searchedCities[currentIndex]];

    final List<List<String>> aqiRows = [
      ['1', '0-50', 'Good'],
      ['2', '51-100', 'Moderate'],
      ['3', '101-150', 'Sensitive Risk'],
      ['4', '151-200', 'Unhealthy'],
      ['5', '201-300', 'Very Unhealthy'],
      ['6', '300+', 'Hazardous'],
    ];

    final List<Color> aqiColors = [
      Colors.green,
      Colors.yellowAccent,
      Colors.orange,
      Colors.red,
      Colors.brown,
      Colors.purple,
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Container(),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: CustomText(
            isDarkMode: true,
            text: 'Air Quality Index',
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: 35.h),
            CustomText(
              isDarkMode: true,
              text: 'Current AQI:',
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
            Text(
              currentCityData!.airQualityModel.simplifiedAqi.toString(),
              style: TextStyle(fontSize: 86.sp, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 35),
            Row(
              spacing: 50.w,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  isDarkMode: true,
                  text: 'Simple AQI',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40.w),
                  child: CustomText(
                    isDarkMode: true,
                    text: 'AQI',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomText(
                  isDarkMode: true,
                  text: 'Level',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            ...List.generate(aqiRows.length, (index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextCell(text: aqiRows[index][0], isTitle: true),
                      ),
                      Expanded(
                        child: TextCell(text: aqiRows[index][1], isTitle: true),
                      ),
                      Expanded(
                        child: TextCell(
                          text: aqiRows[index][2],

                          color: aqiColors[index],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                ],
              );
            }),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 100.h),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: CustomText(
                  isDarkMode: true,
                  text: 'Back',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
