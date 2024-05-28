import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/progress_indicator/progress_indicator.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';

import '../../theme/app_colors.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

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
            Text('Delete Account', style: GoogleFonts.urbanist(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppColors.textBlackColor,), textAlign: TextAlign.center,),
            SizedBox(height: 10.h,),
            Text('Do you really wants to delete your account?', style: GoogleFonts.urbanist(fontSize: 20.sp, fontWeight: FontWeight.w500, color: AppColors.textBlackColor,), textAlign: TextAlign.center,),
            SizedBox(height: 20.h,),
            Row(
              children: [
                Expanded(
                  child: GetBuilder<UserController>(
                    builder:(controller) => Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10.h),
                      child: ElevatedButton(
                        onPressed: !controller.isAccountDeleteLoading.value ? () {
                          Get.back();
                        } : null,
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            shape: const StadiumBorder(side: BorderSide(color: AppColors.royalBlueColor, width: 1)),
                            foregroundColor: AppColors.whiteColor,
                            disabledBackgroundColor: AppColors.whiteColor,
                          ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.urbanist(
                              color: AppColors.royalBlueColor,
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: GetBuilder<UserController>(
                    builder: (controller) {
                      return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 10.h),
                          child: ElevatedButton(
                            onPressed: !controller.isAccountDeleteLoading.value ? () async {
                              await controller.deleteUserAccount();
                            } : null,
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 18.h),
                                backgroundColor: AppColors.redIconColor,
                                disabledBackgroundColor: AppColors.whiteColor,
                                foregroundColor: AppColors.whiteColor),
                            child: !controller.isAccountDeleteLoading.value ? Text(
                              'Delete',
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp),
                            ) : const MyProgressIndicator(AppColors.redIconColor),
                          ),
                        );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



void showAccountDeleteDialogBox(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => const DeleteAccountDialog(),
  );
}