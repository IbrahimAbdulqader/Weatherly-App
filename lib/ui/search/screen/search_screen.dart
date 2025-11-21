import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/cubits/weather/get_weather_cubit.dart';
import 'package:weather_app/cubits/visibility/visibility_cubit.dart';
import 'package:weather_app/services/city_suggestions_service.dart';
import 'package:weather_app/ui/shared/widgets/city_search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  final CitySuggestionsService suggestionsService = CitySuggestionsService(
    Dio(),
  );
  List<String> suggestions = [];

  void onCitySelected(String city) {
    setState(() {
      controller.text = city;
      suggestions = [];
    });
    final getWeatherCubit = BlocProvider.of<GetWeatherCubit>(context);
    getWeatherCubit.getWeather(cityName: city);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.read<VisibilityCubit>().show();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          forceMaterialTransparency: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<VisibilityCubit>().show();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'Add a Location',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
          ),
        ),
        body: Column(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
              child: const CitySearchWidget(isSearchPage: true),
            ),
          ],
        ),
      ),
    );
  }
}
