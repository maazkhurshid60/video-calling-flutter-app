
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/screens/reset_password_screen/reset_password_screen.dart';
import 'package:video_calling_flutter_app/utils/constants.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';

import '../services/user_service.dart';

class VerifyOTPScreenController extends GetxController {

  Rx<bool> isUserAlreadyLoggedIn = false.obs;

  Rx<String> userEmailAddress = ''.obs;
  String sendedOTP = '';

  Rx<int> timerSeconds = 60.obs;
  
  Rx<TextEditingController> otpNum1 = TextEditingController().obs;
  Rx<TextEditingController> otpNum2 = TextEditingController().obs;
  Rx<TextEditingController> otpNum3 = TextEditingController().obs;
  Rx<TextEditingController> otpNum4 = TextEditingController().obs;

  Rx<FocusNode>  focusNode1 = FocusNode().obs;
  Rx<FocusNode>  focusNode2 = FocusNode().obs;
  Rx<FocusNode>  focusNode3 = FocusNode().obs;

  Rx<GlobalKey<FormState>> otpFormKey = GlobalKey<FormState>().obs;

  Rx<bool> isVerifying = false.obs;
  Rx<bool> isResendBtnActive = false.obs;
  Rx<bool> isResendOTPBtnPressed = false.obs;

  void toggleIsVerifying(bool value) {
    isVerifying.value = value;
    update();
  }

  void toggleIsResendBtnActive(bool value) {
    isResendBtnActive.value = value;
    update();
  }

  void toggleIsResendOTPBtnPressed(bool value) {
    isResendOTPBtnPressed.value = value;
    update();
  }

  Future<void> loadOTPSendedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmailAddress.value = prefs.getString(Constants.OTP_SENDER_EMAIL_KEY) ?? '';
    sendedOTP = prefs.getString(Constants.OTP_CODE_KEY) ?? '';
  }

  void verifyOTP() async {

    try {

      toggleIsVerifying(true);

      final num1 = otpNum1.value.text.trim();
      final num2 = otpNum2.value.text.trim();
      final num3 = otpNum3.value.text.trim();
      final num4 = otpNum4.value.text.trim();

      String userTypedOTP = '$num1$num2$num3$num4';

      if(userTypedOTP != sendedOTP) {
        throw Exception('Invalid OTP Number');
      }

      await Future.delayed(const Duration(seconds: 2));

      MyCustomToast.showSuccessToast('OTP Verified!');

      toggleIsVerifying(false);

      Get.off(() => const ResetPasswordScreen());
      
    } catch (e) {
      toggleIsVerifying(false);
      MyCustomToast.showErrorToast('Invalid OTP Number');
    }
  }

  Future<void> submitResendOTPRequest() async {

    try {

      final response = await UserServices.requestUserOTP(userEmailAddress.value);

      if(response['statusCode'] == 200) {

        print(response);

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString(Constants.OTP_SENDER_EMAIL_KEY, response['data']['requestedEmail']);
        await prefs.setString(Constants.OTP_CODE_KEY, response['data']['otp']);


        loadOTPSendedData();
        toggleIsResendOTPBtnPressed(true);
      }

    } catch (e) {
      MyCustomToast.showErrorToast(e.toString());
    }

  }

  void startResendOTPTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) { 
      if(timerSeconds.value > 0) {
        timerSeconds.value = timerSeconds.value - 1;
        update();
      }
      if(timerSeconds.value == 0) {
        timer.cancel();
        toggleIsResendBtnActive(true);
      }
    });
  }

  void checkIfUserIsLoggedIn() {
    final user = Get.find<UserController>().user.value;

    if(user == null) {
      isUserAlreadyLoggedIn.value = false;
    } else {
      isUserAlreadyLoggedIn.value = true;
    }

    update();
  }

  @override
  void onInit() async {
    checkIfUserIsLoggedIn();
    await loadOTPSendedData();
    startResendOTPTimer();
    super.onInit();
  }
}