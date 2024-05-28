// ignore_for_file: use_build_context_synchronously

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/app_bar/app_bar.dart';
import 'package:video_calling_flutter_app/components/dialog_boxes/upload_user_image_dialog.dart';
import 'package:video_calling_flutter_app/components/progress_indicator/progress_indicator.dart';
import 'package:video_calling_flutter_app/controllers/edit_profile_screen_controller.dart';
import 'package:video_calling_flutter_app/screens/menu_screen/menu_screen.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';

import '../../controllers/user_controller.dart';
import '../../theme/app_colors.dart';
import '../../utils/image_picker.dart';


class EditUserProfileScreen extends StatelessWidget {
  const EditUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void gotoMenuScreen() {
      Get.off(() => const MenuScreen());
    }

    return GetX<EditProfileScreenController>(
      init: EditProfileScreenController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            appBar: customAppBarForMenu('Edit Profile', gotoMenuScreen),
            body: SingleChildScrollView(
              child: SizedBox(
                width: Get.mediaQuery.size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder<UserController>(
                      builder: (userCont) {
                
                        if(userCont.user.value?.userProfileImage != '') {
                          return CircleAvatar(
                            backgroundImage: NetworkImage(userCont.user.value!.userProfileImage),
                            radius: 50.w,
                          );
                        }
                
                        return CircleAvatar(
                          radius: 50.w,
                          child: Icon(Icons.person_outline_rounded, color: AppColors.royalBlueColor, size: 40.w,),
                        );
                      },
                    ),
                    SizedBox(height: 16.h,),
                    TextButton.icon(
                      onPressed: () async {
                        final pickedImage = await pickImageFromGallery();
                        showPickedImageInDialogBox(context, pickedImage);
                      },
                      label: Text('Edit Image', style: GoogleFonts.urbanist(color: AppColors.royalBlueColor,),),
                      icon: const Icon(Icons.edit_outlined, color: AppColors.royalBlueColor,),
                    ),
                    SizedBox(height: 35.h,),
                    Form(
                      key: controller.editFormKey.value,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
                            child: TextFormField(
                              controller: controller.fullNameController.value,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
                                    borderSide: const BorderSide(
                                        color: AppColors.lightGreyColor,
                                        width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
                                    borderSide: const BorderSide(
                                        color: AppColors.royalBlueColor,
                                        width: 1),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
                                    borderSide: const BorderSide(
                                        color: AppColors.redIconColor,
                                        width: 1),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
                                    borderSide: const BorderSide(
                                        color: AppColors.redIconColor,
                                        width: 1),
                                  ),
                                  hintText: 'Full Name',
                                  prefixIcon: const Icon(
                                    Icons.person_2_outlined,
                                    color: AppColors.textGreyColor,
                                  )),
                              style: GoogleFonts.urbanist(),
                              validator: (value) => controller.validator(value, 'full-name'),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
                            child: TextFormField(
                              controller: controller.emailController.value,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
                                    borderSide: const BorderSide(
                                        color: AppColors.lightGreyColor,
                                        width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
                                    borderSide: const BorderSide(
                                        color: AppColors.royalBlueColor,
                                        width: 1),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
                                    borderSide: const BorderSide(
                                        color: AppColors.redIconColor,
                                        width: 1),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
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

                          Container(
                            margin: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
                            child: TextFormField(
                              controller: controller.phoneNumberController.value,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
                                    borderSide: const BorderSide(
                                        color: AppColors.lightGreyColor,
                                        width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
                                    borderSide: const BorderSide(
                                        color: AppColors.royalBlueColor,
                                        width: 1),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
                                    borderSide: const BorderSide(
                                        color: AppColors.redIconColor,
                                        width: 1),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(58.r)),
                                    borderSide: const BorderSide(
                                        color: AppColors.redIconColor,
                                        width: 1),
                                  ),
                                  hintText: 'Phone',
                                  prefixIcon: CountryCodePicker(
                                    padding: EdgeInsets.zero,
                                    onChanged: (pickedCountry) {
                                      controller.updateCountryInfo(pickedCountry);
                                    },
                                    flagDecoration: const BoxDecoration(
                                      shape: BoxShape.circle
                                    ),
                                    flagWidth: 60.w,
                                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                    initialSelection: controller.initialDialCodeSelection.value,
                                    // favorite: ['+39','FR'],
                                    // optional. Shows only country name and flag
                                    showCountryOnly: false,
                                    // optional. Shows only country name and flag when popup is closed.
                                    showOnlyCountryWhenClosed: false,
                                    // optional. aligns the flag and the Text left
                                    alignLeft: false,
                                    
                                  ),
                                  
                              ),
                              style: GoogleFonts.urbanist(),
                              validator: (value) => controller.validator(value, 'phone'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.w),
                      child: ElevatedButton(
                        onPressed: !controller.isSaveLoading.value ? () async {
                          final result = controller.validateData();
                          if(!result) {
                            MyCustomToast.showErrorToast('Invalid data provided');
                            return;
                          }

                          try {
                            await controller.saveProfile();                           
                          } catch (e) {
                            controller.toggleSaveLoading(false);
                            MyCustomToast.showErrorToast(e.toString());
                          }
                        } : null,
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 21.h),
                            fixedSize: Size.fromWidth(Get.mediaQuery.size.width),
                            backgroundColor: AppColors.royalBlueColor,
                            disabledBackgroundColor: AppColors.whiteColor,
                            foregroundColor: AppColors.whiteColor),
                        child: !controller.isSaveLoading.value ? Text(
                          'Save',
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ) : const MyProgressIndicator(AppColors.royalBlueColor),
                      ),
                    )
                  ],
                ),
              ),
            )
            
          ),
        );
      },
    );
  }
}