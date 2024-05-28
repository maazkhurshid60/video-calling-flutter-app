import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_calling_flutter_app/models/user_model.dart';
import 'package:video_calling_flutter_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:video_calling_flutter_app/services/user_service.dart';
import 'package:video_calling_flutter_app/utils/constants.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';

class UserController extends GetxController {

  Rx<UserModel?> user = null.obs;

  Rx<bool> isLogoutLoading = false.obs;
  Rx<bool> isAccountDeleteLoading = false.obs;

  void toggelLogoutLoading(bool value) {
    isLogoutLoading.value = value;
    update();
  }

  void toggelAccountDeleteLoading(bool value) {
    isAccountDeleteLoading.value = value;
    update();
  }

  Future<void> logoutUser() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    toggelLogoutLoading(true);

    final response = await UserServices.logoutUser();

    MyCustomToast.showSuccessToast(response['message']);

    await prefs.remove(Constants.USER_ACCESS_TOKEN);
    await prefs.remove(Constants.USER_REFRESH_TOKEN);

    await Future.delayed(const Duration(seconds: 1));

    toggelLogoutLoading(false);

    Get.offAll(() => const SignInScreen());

  }

  Future<void> deleteUserAccount() async {

    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      toggelAccountDeleteLoading(true);

      final response = await UserServices.deleteUserAccount();

      MyCustomToast.showSuccessToast(response['message']);

      await prefs.remove(Constants.USER_ACCESS_TOKEN);
      await prefs.remove(Constants.USER_REFRESH_TOKEN);

      await Future.delayed(const Duration(seconds: 2));

      toggelAccountDeleteLoading(false);

      Get.offAll(() => const SignInScreen());

    } catch (e) {
      toggelAccountDeleteLoading(false);
      MyCustomToast.showErrorToast(e.toString());
    }
  

  }



}