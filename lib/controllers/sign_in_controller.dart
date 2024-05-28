import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/models/user_model.dart';
import 'package:video_calling_flutter_app/screens/home_screen/home_screen.dart';
import 'package:video_calling_flutter_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:video_calling_flutter_app/services/user_service.dart';
import 'package:video_calling_flutter_app/utils/constants.dart';

class SignInScreenController extends GetxController {

  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  Rx<GlobalKey<FormState>> signInformKey = GlobalKey<FormState>().obs;

  Rx<bool> hidePassword = true.obs;
  Rx<bool> isLoading = false.obs;

  void toggleIsLoading(bool value) {
    isLoading.value = value;
    update();
  }

  void toggleShowPassword() {
    hidePassword.value = !hidePassword.value;
    update();
  }

  bool validateData() {
    final validation = signInformKey.value.currentState!.validate();
    return validation;
  }

  String? validator(String? value, String indicator) {
    if(indicator == 'email') {
      final regEx = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
      if(value == null || value.isEmpty) return 'Email is required';
      if(!regEx.hasMatch(value)) return 'Email is invalid';


      return null;

    } else if(indicator == 'password') {
      if(value == null || value.isEmpty) return 'Password is required';
      if(value.length < 8) return 'Password should be atleast 8 characters';

      return null;
    }
  }

  void resetAllInformation() {
    emailController.value.text = '';
    passwordController.value.text = '';
    update();
  }

  Future<void> loginUser() async {

    Map<String, dynamic> loginInformation = {};
    final prefs = await SharedPreferences.getInstance();

    loginInformation['userEmail'] = emailController.value.text.trim();
    loginInformation['userPassword'] = passwordController.value.text.trim();

    log(loginInformation.toString());

    toggleIsLoading(true);

    final result = await UserServices.loginUser(loginInformation);
    log(result.toString());

    resetAllInformation();

    final Map<String, dynamic> userJson = result['data']['user'];
    final String refreshToken = result['data']['userRefreshToken'];
    final String accessToken = result['data']['userAccessToken'];

    try {

      final UserModel userModel = UserModel.fromJson(userJson);
      final userController = Get.find<UserController>();

      userController.user = userModel.obs;
      prefs.setString(Constants.USER_ACCESS_TOKEN, accessToken);
      prefs.setString(Constants.USER_REFRESH_TOKEN, refreshToken);

      await Future.delayed(const Duration(seconds: 1));

      toggleIsLoading(false);

      Get.off(() => const HomeScreen());
      
    } catch (e) {
      toggleIsLoading(false);
      Get.off(() => const SignInScreen());
    }
    

  }

}