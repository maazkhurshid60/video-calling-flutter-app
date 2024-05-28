import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/app_bar/app_bar.dart';
import 'package:video_calling_flutter_app/components/call_log/call_log.dart';
import 'package:video_calling_flutter_app/controllers/home_screen_controller.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/screens/dial_now_screen/dial_now_screen.dart';
import 'package:video_calling_flutter_app/services/signaling_service.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';
import 'package:video_calling_flutter_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {  

  @override
  Widget build(BuildContext context) {

    // Init signaling service
    SignalingService.instance.init(webSocketUrl: Constants.webSocketUrl);

    return GetX<HomeScreenController>(
      init: HomeScreenController(),
      builder:(controller) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: controller.getUserCallLogs,
            child: Scaffold(
              appBar: customAppBar(),
              body: !controller.isDataLoading.value && controller.userCallLogs.isNotEmpty ? ListView.builder(
                itemCount: controller.userCallLogs.length,
                itemBuilder: (context, index) {
            
                  if(controller.userCallLogs.isEmpty) {
                    return Center(child: Text('No Call History', style: GoogleFonts.urbanist(color: AppColors.greyShade2Color, fontSize: 20.sp, fontWeight: FontWeight.w500),),);
                  }
            
                  return GetBuilder<UserController>(
                    builder: (uCont) {
                      return CallLogWidget(
                        index, 
                        controller.userCallLogs[index].firstPersonCaller!.id == uCont.user.value!.id ? controller.userCallLogs[index].secondPersonCalledTo!.userFullName : controller.userCallLogs[index].firstPersonCaller!.userFullName, 
                        controller.userCallLogs[index].firstPersonCaller!.id == uCont.user.value!.id ? controller.userCallLogs[index].secondPersonCalledTo!.userPhoneNumber : controller.userCallLogs[index].firstPersonCaller!.userPhoneNumber, 
                        controller.userCallLogs[index].startTime!,
                        controller.userCallLogs[index].firstPersonCaller!.id == uCont.user.value!.id ? controller.userCallLogs[index].secondPersonCalledTo!.userProfileImage : controller.userCallLogs[index].firstPersonCaller!.userProfileImage,
                        controller.userCallLogs[index].firstPersonCaller!.id == uCont.user.value!.id ? false : true
                      );
                    },
                  );
                },
              ) : !controller.isDataLoading.value && controller.userCallLogs.isEmpty ?
                  Center(child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('No Calls History', style: GoogleFonts.urbanist(color: AppColors.greyShade2Color, fontSize: 26.sp, fontWeight: FontWeight.w500),),
                      SizedBox(height: 10.h,),
                      TextButton.icon(onPressed: controller.getUserCallLogs, icon: const Icon(Icons.refresh_outlined, color: AppColors.royalBlueColor,), label: Text('Refresh', style: GoogleFonts.urbanist(color: AppColors.royalBlueColor, fontSize: 16.sp),))
                    ],
                  ),) 
                : const Center(child: CircularProgressIndicator(color: AppColors.royalBlueColor,),),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.large(
                onPressed: () {
                  Get.to(() => const DialNowScreen());
                },
                backgroundColor: AppColors.greenIconColor,
                shape: const StadiumBorder(side: BorderSide(width: 0, color: Colors.transparent)),
                child: Icon(Icons.call, color: AppColors.whiteColor, size: 40.w),
              ),
            ),
          ),
        );
      },
    );
  }
}