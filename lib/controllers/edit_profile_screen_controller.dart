import 'dart:developer';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/models/user_model.dart';
import 'package:video_calling_flutter_app/screens/menu_screen/menu_screen.dart';
import 'package:video_calling_flutter_app/services/user_service.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';

class EditProfileScreenController extends GetxController {

  Rx<TextEditingController> fullNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;

  Rx<GlobalKey<FormState>> editFormKey = GlobalKey<FormState>().obs;

  Rx<String> initialDialCodeSelection = ''.obs;

  Rx<bool> isSaveLoading = false.obs;
  Rx<bool> isImageLoading = false.obs;

  
  void toggleImageLoading(bool value) {
    isImageLoading.value = value;
    update();
  }

  void toggleSaveLoading(bool value) {
    isSaveLoading.value = value;
    update();
  }



  RxMap<String, String> countryInformation = {
    'code': '',
    'name': '',
    'dial-code': '',
  }.obs;

  void updateCountryInfo(CountryCode country) {
    countryInformation['code'] = country.code ?? 'US';
    countryInformation['name'] = country.name ?? 'United States of America';
    countryInformation['dial-code'] = country.dialCode ?? '+1';
    update();
  }

  bool validateData() {
    final validation = editFormKey.value.currentState!.validate();
    return validation;
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

    } else if (indicator == 'phone') {
      if(value == null || value.isEmpty) return 'Phone number is required';
      if(value.length < 10) return 'Invalid phone number';

      return null;
    } 
    return null;

  }

  Future<void> saveProfile() async {

    Map<String, dynamic> accInformation = {};
    String defaultUserLanguage = 'en';
    String phoneNumber = phoneNumberController.value.text.trim();

    phoneNumber = phoneNumber.split(' ').join('-');

    String userPhoneNumberWithDialCode = '${countryInformation['dial-code'] == '' ? initialDialCodeSelection.value : countryInformation['dial-code']} $phoneNumber';

    accInformation['userFullName'] = fullNameController.value.text.trim();
    accInformation['userEmail'] = emailController.value.text.trim();
    accInformation['userPhoneNumber'] = userPhoneNumberWithDialCode;
    accInformation['userLanguage'] = defaultUserLanguage;

    toggleSaveLoading(true);

    final Map<String, dynamic> result = await UserServices.updateUserAccount(accInformation);
    final userJson = result['data'];

    final userModel = UserModel.fromJson(userJson);
    final userController = Get.find<UserController>();

    userController.user = userModel.obs;

    await Future.delayed(const Duration(seconds: 1));

    toggleSaveLoading(false);

    Get.off(() => const MenuScreen());

  }

    Future<void> updateUserProfile(File pickedImage) async {

    try {
      toggleImageLoading(true);
      final response = await UserServices.updateUserProfileImage(pickedImage);

      if(response['statusCode'] == 200) {
        final userJson = response['data'];
        final userModel = UserModel.fromJson(userJson);
        final userController = Get.find<UserController>();
        userController.user = userModel.obs;

        MyCustomToast.showSuccessToast('User Profile Image Updated!');

        await Future.delayed(const Duration(seconds: 1));

        toggleImageLoading(false);
        userController.update();
      }
    } catch (e) {
      toggleImageLoading(false);
      log(e.toString());
      MyCustomToast.showErrorToast('Something went wrong. Try again!');
    }

  }


  @override
  void onInit() async {
    final userController = Get.find<UserController>();

    final listOfStrings = userController.user.value!.userPhoneNumber.split(' ');
    initialDialCodeSelection.value = listOfStrings[0];
    final phoneNumber = listOfStrings[1];

    fullNameController.value.text = userController.user.value!.userFullName;
    emailController.value.text = userController.user.value!.userEmail;
    phoneNumberController.value.text = phoneNumber;
    super.onInit();
  }

}