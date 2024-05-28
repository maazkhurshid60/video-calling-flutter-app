import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/progress_indicator/progress_indicator.dart';
import 'package:video_calling_flutter_app/controllers/sign_in_controller.dart';
import 'package:video_calling_flutter_app/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:video_calling_flutter_app/screens/sign_up_screen/sign_up_screen.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';
import '../../theme/app_colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getMedia = Get.mediaQuery;
    return GetX<SignInScreenController>(
      init: SignInScreenController(),
      builder: (controller) {
        return Scaffold(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      width: 159.w,
                      height: 79.h,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(57),
                          border:
                              Border.all(color: AppColors.royalBlueColor, width: 2.w)),
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
                              'Welcome Back',
                              style: GoogleFonts.urbanist(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlackColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              'Enter your email and password',
                              style: GoogleFonts.urbanist(
                                  fontSize: 18.sp, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 42.h),
                            child: Form(
                              key: controller.signInformKey.value,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 358.w,
                                    child: TextFormField(
                                      controller: controller.emailController.value,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(58.r)),
                                            borderSide: const BorderSide(
                                                color: AppColors.lightGreyColor,
                                                width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(58.r)),
                                            borderSide: const BorderSide(
                                                color: AppColors.royalBlueColor,
                                                width: 1),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(58.r)),
                                            borderSide: const BorderSide(
                                                color: AppColors.redIconColor,
                                                width: 1),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(58.r)),
                                            borderSide: const BorderSide(
                                                color: AppColors.redIconColor,
                                                width: 1),
                                          ),
                                          hintText: 'Email',
                                          prefixIcon: const Icon(
                                            Icons.email_outlined,
                                            color: AppColors.textGreyColor,
                                          )),
                                      style: GoogleFonts.urbanist(),
                                      validator: (value) => controller.validator(value, 'email'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  SizedBox(
                                    width: 358.w,
                                    child: TextFormField(
                                      controller: controller.passwordController.value,
                                      keyboardType: TextInputType.text,
                                      obscureText: controller.hidePassword.value,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(58.r)),
                                            borderSide: const BorderSide(
                                                color: AppColors.lightGreyColor,
                                                width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(58.r)),
                                            borderSide: const BorderSide(
                                                color: AppColors.royalBlueColor,
                                                width: 1),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(58.r)),
                                            borderSide: const BorderSide(
                                                color: AppColors.redIconColor,
                                                width: 1),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(58.r)),
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
                                              onPressed: controller.toggleShowPassword,
                                              icon: Icon(
                                                  controller.hidePassword.value ? Icons.remove_red_eye_outlined : Icons.remove_moderator_outlined))),
                                      style: GoogleFonts.urbanist(),
                                      validator: (value) => controller.validator(value, 'password'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 48.h),
                                    width: 358.w,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () => Get.off(() => const ForgotPasswordScreen(isFromSignIn: true,)),
                                          child: Text(
                                            'Forgot Password?',
                                            style: GoogleFonts.urbanist(
                                                color: AppColors.textBlackColor,
                                                fontSize: 16.sp),
                                          ),
                                        )
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
                      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
                      child: ElevatedButton(
                        onPressed: !controller.isLoading.value ? () async {
                          final result = controller.validateData();
                          if(!result) {
                            MyCustomToast.showErrorToast('Invalid data provided');
                            return;
                          }

                          try {
                            await controller.loginUser();
                          } catch (e) {
                            controller.toggleIsLoading(false);
                            MyCustomToast.showErrorToast(e.toString());
                          }

                        } : null,
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 21.h),
                            fixedSize: Size.fromWidth(Get.mediaQuery.size.width),
                            backgroundColor: AppColors.royalBlueColor,
                            foregroundColor: AppColors.whiteColor),
                        child: !controller.isLoading.value ? Text(
                          'Login',
                          style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ) : const MyProgressIndicator(AppColors.royalBlueColor),
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account? ', style: GoogleFonts.urbanist(fontSize: 16.sp, color: AppColors.textGreyColor),),
                          GestureDetector(
                            onTap: () {
                              Get.off(() => const SignUpScreen());
                            },
                            child: Text('Sign Up', style: GoogleFonts.urbanist(fontSize: 16.sp, color: AppColors.royalBlueColor, fontWeight: FontWeight.bold),)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }

}
