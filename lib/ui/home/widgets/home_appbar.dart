import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/cubits/weather/get_weather_cubit.dart';
import 'package:weather_app/cubits/visibility/visibility_cubit.dart';
import 'package:weather_app/ui/all_cities/screen/all_cities_screen.dart';
import 'package:weather_app/ui/search/screen/search_screen.dart';
import 'package:weather_app/util/screen_transition.dart';

class HomeAppbar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
    required this.title,
    required this.smoothPageController,
  });
  final String title;
  final PageController smoothPageController;

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}

class _HomeAppbarState extends State<HomeAppbar> {
  @override
  Widget build(BuildContext context) {
    var searchedCities =
        BlocProvider.of<GetWeatherCubit>(context).searchedCitiesList;

    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(140.h),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: SmoothPageIndicator(
            controller: widget.smoothPageController,
            count: searchedCities.length,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              dotColor: Colors.white38,
              activeDotColor: Colors.white,
            ),
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () {
          context.read<VisibilityCubit>().hide();
          Navigator.of(context).push(
            animatedRoute(const AllCitiesScreen(), const Offset(-1.0, 0.0)),
          );
        },
        icon: Padding(
          padding: EdgeInsets.only(top: 15.h, left: 10.w),
          child: Icon(Icons.menu, color: Colors.white, size: 28.sp),
        ),
      ),

      actions: [
        IconButton(
          onPressed:
              searchedCities.length >= 10
                  ? null
                  : () {
                    context.read<VisibilityCubit>().hide();
                    Navigator.of(context).push(
                      animatedRoute(const SearchScreen(), const Offset(1.0, 0)),
                    );
                  },
          icon: Padding(
            padding: EdgeInsets.only(top: 15.h, right: 10.w),
            child: Icon(
              Icons.add,
              color:
                  searchedCities.length >= 10 ? Colors.grey[600] : Colors.white,
              size: 28.sp,
            ),
          ),
        ),
      ],

      forceMaterialTransparency: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
