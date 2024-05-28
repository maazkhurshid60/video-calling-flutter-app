import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_calling_flutter_app/screens/verify_otp_screen/verify_otp_screen.dart';
import 'package:video_calling_flutter_app/services/user_service.dart';
import 'package:video_calling_flutter_app/utils/constants.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';

class ForgotPasswordScreenController extends GetxController {

  Rx<TextEditingController> emailController = TextEditingController().obs;

  Rx<GlobalKey<FormState>> forgotPassformKey = GlobalKey<FormState>().obs;

  Rx<bool> isLoading = false.obs;

  bool validateData() {
    final validation = forgotPassformKey.value.currentState!.validate();
    return validation;
  }

  void toggleIsLoading(bool value) {
    isLoading.value = value;
    update();
  }

  String? validator(String? value, String indicator) {
    if(indicator == 'email') {
      final regEx = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
      if(value == null || value.isEmpty) return 'Email is required';
      if(!regEx.hasMatch(value)) return 'Email is invalid';

      return null;
    }
  }

  void resetAllInformation() {
    emailController.value.text = '';
    update();
  }

  Future<void> submitForgotPasswordRequest(String email) async {

    try {

      toggleIsLoading(true);

      final response = await UserServices.requestUserOTP(email);

      if(response['statusCode'] == 200) {

        print(response);

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString(Constants.OTP_SENDER_EMAIL_KEY, response['data']['requestedEmail']);
        await prefs.setString(Constants.OTP_CODE_KEY, response['data']['otp']);

        await Future.delayed(const Duration(seconds: 2));

        toggleIsLoading(false);

        Get.offAll(() => const VerifyOTPScreen());

      }

    } catch (e) {
      toggleIsLoading(false);
      MyCustomToast.showErrorToast(e.toString());
    }

  }

}