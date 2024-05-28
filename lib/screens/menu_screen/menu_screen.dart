import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/progress_indicator/progress_indicator.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/screens/edit_user_profile_screen/edit_user_profile_screen.dart';
import 'package:video_calling_flutter_app/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:video_calling_flutter_app/screens/home_screen/home_screen.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';
import 'package:video_calling_flutter_app/utils/constants.dart';

import '../../components/app_bar/app_bar.dart';
import '../../components/dialog_boxes/delete_account_dialog.dart';
import '../../utils/toasts.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {

    void showDeletAccountDialog() {
      showAccountDeleteDialogBox(context);
    }

    void gotoHomeScreen() {
      Get.off(() => const HomeScreen());
    }

    final menuItemsList = [
      {
        'id': 1,
        'title': 'Edit Profile',
        'icon': 'assets/jpgs/edit_icon.png',
        'onClick': () {
          Get.to(() => const EditUserProfileScreen());
        },
      },
      {
        'id': 2,
        'title': 'Privacy Policy',
        'icon': 'assets/jpgs/privacy_policy_icon.png',
        'onClick': () {
        
        },
      },
      {
        'id': 3,
        'title': 'Change Password',
        'icon': 'assets/jpgs/change_pass_icon.png',
        'onClick': () {
          Get.to(() =>  const ForgotPasswordScreen(isFromSignIn: false,));
        },
      },
      {
        'id': 4,
        'title': 'Delete Account',
        'icon': 'assets/jpgs/delete_icon.png',
        'onClick': () {
          showDeletAccountDialog();
        },
      },
      {
        'id': 5,
        'title': 'About',
        'icon': 'assets/jpgs/about_icon.png',
        'onClick': () {},
      },
      {
        'id': 6,
        'title': 'Support',
        'icon': 'assets/jpgs/support_icon.png',
        'onClick': () {},
      }
  ];

    return SafeArea(
      child: Scaffold(
        appBar: customAppBarForMenu('User Profile', gotoHomeScreen),
        body: SingleChildScrollView(
          child: SizedBox(
            width: Get.mediaQuery.size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GetBuilder<UserController>(
                  builder: (controller) {
            
                    if(controller.user.value?.userProfileImage != '') {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(controller.user.value!.userProfileImage),
                        radius: 50.w,
                      );
                    }
            
                    return CircleAvatar(
                      radius: 50.w,
                      child: Icon(Icons.person_outline_rounded, color: AppColors.royalBlueColor, size: 40.w,),
                    );
                  },
                ),
                SizedBox(height: 26.h,),
                GetBuilder<UserController>(
                  builder: (controller) {
                    return Text(controller.user.value!.userFullName, style: GoogleFonts.urbanist(fontSize: 22.sp, color: AppColors.textGreyColor, fontWeight: FontWeight.bold),);
                  },
                ),
                SizedBox(height: 35.h,),
                for(Map<String, dynamic> menu in menuItemsList)...[
                  GestureDetector(
                    onTap: () {
                      menu['onClick']();
                    },
                    child: Container(
                      margin:EdgeInsets.only(left: 20.w, right: 20.w, bottom: 19.h),
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                      width: Get.mediaQuery.size.width,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: AppColors.greyShade3Color, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(menu['icon'], width: 18.w,),
                              SizedBox(width: 12.w,),
                              Text(menu['title'], style: GoogleFonts.urbanist(fontSize: 18.sp, fontWeight: FontWeight.w500),)
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios, color: AppColors.textGreyColor)
                        ],
                      ),
                    ),
                  ),
                ],
                GetBuilder<UserController>(
                  builder: (controller) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.w),
                      child: ElevatedButton(
                        onPressed: !controller.isLogoutLoading.value ? () async {
                          try {
                            await controller.logoutUser();                           
                          } catch (e) {
                            controller.toggelLogoutLoading(false);
                            MyCustomToast.showErrorToast(e.toString());
                          }
                        } : null,
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 21.h),
                            fixedSize: Size.fromWidth(Get.mediaQuery.size.width),
                            backgroundColor: AppColors.royalBlueColor,
                            foregroundColor: AppColors.whiteColor),
                        child: !controller.isLogoutLoading.value ? Text(
                          'Logout',
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ) :const MyProgressIndicator(AppColors.royalBlueColor),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        )
        
      ),
    );
  }
}