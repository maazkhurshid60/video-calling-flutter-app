import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/progress_indicator/progress_indicator.dart';
import 'package:video_calling_flutter_app/controllers/forgot_password_screen_controller.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/screens/menu_screen/menu_screen.dart';
import 'package:video_calling_flutter_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final bool isFromSignIn;

  const ForgotPasswordScreen({super.key, required this.isFromSignIn});

  @override
  Widget build(BuildContext context) {
    final getMedia = Get.mediaQuery;
    return GetX<ForgotPasswordScreenController>(
      init: ForgotPasswordScreenController(),
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
                            'Forgot Password',
                            style: GoogleFonts.urbanist(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlackColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Text(
                            !isFromSignIn ? 'Confirm your email' : 'Type your email address',
                            style: GoogleFonts.urbanist(
                                fontSize: 18.sp, fontWeight: FontWeight.normal),
                          ),
                        ),
                        if(isFromSignIn)
                        Form(
                          key: controller.forgotPassformKey.value,
                          child: Container(
                            width: 358.w,
                            margin: EdgeInsets.symmetric(vertical: 42.h),
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
                        ),
                        if(!isFromSignIn)
                        GetBuilder<UserController>(
                          builder: (controller) => Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 27.w),
                            margin: EdgeInsets.symmetric(vertical: 42.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.r),
                              border: Border.all(color: AppColors.royalBlueColor, width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60.w,
                                  width: 60.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.greyShade1Color,
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.mail_outlined, color: AppColors.textGreyColor,),
                                  ),
                                ),
                                SizedBox(width: 16.w,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Send OTP via Email', style: GoogleFonts.urbanist(color: AppColors.textGreyColor, fontSize: 16.sp),),
                                    SizedBox(height: 5.h,),
                                    Text(controller.user.value!.userEmail, style: GoogleFonts.urbanist(color: AppColors.textBlackColor, fontSize: 18.sp, fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 32.h),
                            child: ElevatedButton(
                              onPressed: !controller.isLoading.value ? () {
                                if(isFromSignIn) {
                                  Get.off(() => const SignInScreen());
                                } else {
                                  Get.off(() => const MenuScreen());
                                }
                              } : null,
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 21.h),
                                  backgroundColor: AppColors.whiteColor,
                                  disabledBackgroundColor: AppColors.greyShade2Color,
                                  side: const BorderSide(color: AppColors.royalBlueColor, width: 1),
                                  foregroundColor: AppColors.whiteColor),
                              child: Text(
                                'Back',
                                style: GoogleFonts.urbanist(color: AppColors.royalBlueColor, fontWeight: FontWeight.bold, fontSize: 18.sp),
                              ),
                            ),
                          ),
                        ),  
                        SizedBox(width: 10.w,),
                        Expanded(
                          child: GetBuilder<UserController>(
                            builder: (uCont) => Container(
                              margin: EdgeInsets.symmetric(vertical: 32.h),
                              child: ElevatedButton(
                                onPressed: !controller.isLoading.value ? () async {
                                  if(isFromSignIn) {
                                    final result = controller.validateData();
                                    if(!result) {
                                      MyCustomToast.showErrorToast('Invalid data provided');
                                      return;
                                    }
                            
                                    await controller.submitForgotPasswordRequest(controller.emailController.value.text.trim());
                                  } else {
                                    await  controller.submitForgotPasswordRequest(uCont.user.value!.userEmail);
                                  }
                            
                                } : null,
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 21.h),
                                    disabledBackgroundColor: AppColors.whiteColor,
                                    backgroundColor: AppColors.royalBlueColor,
                                    foregroundColor: AppColors.whiteColor),
                                child: !controller.isLoading.value ? Text(
                                  'Continue',
                                  style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 18.sp),
                                ) : const MyProgressIndicator(AppColors.royalBlueColor),
                              ),
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
        );
      },
    );
  }
}