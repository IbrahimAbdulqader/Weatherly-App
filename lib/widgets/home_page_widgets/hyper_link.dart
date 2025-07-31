import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../general_widgets/custom_rich_text.dart';

class HyperLink extends StatelessWidget {
  const HyperLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () => launchUrlString('https://www.weatherapi.com/'),
        child: const CustomRichText(
          generalTextStyle: TextStyle(color: Colors.white30, fontSize: 14),
          textChildren: [
            TextSpan(text: 'App Was Made With • '),
            TextSpan(
              text: 'WeatherApi.com',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
