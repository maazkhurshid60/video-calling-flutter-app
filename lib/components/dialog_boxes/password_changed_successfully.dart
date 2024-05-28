import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/screens/home_screen/home_screen.dart';
import 'package:video_calling_flutter_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';

class PasswordChangedSuccessfullyDialogBox extends StatelessWidget {
  const PasswordChangedSuccessfullyDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: AppColors.whiteColor,
        child: Container(
          width: 382.w,
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/jpgs/check_success.png', width: 149.w, height: 149.w,),
              SizedBox(height: 10.h,),
              Text('Password Changed Successfully', style: GoogleFonts.urbanist(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppColors.textBlackColor,), textAlign: TextAlign.center,),
              SizedBox(height: 10.h,),
              Text('Your password has been changed successfully.', style: GoogleFonts.urbanist(fontSize: 20.sp, fontWeight: FontWeight.w500, color: AppColors.textBlackColor,), textAlign: TextAlign.center,),
              SizedBox(height: 20.h,),
              GetBuilder<UserController>(
                builder: (controller) => Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.h),
                  child: ElevatedButton(
                    onPressed: () {
                      if(controller.user.value != null) {
                        Get.offAll(() => const HomeScreen());
                      } else {
                        Get.offAll(() => const SignInScreen());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        fixedSize: Size.fromWidth(Get.mediaQuery.size.width),
                        backgroundColor: AppColors.royalBlueColor,
                        foregroundColor: AppColors.whiteColor),
                    child: Text(
                      controller.user.value != null ? 'Back to Home' : 'Back to Login',
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void showPasswordChangedSuccessfullyDialogBox(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => const PasswordChangedSuccessfullyDialogBox(),
  );
}