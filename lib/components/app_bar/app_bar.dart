import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/screens/home_screen/home_screen.dart';
import 'package:video_calling_flutter_app/screens/menu_screen/menu_screen.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';

PreferredSizeWidget? customAppBar() {
  return AppBar(
          automaticallyImplyLeading: false,
          title: Text('Call History', style: GoogleFonts.urbanist(
            color: AppColors.royalBlueColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold
          ),),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            GetBuilder<UserController>(
              builder: (controller) {

                if(controller.user.value!.userProfileImage.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: GestureDetector(
                      onTap: () => Get.to(() => const MenuScreen()),
                      child: CircleAvatar(
                        radius: 26.r,
                        backgroundImage: NetworkImage(controller.user.value!.userProfileImage,),
                      ),
                    ),
                  );
                }


                return GestureDetector(
                  onTap: () => Get.to(() => const MenuScreen()),
                  child: Container (
                      height: 52.w,
                      width: 52.w,
                      margin: EdgeInsets.only(right: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: AppColors.greyShade3Color, width: 1),
                      ),
                      child: const Center(child: Icon(Icons.person_outline_rounded, color: AppColors.textGreyColor,),),
                    ),
                );

              },
            )
          ],
        );
}

PreferredSizeWidget? customAppBarForMenu(String title, VoidCallback callBack) {
  return AppBar(
          // leadingWidth: 20.w,
          automaticallyImplyLeading: false,
          title: Text(title, style: GoogleFonts.urbanist(
            color: AppColors.royalBlueColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold
          ),),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: callBack,
            child: Container(
              height: 40.w,
              width: 40.w,
              margin: EdgeInsets.only(left: 20.w, top: 10.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: AppColors.greyShade3Color, width: 1),
              ),
              child: const Center(
                child: Icon(Icons.arrow_back_ios_rounded, color: AppColors.textGreyColor,),
              ),
            ),
          ),
        );
}