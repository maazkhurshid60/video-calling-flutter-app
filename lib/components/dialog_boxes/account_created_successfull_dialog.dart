
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';

class AccountCreatedSuccessfullyDialogBox extends StatelessWidget {
  const AccountCreatedSuccessfullyDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            Text('Account Created Successfully', style: GoogleFonts.urbanist(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppColors.textBlackColor,), textAlign: TextAlign.center,),
            SizedBox(height: 10.h,),
            Text('Your account has successfully created.', style: GoogleFonts.urbanist(fontSize: 20.sp, fontWeight: FontWeight.w500, color: AppColors.textBlackColor,), textAlign: TextAlign.center,),
            SizedBox(height: 20.h,),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: 10.h),
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.off(() => const SignInScreen());
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    fixedSize: Size.fromWidth(Get.mediaQuery.size.width),
                    backgroundColor: AppColors.royalBlueColor,
                    foregroundColor: AppColors.whiteColor),
                child: Text(
                  'Back to Login',
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.bold, fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void showAccountCreatedSuccessfullyDialogBox(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => const AccountCreatedSuccessfullyDialogBox(),
  );
}