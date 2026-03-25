import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_calling_flutter_app/controllers/app_bindings/app_binding.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';


import 'screens/splash_screen.dart';

// Adding this line  for git activity

void main() {
  
  runApp(const VideoCallingApp());
}

class VideoCallingApp extends StatelessWidget {
  const VideoCallingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      splitScreenMode: false,
      minTextAdapt: true,
      designSize: const Size(430, 932),
      builder: (context, child) => GetMaterialApp(
        initialBinding: AppBindings(),
        debugShowCheckedModeBanner: false,
        title: 'Video Calling App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.royalBlueColor),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          CountryLocalizations.delegate
        ],
        home: const SplashScreen()
      ),
    );
  }
}

