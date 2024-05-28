// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/dialog_boxes/password_changed_successfully.dart';
import 'package:video_calling_flutter_app/components/progress_indicator/progress_indicator.dart';
import 'package:video_calling_flutter_app/controllers/reset_password_screen_controller.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';

import '../../utils/toasts.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getMedia = Get.mediaQuery;
    return GetX<ResetPasswordScreenController>(
      init: ResetPasswordScreenController(),
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
                          'Reset Password',
                          style: GoogleFonts.urbanist(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textBlackColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          'Enter your new password',
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp, fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 42.h),
                        child: Form(
                          key: controller.resetPassFormKey.value,
                          child: Column(
                            children: [
                              if(controller.isUserAlreadyLoggedIn.value)
                              SizedBox(
                                width: 358.w,
                                child: TextFormField(
                                  controller: controller.oldPasswordController.value,
                                  keyboardType: TextInputType.text,
                                  obscureText: controller.hideOldPassword.value,
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
                                      hintText: 'Enter Old Password',
                                      prefixIcon: const Icon(
                                        Icons.lock_outline_rounded,
                                        color: AppColors.textGreyColor,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            controller.togglePasswordVisibility('old');
                                          },
                                          icon: Icon(
                                              controller.hideOldPassword.value ? Icons.remove_red_eye_outlined : Icons.remove_moderator_outlined))),
                                  style: GoogleFonts.urbanist(),
                                  validator: (value) => controller.validator(value, 'old-pass'),
                                ),
                              ),
                              SizedBox(height: 16.h,),
                              SizedBox(
                                width: 358.w,
                                child: TextFormField(
                                  controller: controller.newPasswordController.value,
                                  keyboardType: TextInputType.text,
                                  obscureText: controller.hideNewPassword.value,
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
                                      hintText: 'Enter New Password',
                                      prefixIcon: const Icon(
                                        Icons.lock_outline_rounded,
                                        color: AppColors.textGreyColor,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            controller.togglePasswordVisibility('new');
                                          },
                                          icon: Icon(
                                              controller.hideNewPassword.value ? Icons.remove_red_eye_outlined : Icons.remove_moderator_outlined))),
                                  style: GoogleFonts.urbanist(),
                                  validator: (value) => controller.validator(value, 'new-pass'),
                                ),
                              ),
                              SizedBox(height: 16.h,),
                              SizedBox(
                                width: 358.w,
                                child: TextFormField(
                                  controller: controller.confrimNewPasswordController.value,
                                  keyboardType: TextInputType.text,
                                  obscureText: controller.hideConfirmNewPassword.value,
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
                                      hintText: 'Confirm New Password',
                                      prefixIcon: const Icon(
                                        Icons.lock_outline_rounded,
                                        color: AppColors.textGreyColor,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            controller.togglePasswordVisibility('confirm-new');
                                          },
                                          icon: Icon(
                                              controller.hideConfirmNewPassword.value ? Icons.remove_red_eye_outlined : Icons.remove_moderator_outlined))),
                                  style: GoogleFonts.urbanist(),
                                  validator: (value) => controller.validator(value, 'confirm-new-pass'),
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
                      if(result) {
                          try {
                            if(controller.isUserAlreadyLoggedIn.value) {
                            await controller.submitResetPasswordForLoggedInUser();
                          } else {
                            await controller.submitResetPasswordForNotLoggedInUser();
                          }
                          showPasswordChangedSuccessfullyDialogBox(context);
                        } catch (e) {
                          controller.toggleIsLoading(false);
                          MyCustomToast.showErrorToast(e.toString());
                        }
                        
                      }
                    } : null,
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 21.h),
                        fixedSize: Size.fromWidth(Get.mediaQuery.size.width),
                        backgroundColor: AppColors.royalBlueColor,
                        disabledBackgroundColor: AppColors.whiteColor,
                        foregroundColor: AppColors.whiteColor),
                    child: !controller.isLoading.value ? Text(
                      'Reset Password',
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ) : const MyProgressIndicator(AppColors.royalBlueColor),
                  ),
                ),              
              ],
            ),
          ),
        ),
      ),
    );
  }
}