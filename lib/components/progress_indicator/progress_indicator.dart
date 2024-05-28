import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_calling_flutter_app/utils/constants.dart';


class MyProgressIndicator extends StatelessWidget {
  final Color progressColor;
  const MyProgressIndicator(this.progressColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.progressIndicatorSize.w,
      width: Constants.progressIndicatorSize.w,
      child: CircularProgressIndicator(
        strokeWidth: Constants.progressIndicatorStrokWidth,
        color: progressColor,
      ),
    );
  }
}