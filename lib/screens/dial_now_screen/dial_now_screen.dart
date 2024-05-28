import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/app_bar/app_bar.dart';
import 'package:video_calling_flutter_app/components/progress_indicator/progress_indicator.dart';
import 'package:video_calling_flutter_app/controllers/dial_now_screen_controller.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';


class DialNowScreen extends StatelessWidget {
  const DialNowScreen({super.key});

  @override
  Widget build(BuildContext context) {

    void gotoBackScreen() {
      Get.back();
    }

    return GetX<DialNowScreenController>(
      init: DialNowScreenController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            appBar: customAppBarForMenu('Dial Now', gotoBackScreen),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Form(
                key: controller.phoneNumFormKey.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
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
                              initialSelection: 'US',
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
                    Container(
                      margin:EdgeInsets.symmetric(vertical: 32.h),
                      child: ElevatedButton(
                        onPressed: !controller.isLoading.value ? () async {
                          final isDataValid = controller.validateData();
                
                          if(!isDataValid) {
                            MyCustomToast.showErrorToast('Invalid data provided');
                            return;
                          }
                
                          final response = await controller.makeACall();
                          
                        } : null,
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 21.h),
                            fixedSize: Size.fromWidth(Get.mediaQuery.size.width),
                            backgroundColor: AppColors.royalBlueColor,
                            disabledBackgroundColor: AppColors.whiteColor,
                            foregroundColor: AppColors.whiteColor),
                        child: !controller.isLoading.value ? Text(
                          'Call',
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ) : const MyProgressIndicator(AppColors.royalBlueColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
