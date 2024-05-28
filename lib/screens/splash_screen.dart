import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_flutter_app/controllers/splash_screen_controller.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SizedBox(
            width: Get.mediaQuery.size.width,
            height: Get.mediaQuery.size.height,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.royalBlueColor,),
            ),
          ),
        );
      },
    );
  }
}