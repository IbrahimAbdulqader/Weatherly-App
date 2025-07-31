import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit.dart';
import '../services/city_suggestions_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final CitySuggestionsService suggestionsService = CitySuggestionsService(
    Dio(),
  );
  List<String> suggestions = [];

  void onCitySelected(String city) {
    _controller.text = city;
    setState(() => suggestions = []);
    final getWeatherCubit = BlocProvider.of<GetWeatherCubit>(context);
    getWeatherCubit.getWeather(cityName: city);
    // You can also navigate away if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Add a Location',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper.jfif'),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      onChanged: (value) async {
                        final result = await suggestionsService
                            .getNameAndCountrySuggestions(value);
                        setState(() => suggestions = result['names']!);
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        suffixIcon: const Icon(Icons.search),
                        hintText: 'City Name',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (suggestions.isNotEmpty)
                    SizedBox(
                      height: 500,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, index) {
                          return const Divider(
                            height: 3,
                            indent: 45,
                            endIndent: 45,
                          );
                        },
                        itemCount: suggestions.length,
                        itemBuilder: (context, index) {
                          final city = suggestions[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListTile(
                              title: Text(city),
                              onTap: () => onCitySelected(city),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
