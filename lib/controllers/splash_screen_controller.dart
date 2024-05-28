import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/models/user_model.dart';
import 'package:video_calling_flutter_app/screens/home_screen/home_screen.dart';
import 'package:video_calling_flutter_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:video_calling_flutter_app/services/user_service.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';

class SplashScreenController extends GetxController {

  Future<void> getCurrentUser() async {

    try {
      final response = await UserServices.getCurrentLoggedInUser();
      log(response.toString());

      if(response['statusCode'] == 200) {
        final userJson = response['data'];

        final userModel = UserModel.fromJson(userJson);
        final userController = Get.find<UserController>();
        userController.user = userModel.obs;

        Get.offAll(() => const HomeScreen());

      }
    } catch (e) {
      if(e.toString() != 'Session Ended') {
        MyCustomToast.showErrorToast(e.toString());
      }
      Get.offAll(() => const SignInScreen());
    }

  }

  @override
  void onInit() async {
    Timer(const Duration(seconds: 2), () => getCurrentUser());
    super.onInit();
  }

}