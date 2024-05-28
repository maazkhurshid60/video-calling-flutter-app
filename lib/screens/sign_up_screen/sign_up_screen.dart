// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/progress_indicator/progress_indicator.dart';
import 'package:video_calling_flutter_app/controllers/sign_up_controller.dart';
import 'package:video_calling_flutter_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';

import '../../components/dialog_boxes/account_created_successfull_dialog.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getMedia = Get.mediaQuery;
    return GetX<SignUpScreenController>(
      init: SignUpScreenController(),
      builder: (controller) => Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: getMedia.size.height,
          width: getMedia.size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/jpgs/bg_container.jpg',
                  ),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20.h, top: 20.h),
                  width: 159.w,
                  height: 79.h,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(57),
                      border: Border.all(
                          color: AppColors.royalBlueColor, width: 2.w)),
                  child: Center(
                    child: Icon(
                      Icons.video_call,
                      color: AppColors.royalBlueColor,
                      size: 60.w,
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 38.h),
                        child: Text(
                          'Create Account',
                          style: GoogleFonts.urbanist(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textBlackColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          'Enter your details below',
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp, fontWeight: FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 42.h),
                        child: Form(
                          key: controller.signUpFormKey.value,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                width: 358.w,
                                child: TextFormField(
                                  controller: controller.fullNameController.value,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.lightGreyColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.royalBlueColor,
                                            width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      hintText: 'Full Name',
                                      prefixIcon: const Icon(
                                        Icons.person_2_outlined,
                                        color: AppColors.textGreyColor,
                                      )),
                                  style: GoogleFonts.urbanist(),
                                  validator: (value) => controller.validator(value, 'full-name'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                width: 358.w,
                                child: TextFormField(
                                  controller: controller.emailController.value,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.lightGreyColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.royalBlueColor,
                                            width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      hintText: 'Email',
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: AppColors.textGreyColor,
                                      )),
                                  validator: (value) => controller.validator(value, 'email'),
                                  style: GoogleFonts.urbanist(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                width: 358.w,
                                child: TextFormField(
                                  controller: controller.passwordController.value,
                                  keyboardType: TextInputType.text,
                                  obscureText: controller.hidePassword.value,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.lightGreyColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.royalBlueColor,
                                            width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      hintText: 'Password',
                                      prefixIcon: const Icon(
                                        Icons.lock_outline_rounded,
                                        color: AppColors.textGreyColor,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () => controller.toggleShowPassword('password'),
                                          icon: Icon(
                                              controller.hidePassword.value ? Icons.remove_red_eye_outlined : Icons.remove_moderator_outlined))),
                                  validator: (value) => controller.validator(value, 'password'),
                                  style: GoogleFonts.urbanist(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                width: 358.w,
                                child: TextFormField(
                                  controller: controller.confirmNewPasswordController.value,
                                  keyboardType: TextInputType.text,
                                  obscureText: controller.hideConfirmPassword.value,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.lightGreyColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.royalBlueColor,
                                            width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      hintText: 'Confirm Password',
                                      prefixIcon: const Icon(
                                        Icons.lock_outline_rounded,
                                        color: AppColors.textGreyColor,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () => controller.toggleShowPassword('conf-password'),
                                          icon: Icon(
                                             controller.hideConfirmPassword.value ? Icons.remove_red_eye_outlined : Icons.remove_moderator_outlined))),
                                  style: GoogleFonts.urbanist(),
                                  validator: (value) => controller.validator(value, 'conf-pass'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                width: 358.w,
                                child: TextFormField(
                                  controller: controller.phoneNumberController.value,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.lightGreyColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.royalBlueColor,
                                            width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(58.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      hintText: 'Phone',
                                      prefixIcon: CountryCodePicker(
                                        padding: EdgeInsets.zero,
                                        onChanged: (pickedCountry) {
                                          controller.updateCountryInfo(pickedCountry);
                                        },
                                        flagDecoration: const BoxDecoration(
                                          shape: BoxShape.circle
                                        ),
                                        flagWidth: 60.w,
                                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                        initialSelection: controller.countryInformation['code'],
                                        // favorite: ['+39','FR'],
                                        // optional. Shows only country name and flag
                                        showCountryOnly: false,
                                        // optional. Shows only country name and flag when popup is closed.
                                        showOnlyCountryWhenClosed: false,
                                        // optional. aligns the flag and the Text left
                                        alignLeft: false,
                                        
                                      ),
                                      
                                  ),
                                  style: GoogleFonts.urbanist(),
                                  validator: (value) => controller.validator(value, 'phone'),
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                                  items: const [
                                    DropdownMenuItem(
                                        value: 'MALE',
                                        child: Text(
                                          'Male',
                                        )),
                                    DropdownMenuItem(
                                        value: 'FEMALE',
                                        child: Text(
                                          'Female',
                                        )),
                                  ],
                                  hint: const Text('Select Gender'),
                                  onChanged: (value) {
                                    log('Selected Gender: $value');
                                    controller.updateGender(value!);
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(58.r),
                                          borderSide: const BorderSide(
                                              color: AppColors.lightGreyColor,
                                              width: 1))),
                                  style: GoogleFonts.urbanist(
                                      color: AppColors.textBlackColor,
                                      fontSize: 16.sp),
                                  validator: (value) => controller.validator(value, 'gender'),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 48.h),
                                width: 358.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: controller.isTermsAreAccepted.value,
                                      onChanged: (value) {
                                        controller.toggleTermsAndConditions();
                                      },
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.urbanist(
                                              color: AppColors.textBlackColor),
                                          children: [
                                            const TextSpan(
                                              text: 'Yes, agree with the ',
                                            ),
                                            TextSpan(
                                              text: 'Terms and & Conditions ',
                                              style: GoogleFonts.urbanist(
                                                  color: AppColors.royalBlueColor,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                            const TextSpan(
                                              text: '& ',
                                            ),
                                            TextSpan(
                                              text: 'Privacy Policy',
                                              style: GoogleFonts.urbanist(
                                                  color: AppColors.royalBlueColor,
                                                  decoration:
                                                      TextDecoration.underline),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
                  child: ElevatedButton(
                    onPressed: !controller.isLoading.value ? () async {
                      final result = controller.validateData();
                      if(!result) {
                        MyCustomToast.showErrorToast('Invalid data provided');
                        return;
                      }

                      final isTermsAreAccepted = controller.validateTermsAndConditions();
                      if(!isTermsAreAccepted) {
                        MyCustomToast.showErrorToast('Please select Terms and Condition checkbox');
                        return;
                      }
                      try {
                        final result = await controller.signUpUser();
                        if(result['statusCode'] == 201) {
                          showAccountCreatedSuccessfullyDialogBox(context);
                        }
                      } catch (e) {
                        controller.toggleIsloading(false);
                        MyCustomToast.showErrorToast(e.toString());
                      }

                    } : null,
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 21.h),
                        fixedSize: Size.fromWidth(Get.mediaQuery.size.width),
                        backgroundColor: AppColors.royalBlueColor,
                        foregroundColor: AppColors.whiteColor),
                    child: !controller.isLoading.value ? Text(
                      'Sign Up',
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ) : const MyProgressIndicator(AppColors.royalBlueColor),
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: GoogleFonts.urbanist(
                            fontSize: 16.sp, color: AppColors.textGreyColor),
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.off(() => const SignInScreen());
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.urbanist(
                                fontSize: 16.sp,
                                color: AppColors.royalBlueColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
