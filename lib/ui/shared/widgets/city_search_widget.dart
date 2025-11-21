import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/cubits/weather/get_weather_cubit.dart';
import 'package:weather_app/cubits/visibility/visibility_cubit.dart';
import 'package:weather_app/services/city_suggestions_service.dart';

class CitySearchWidget extends StatefulWidget {
  const CitySearchWidget({super.key, this.isSearchPage});
  final bool? isSearchPage;

  @override
  State<CitySearchWidget> createState() => _CitySearchWidgetState();
}

class _CitySearchWidgetState extends State<CitySearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final CitySuggestionsService suggestionsService = CitySuggestionsService(
    Dio(),
  );
  List<String> suggestionsName = [];
  List<String> suggestionsCountry = [];
  List<String> searchedCitiesList = [];

  void onCitySelected(String city) {
    setState(() {
      suggestionsName = [];
      _controller.text = city;
    });
    final cubit = BlocProvider.of<GetWeatherCubit>(context);
    cubit.getWeather(cityName: city);
    BlocProvider.of<GetWeatherCubit>(context).currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    Color colorChange() {
      return widget.isSearchPage == true
          ? Colors.white
          : Theme.of(context).colorScheme.onPrimary;
    }

    return Column(
      children: [
        SizedBox(height: 120.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: TextField(
            style: TextStyle(color: colorChange()),
            cursorColor: colorChange(),

            onChanged: (value) async {
              final result = await suggestionsService
                  .getNameAndCountrySuggestions(value);
              setState(() => suggestionsName = result['names']!);
              setState(() => suggestionsCountry = result['countries']!);
            },
            decoration: InputDecoration(
              labelText: 'Search',
              labelStyle: TextStyle(color: colorChange()),
              suffixIcon: Icon(Icons.search, color: colorChange()),
              hintText: 'City Name',
              hintStyle: TextStyle(color: colorChange()),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colorChange(), width: 2.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colorChange(), width: 2.w),
              ),
            ),
          ),
        ),
        if (suggestionsName.isNotEmpty)
          SizedBox(
            height: 500.h,
            child: ListView.separated(
              padding: EdgeInsets.only(top: 35.h),
              separatorBuilder: (BuildContext context, index) {
                return Divider(
                  height: 3.h,
                  indent: 45.w,
                  endIndent: 45.w,
                  color: colorChange(),
                );
              },
              itemCount: suggestionsName.length,
              itemBuilder: (context, index) {
                final city = suggestionsName[index];
                final country = suggestionsCountry[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: ListTile(
                    title: Text(city, style: TextStyle(color: colorChange())),
                    onTap: () {
                      if (widget.isSearchPage == true) {
                        context.read<VisibilityCubit>().show();
                        Navigator.pop(context);
                      }
                      setState(() {
                        onCitySelected(city);
                      });
                    },
                    subtitle: Text(
                      country,
                      style: TextStyle(color: colorChange()),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
