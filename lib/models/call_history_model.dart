
import 'package:video_calling_flutter_app/models/user_model.dart';

class CallHistory {
  String? id;
  UserModel? firstPersonCaller;
  String? admin;
  UserModel? secondPersonCalledTo;
  int? duration;
  String? date;
  String? roomId;
  String? startTime;
  String? endTime;
  String? callStatus;
  String? callType;

  String? createdAt;
  String? updatedAt;

  CallHistory({
    this.id,
    this.firstPersonCaller,
    this.admin,
    this.secondPersonCalledTo,
    this.duration,
    this.date,
    this.roomId,
    this.startTime,
    this.endTime,
    this.callStatus,
    this.callType,

    this.createdAt,
    this.updatedAt
    
  });

  factory CallHistory.fromJson(Map<String, dynamic> json) {
    return CallHistory(
      id: json['_id'], 
      firstPersonCaller: UserModel.fromJson(json['firstPersonCaller']), 
      admin: json['admin'], 
      secondPersonCalledTo: UserModel.fromJson(json['secondPersonCalledTo']), 
      duration: json['duration'], 
      date: json['date'], 
      roomId: json['roomId'],
      startTime: json['startTime'], 
      endTime: json['endTime'], 
      callStatus: json['callStatus'], 
      callType: json['callType'],

      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']
    );
  }
}