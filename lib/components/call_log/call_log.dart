import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_calling_flutter_app/theme/app_colors.dart';
import 'package:video_calling_flutter_app/utils/date_time.dart';

class CallLogWidget extends StatelessWidget {
  final int index;
  final String fullName;
  final String phoneNumber;
  final String time;
  final String profileImage;
  final bool isIncoming;

  const CallLogWidget(this.index, this.fullName, this.phoneNumber, this.time, this.profileImage, this.isIncoming, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.r,
        backgroundImage: profileImage != '' ?
         NetworkImage(profileImage,) :
         null,
        child: profileImage == '' ? const Center(child: Icon(Icons.person_outline_rounded, color: AppColors.textGreyColor,),) : null,
      ),
      title: Text(fullName, style: GoogleFonts.urbanist(color: AppColors.callLogTitleColor, fontSize: 15.sp, fontWeight:FontWeight.w300),),
      subtitle: Text(phoneNumber, style: GoogleFonts.urbanist(color: AppColors.callLogSubTitleColor, fontSize: 14.sp, fontWeight:FontWeight.w300),),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(isIncoming)
          Image.asset('assets/jpgs/incoming_call.png'),
          if(!isIncoming)
          Image.asset('assets/jpgs/outgoing_call.png'),
          SizedBox(width: 9.w,),
          Text(convertStringToTime(time), style: GoogleFonts.urbanist(color: AppColors.textGreyColor, fontSize: 14.sp),),
        ],
      ),
    );
  }
}