import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../shared/widgets/custom_rich_text.dart';

class HyperLink extends StatelessWidget {
  const HyperLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: InkWell(
        onTap: () => launchUrlString('https://www.weatherapi.com/'),
        child: const CustomRichText(
          generalTextStyle: TextStyle(color: Colors.white30, fontSize: 14),
          textChildren: [
            TextSpan(text: 'Weather data provided by • '),
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
