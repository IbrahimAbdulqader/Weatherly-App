import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/cubits/weather/get_weather_cubit.dart';
import 'package:weather_app/ui/all_cities/widgets/delete_alert.dart';
import 'package:weather_app/ui/shared/widgets/custom_rich_text.dart';
import 'package:weather_app/ui/shared/widgets/custom_text.dart';

class CityTile extends StatefulWidget {
  const CityTile({
    super.key,
    required this.cityName,
    required this.minTemp,
    required this.maxTemp,
    required this.currentTemp,
    required this.condition,
    required this.isNight,
  });
  final String cityName;
  final String condition;
  final String minTemp;
  final String maxTemp;
  final String currentTemp;
  final bool isNight;

  @override
  State<CityTile> createState() => _CityTileState();
}

class _CityTileState extends State<CityTile> {
  void onCitySelected(String city) {
    BlocProvider.of<GetWeatherCubit>(context).deleteACity(cityName: city);
  }

  @override
  Widget build(BuildContext context) {
    List searchedCitiesList =
        BlocProvider.of<GetWeatherCubit>(context).searchedCitiesList;

    return Container(
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 15.w),
      width: double.infinity,
      height: 90.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1.w, color: Colors.white),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 225.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: widget.cityName,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 85.w,
                      child: CustomRichText(
                        generalTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textChildren: [
                          TextSpan(text: widget.minTemp),
                          const TextSpan(
                            text: '/',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          TextSpan(text: widget.maxTemp),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 135.w,
                      child: CustomText(
                        text:
                            widget.condition.toLowerCase() == 'sunny' &&
                                    widget.isNight
                                ? 'Clear'
                                : widget.condition,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: VerticalDivider(color: Colors.white, width: 1.w),
          ),
          SizedBox(
            width: 115.w,
            child:
                searchedCitiesList.length == 1 || searchedCitiesList.isEmpty
                    ? Padding(
                      padding: EdgeInsets.only(left: 30.w),
                      child: CustomRichText(
                        generalTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textChildren: [
                          TextSpan(text: widget.currentTemp),
                          const TextSpan(
                            text: '°',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: SizedBox(
                            width: 55.w,
                            child: Center(
                              child: CustomRichText(
                                generalTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                textChildren: [
                                  TextSpan(text: widget.currentTemp),
                                  const TextSpan(
                                    text: '°',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => DeleteAlert(
                                    cityName: widget.cityName,
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                        onCitySelected(widget.cityName);
                                      });
                                    },
                                  ),
                            );
                          },
                          icon: const Icon(Icons.close, color: Colors.white),
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}
