import 'package:flutter/material.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const SearchPage();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'weather',
          style: TextStyle(
            color: Colors.white,
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
            fit: BoxFit.fill,
            image: AssetImage('assets/images/wallpaper.jfif'),
          ),
        ),
      ),
    );
  }
}
