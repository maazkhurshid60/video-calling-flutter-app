import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/progress_indicator/progress_indicator.dart';
import 'package:video_calling_flutter_app/controllers/edit_profile_screen_controller.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';

class ShowImageInDialogBox extends StatelessWidget {
  final File pickedImage;
  const ShowImageInDialogBox(this.pickedImage, {super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        width: 382.w,
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 320.w,
              width: 320.w,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: AppColors.greyShade3Color, width: 1),
              ),
              child: Image.file(pickedImage, fit: BoxFit.contain,),
            ),
            
            Row(
              children: [
                Expanded(
                  child: GetBuilder<EditProfileScreenController>(
                    builder:(controller) => Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10.h),
                      child: ElevatedButton(
                        onPressed: !controller.isImageLoading.value ? () {
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
                  child: GetBuilder<EditProfileScreenController>(
                    builder: (controller) {
                      return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 10.h),
                          child: ElevatedButton(
                            onPressed: !controller.isImageLoading.value ? () async {
                              await controller.updateUserProfile(pickedImage);
                              Get.back();
                            } : null,
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 18.h),
                                backgroundColor: AppColors.royalBlueColor,
                                disabledBackgroundColor: AppColors.whiteColor,
                                foregroundColor: AppColors.whiteColor),
                            child: !controller.isImageLoading.value ? Text(
                              'Upload',
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp),
                            ) : const MyProgressIndicator(AppColors.royalBlueColor),
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


void showPickedImageInDialogBox(BuildContext context, File pickedImage) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ShowImageInDialogBox(pickedImage),
  );
}