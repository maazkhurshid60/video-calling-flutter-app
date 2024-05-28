import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/models/call_history_model.dart';
import 'package:video_calling_flutter_app/screens/home_screen/home_screen.dart';
import 'package:video_calling_flutter_app/screens/video_call_screen/video_call_screen.dart';
import 'package:video_calling_flutter_app/services/signaling_service.dart';
import 'package:video_calling_flutter_app/services/user_service.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';

class AdminApprovalScreen extends StatefulWidget {
  const AdminApprovalScreen({super.key});

  @override
  State<AdminApprovalScreen> createState() => _AdminApprovalScreenState();
}

class _AdminApprovalScreenState extends State<AdminApprovalScreen> {

  bool isQueued = false;

  @override
  Widget build(BuildContext context) {

    final arguments = Get.arguments;
    final CallHistory callModel = arguments['callModel'];
    final roomId = callModel.roomId;
    final email = callModel.firstPersonCaller!.userEmail;
    final socket = SignalingService.instance.socket!;

    void changeQueueStatus() {
      if(mounted) {
        setState(() {
          isQueued = true;
        });
      }
    }

    socket.emit('room:join', { "roomId": roomId, "email": email});

    socket.on('admin:joined', (data) async {

      log("Admin joined the room");
      
      final adminSocketId = data['id'];
      await Future.delayed(const Duration(seconds: 2));

      socket.emit('room:join', { "roomId": roomId, "email": email});

      Get.off(() => VideoCallScreen(adminSocketId: adminSocketId,),);

    });

    socket.on('admin:rejectedCall', (data) {
      log('ADMIN REJECTED YOUR CALL');
      MyCustomToast.showErrorToast('Admin rejected your call');
      Get.offAll(() => const HomeScreen());
    });

    socket.on('admin:queuedCall', (data) {
      log('ADMIN QUEUED YOUR CALL');
      MyCustomToast.showErrorToast('Admin queued your call');
      if(mounted) {
        changeQueueStatus();
      }
    });

    socket.on('room:join', (data) {
      log("User joined the room");
      // print(data);
    });

    socket.on('error:make:call', (data) async {
      final message = data['message'];
      log(message);
      await UserServices.changeCallStatusToReject(callModel.id!);
      Get.offAll(() => const HomeScreen());
    });

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: Get.mediaQuery.size.height,
            width: Get.mediaQuery.size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  if(!isQueued)
                  Text('Waiting for Admin approval', style: GoogleFonts.urbanist(color: AppColors.royalBlueColor, fontSize: 20.sp,),),
                  if(isQueued) ... [
                    Text('Admin has queued your call', style: GoogleFonts.urbanist(color: AppColors.royalBlueColor, fontSize: 20.sp,),),
                    SizedBox(height: 10.h,),
                    Text('Please wait for admin to accept your call.', style: GoogleFonts.urbanist(color: AppColors.textBlackColor, fontSize: 16.sp,),softWrap: true,),
                  ]
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await UserServices.changeCallStatusToReject(callModel.id!);
              Get.offAll(() => const HomeScreen());
            },
            backgroundColor: AppColors.redIconColor,
            child: const Icon(Icons.call_end, color: AppColors.whiteColor,),
          ),
        ),
      ),
    );
  }
}
