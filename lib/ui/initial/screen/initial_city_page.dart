import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/widgets/city_search_widget.dart';

class InitialCityScreen extends StatefulWidget {
  const InitialCityScreen({super.key});

  @override
  State<InitialCityScreen> createState() => _InitialCityScreenState();
}

class _InitialCityScreenState extends State<InitialCityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: 20.r),
          child: Text(
            'Set Your Default Location',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: const CitySearchWidget(),
    );
  }
}
