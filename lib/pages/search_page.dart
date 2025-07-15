import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import '../services/weather_service.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'search',
          style: TextStyle(
            fontSize: 32,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            letterSpacing: 5,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper.jfif'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.white38],
                    ),
                  ),

                  child: TextField(
                    onSubmitted: (value) async {
                      WeatherModel weatherModel = await WeatherService(
                        Dio(),
                      ).getCurrentWeather(cityName: value);
                    },

                    decoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle: const TextStyle(color: Colors.white),
                      suffixIcon: const Icon(Icons.search, color: Colors.white),
                      hintText: 'City Name',
                      hintStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
