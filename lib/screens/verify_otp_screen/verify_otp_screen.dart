import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/progress_indicator/progress_indicator.dart';
import 'package:video_calling_flutter_app/controllers/verify_otp_screen_controller.dart';
import 'package:video_calling_flutter_app/screens/home_screen/home_screen.dart';
import 'package:video_calling_flutter_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';

class VerifyOTPScreen extends StatelessWidget {
  const VerifyOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getMedia = Get.mediaQuery;
    return GetX<VerifyOTPScreenController>(
      init: VerifyOTPScreenController(),
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
                          'Verify OTP',
                          style: GoogleFonts.urbanist(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textBlackColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          'We have sent OTP to ${controller.userEmailAddress.value}',
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp, fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 42.h, bottom: 20.h),
                        child: Form(
                          key: controller.otpFormKey.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100.h,
                                width: 74.w,
                                child: TextFormField(
                                  controller: controller.otpNum1.value,
                                  textAlign: TextAlign.center,
                                  autofocus: true,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.lightGreyColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.royalBlueColor,
                                            width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                    ),
                                    maxLines: 1,
                                    onChanged: (value) {
                                      FocusScope.of(context).requestFocus(controller.focusNode1.value);
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  style: GoogleFonts.urbanist(fontSize: 24.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 16.h,),
                              SizedBox(
                                height: 100.h,
                                width: 74.w,
                                child: TextFormField(
                                  controller: controller.otpNum2.value,
                                  textAlign: TextAlign.center,
                                  focusNode: controller.focusNode1.value,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.lightGreyColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.royalBlueColor,
                                            width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                    ),
                                    maxLines: 1,
                                    onChanged: (value) {
                                      FocusScope.of(context).requestFocus(controller.focusNode2.value);
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  style: GoogleFonts.urbanist(fontSize: 24.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 16.h,),
                              SizedBox(
                                height: 100.h,
                                width: 74.w,
                                child: TextFormField(
                                  controller: controller.otpNum3.value,
                                  textAlign: TextAlign.center,
                                  focusNode: controller.focusNode2.value,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.lightGreyColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.royalBlueColor,
                                            width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                    ),
                                    maxLines: 1,
                                    onChanged: (value) {
                                      FocusScope.of(context).requestFocus(controller.focusNode3.value);
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  style: GoogleFonts.urbanist(fontSize: 24.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 16.h,),
                              SizedBox(
                                height: 100.h,
                                width: 74.w,
                                child: TextFormField(
                                  controller: controller.otpNum4.value,
                                  textAlign: TextAlign.center,
                                  focusNode: controller.focusNode3.value,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.lightGreyColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.royalBlueColor,
                                            width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.r)),
                                        borderSide: const BorderSide(
                                            color: AppColors.redIconColor,
                                            width: 1),
                                      ),
                                    ),
                                    maxLines: 1,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  style: GoogleFonts.urbanist(fontSize: 24.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
      
                      const OTPTimerWidget(),
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
                            onPressed: !controller.isVerifying.value ? () {
                              if(controller.isUserAlreadyLoggedIn.value) {
                                Get.off(() => const HomeScreen());
                              } else {
                                Get.off(() => const SignInScreen());
                              }
                            } : null,
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 21.h),
                                backgroundColor: AppColors.whiteColor,
                                disabledBackgroundColor: AppColors.whiteColor,
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
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 32.h),
                          child: ElevatedButton(
                            onPressed: !controller.isVerifying.value ? () {
                              controller.verifyOTP();
                            } : null,
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 21.h),
                                backgroundColor: AppColors.royalBlueColor,
                                disabledBackgroundColor: AppColors.whiteColor,
                                foregroundColor: AppColors.whiteColor),
                            child: !controller.isVerifying.value ? Text(
                              'Verify',
                              style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 18.sp),
                            ) : const MyProgressIndicator(AppColors.royalBlueColor),
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
      ),
    );
  }
}

class OTPTimerWidget extends StatefulWidget {
  const OTPTimerWidget({super.key});

  @override
  State<OTPTimerWidget> createState() => _OTPTimerWidgetState();
}

class _OTPTimerWidgetState extends State<OTPTimerWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOTPScreenController>(
      builder: (controller) => Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: !controller.isResendOTPBtnPressed.value ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('00:${controller.timerSeconds.value == 0 ? '00' : controller.timerSeconds.value}', style: GoogleFonts.urbanist(fontSize: 16.sp, color: AppColors.greyShade2Color),),
            TextButton(
              onPressed: controller.isResendBtnActive.value ? () async {
                await controller.submitResendOTPRequest();
              } : null,
              child: Text('Resend OTP', style: GoogleFonts.urbanist(fontSize: 16.sp, color: controller.isResendBtnActive.value ? AppColors.royalBlueColor : AppColors.lightGreyColor, fontWeight: FontWeight.bold),),
            ),
          ],
        ) : Text('OTP Sent!', style: GoogleFonts.urbanist(color: AppColors.royalBlueColor, fontSize: 18.sp, fontWeight: FontWeight.w600),),
      ),
    );
  }
}