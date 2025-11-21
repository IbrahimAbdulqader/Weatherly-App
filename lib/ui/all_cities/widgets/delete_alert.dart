import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/ui/shared/widgets/custom_text.dart';

class DeleteAlert extends StatefulWidget {
  const DeleteAlert({super.key, required this.cityName, this.onPressed});

  final VoidCallback? onPressed;
  final String cityName;

  @override
  State<DeleteAlert> createState() => _DeleteAlertState();
}

class _DeleteAlertState extends State<DeleteAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: SizedBox(
        width: 400.w,
        height: 150.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              color: Theme.of(context).colorScheme.onPrimary,
              text: 'Are you sure you want to delete',
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            CustomText(
              color: Theme.of(context).colorScheme.onPrimary,
              text: '${widget.cityName} ?',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        SizedBox(width: 5.w),
        OutlinedButton(
          onPressed: widget.onPressed,
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
