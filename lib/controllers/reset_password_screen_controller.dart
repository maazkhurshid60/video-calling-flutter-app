import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/services/user_service.dart';
import 'package:video_calling_flutter_app/utils/constants.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';

class ResetPasswordScreenController extends GetxController {

  Rx<bool> isUserAlreadyLoggedIn = false.obs;

  //In case if the user is logged in then we will require the old password as well
  Rx<TextEditingController> oldPasswordController = TextEditingController().obs;

  //In case if the user is not logged in then we will require only the new password fields
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confrimNewPasswordController = TextEditingController().obs;

  Rx<GlobalKey<FormState>> resetPassFormKey = GlobalKey<FormState>().obs;

  Rx<bool> isLoading = false.obs;
  Rx<bool> hideNewPassword = true.obs;
  Rx<bool> hideConfirmNewPassword  = true.obs;
  Rx<bool> hideOldPassword = true.obs;

  void toggleIsLoading(bool value) {
    isLoading.value = value;
    update();
  }

  void togglePasswordVisibility(String indicator) {
    if(indicator == 'old') {
      hideOldPassword.value =  !hideOldPassword.value;
    } else if (indicator == 'new') {
      hideNewPassword.value = !hideNewPassword.value;
    } else {
      hideConfirmNewPassword.value = !hideConfirmNewPassword.value;
    }

    update();
  }

  String? validator(String? value, String indicator) {

    if(indicator == 'new-pass' || indicator == 'old-pass') {
      if(value == null || value.isEmpty) return 'Password is required';
      if(value.length < 8) return 'Password should be atleast 8 characters';

      return null;
    } else if (indicator == 'confirm-new-pass') {
      if(value == null || value.isEmpty) return 'New password is required';
      if(value.length < 8) return 'Password should be atleast 8 characters';
      if(value != newPasswordController.value.text) return 'Passwords do not match';

      return null;
    }
  }

  bool validateData() {
    final validation = resetPassFormKey.value.currentState!.validate();
    return validation;
  }

  void resetAllInformation() {
    oldPasswordController.value.text = '';
    newPasswordController.value.text = '';
    confrimNewPasswordController.value.text = '';
    update();
  }

  Future<void> submitResetPasswordForNotLoggedInUser() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> details = {};

    final userEmail = prefs.getString(Constants.OTP_SENDER_EMAIL_KEY) ?? '';
    details['userNewPassword'] = confrimNewPasswordController.value.text.trim();
    details['email'] = userEmail;

    toggleIsLoading(true);

    final response = await UserServices.requestPasswordChangeForNotLoggedInUser(details: details);

    if(response['statusCode'] == 200) {

      await Future.delayed(const Duration(seconds: 2));

      resetAllInformation();
      
      MyCustomToast.showSuccessToast(response['message']);
      toggleIsLoading(false);
    }

  }

  Future<void> submitResetPasswordForLoggedInUser() async {

    final Map<String, String> details = {};
    details['userOldPassword'] = oldPasswordController.value.text.trim();
    details['userNewPassword'] = confrimNewPasswordController.value.text.trim();

    toggleIsLoading(true);

    final response = await UserServices.requestPasswordChangeForLoggedInUser(details: details);

    if(response['statusCode'] == 200) {

      await Future.delayed(const Duration(seconds: 2));

      resetAllInformation();
      
      MyCustomToast.showSuccessToast(response['message']);
      toggleIsLoading(false);
    }

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
    super.onInit();
  }

}