import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_calling_flutter_app/models/call_history_model.dart';
import 'package:video_calling_flutter_app/screens/admin_approval_screen/admin_approval_screen.dart';
import 'package:video_calling_flutter_app/services/user_service.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';

class DialNowScreenController extends GetxController {

  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;

  Rx<GlobalKey<FormState>> phoneNumFormKey = GlobalKey<FormState>().obs;

  Rx<bool> isLoading = false.obs;

  RxMap<String, String> countryInformation = {
    'code': '',
    'name': '',
    'dial-code': '',
  }.obs;

  void toggleIsLoading(bool value) {
    isLoading.value = value;
    update();
  }

  void updateCountryInfo(CountryCode country) {
    countryInformation['code'] = country.code ?? 'US';
    countryInformation['name'] = country.name ?? 'United States of America';
    countryInformation['dial-code'] = country.dialCode ?? '+1';
    update();
  }

  bool validateData() {
    final validation = phoneNumFormKey.value.currentState!.validate();
    return validation;
  }

  String? validator(String? value, String indicator) {

    if (indicator == 'phone') {
      if(value == null || value.isEmpty) return 'Phone number is required';
      if(value.length < 10) return 'Invalid phone number';

      return null;
    } 
    return null;

  }

  Future<void> makeACall() async {

    String phoneNumber = phoneNumberController.value.text.trim();
    phoneNumber = phoneNumber.split(' ').join('-');
    String userPhoneNumberWithDialCode = '${countryInformation['dial-code']} $phoneNumber';

    try {

      toggleIsLoading(true);

      // final socket = Get.find<HomeScreenController>().socket!;
      final response = await UserServices.makeACall(userPhoneNumberWithDialCode);

      if(response['statusCode'] == 200) {

        final callData = response['data'];
        final callModel = CallHistory.fromJson(callData);

        await Future.delayed(const Duration(seconds: 1));

        toggleIsLoading(false);

        Get.to(() => const AdminApprovalScreen(), arguments: {'callModel' : callModel});


      }
      
    } catch (e) {
      toggleIsLoading(false);
      MyCustomToast.showErrorToast('Something went wrong. Try again!');
    }

  }



}