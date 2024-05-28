import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:video_calling_flutter_app/components/dialog_boxes/account_created_successfull_dialog.dart';
import 'package:video_calling_flutter_app/services/user_service.dart';

class SignUpScreenController extends GetxController {

  Rx<TextEditingController> fullNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmNewPasswordController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;

  Rx<GlobalKey<FormState>> signUpFormKey = GlobalKey<FormState>().obs;

  Rx<bool> hidePassword = true.obs;
  Rx<bool> hideConfirmPassword = true.obs;
  Rx<bool> isTermsAreAccepted = false.obs;

  Rx<String> selectedGender = ''.obs;
  RxMap<String, String> countryInformation = {
    'code': 'US',
    'name': 'United States of America',
    'dial-code': '+1',
  }.obs;

  Rx<bool> isLoading = false.obs;

  void toggleTermsAndConditions() {
    isTermsAreAccepted.value = !isTermsAreAccepted.value;
  }

  void toggleIsloading(bool value) {
    isLoading.value = value;
    update();
  }

  void updateCountryInfo(CountryCode country) {
    countryInformation['code'] = country.code ?? 'US';
    countryInformation['name'] = country.name ?? 'United States of America';
    countryInformation['dial-code'] = country.dialCode ?? '+1';
    update();
  }

  void updateGender(String gender) {
    selectedGender.value = gender;
    update();
  }

  void toggleShowPassword(String indicator) {
    if(indicator == 'password') {
      hidePassword.value = !hidePassword.value;
    } else if(indicator == 'conf-password') {
      hideConfirmPassword.value = !hideConfirmPassword.value;
    }
    update();
  }

  bool validateData() {
    final validation = signUpFormKey.value.currentState!.validate();
    return validation;
  }

  bool validateTermsAndConditions() {
    if(isTermsAreAccepted.value) {
      return true;
    }else {
      return false;
    }
  }

  String? validator(String? value, String indicator) {

    if(indicator == 'email') {
      final regEx = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
      if(value == null || value.isEmpty) return 'Email is required';
      if(!regEx.hasMatch(value)) return 'Email is invalid';


      return null;

    } else if(indicator == 'full-name') {
      if(value == null || value.isEmpty) return 'Full name is required';
      if (value.length < 3) return 'Wrong full name';

      return null;

    } else if(indicator == 'password') {
      if(value == null || value.isEmpty) return 'Password is required';
      if(value.length < 8) return 'Password should be atleast 8 characters';

      return null;

    } else if (indicator == 'conf-pass') {
      if(value == null || value.isEmpty) return 'Confirm Password is required';

      if(value != passwordController.value.text) return 'Confirm password doesn\'t match with password';

      return null;
    } else if (indicator == 'phone') {
      if(value == null || value.isEmpty) return 'Phone number is required';
      if(value.length < 10) return 'Invalid phone number';

      return null;
    } else if (indicator == 'gender') {
      if(value == null || value.isEmpty) return 'Please select your gender';

      return null;
    }

    return null;

  }

  void resetAllInformation() {
    fullNameController.value.text = '';
    emailController.value.text = '';
    passwordController.value.text = '';
    confirmNewPasswordController.value.text = '';
    phoneNumberController.value.text = '';
    update();
  }

  Future<Map<String, dynamic>> signUpUser() async {

    Map<String, dynamic> accInformation = {};
    String defaultUserLanguage = 'en';
    String phoneNumber = phoneNumberController.value.text.trim();

    phoneNumber = phoneNumber.split(' ').join('-');

    String userPhoneNumberWithDialCode = '${countryInformation['dial-code']} $phoneNumber';

    accInformation['userFullName'] = fullNameController.value.text.trim();
    accInformation['userEmail'] = emailController.value.text.trim();
    accInformation['userPhoneNumber'] = userPhoneNumberWithDialCode;
    accInformation['userPassword'] = passwordController.value.text.trim();
    accInformation['userGender'] = selectedGender.value;
    accInformation['userLanguage'] = defaultUserLanguage;

    toggleIsloading(true);

    final Map<String, dynamic> result = await UserServices.creatUserAccount(accInformation);
    log(result.toString());

    resetAllInformation();

    await Future.delayed(const Duration(seconds: 1));

    toggleIsloading(false);

    return result;

  }

}