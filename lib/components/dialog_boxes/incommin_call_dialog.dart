import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/components/progress_indicator/progress_indicator.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/screens/video_call_screen/video_call_screen_reciever.dart';
import 'package:video_calling_flutter_app/services/signaling_service.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';

class IncommingCallDialogBox extends StatelessWidget {
  final String roomId;
  final String adminSocketId;
  final String userName;
  const IncommingCallDialogBox({super.key, required this.roomId, required this.adminSocketId, required this.userName});

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
            Text('Incomming Call', style: GoogleFonts.urbanist(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppColors.textBlackColor,), textAlign: TextAlign.center,),
            SizedBox(height: 10.h,),
            Text('$userName is calling you.', style: GoogleFonts.urbanist(fontSize: 20.sp, fontWeight: FontWeight.w500, color: AppColors.textBlackColor,), textAlign: TextAlign.center,),
            SizedBox(height: 20.h,),
            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10.h),
                      child: ElevatedButton(
                        onPressed:() async {
                          Get.back();
                        } ,
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            backgroundColor: AppColors.redIconColor,
                            disabledBackgroundColor: AppColors.whiteColor,
                            foregroundColor: AppColors.whiteColor),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ) ,
                      ),
                    ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10.h),
                      child: ElevatedButton(
                        onPressed:() async {
                          final socket = SignalingService.instance.socket!;
                          final user = Get.find<UserController>().user;
                          final userEmail = user.value!.userEmail;

                          socket.emit('room:join2', { "roomId": roomId, "email": userEmail});

                          Get.offAll(() => VideoCallScreenReciever(adminSocketId: adminSocketId));

                        } ,
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            backgroundColor: AppColors.greenIconColor,
                            disabledBackgroundColor: AppColors.whiteColor,
                            foregroundColor: AppColors.whiteColor),
                        child: Text(
                          'Accept',
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ) ,
                      ),
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