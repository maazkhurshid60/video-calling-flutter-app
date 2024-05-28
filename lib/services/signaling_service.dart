import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:video_calling_flutter_app/components/dialog_boxes/incommin_call_dialog.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';

class SignalingService {

  // instance of Socket
  Socket? socket;

  SignalingService._();
  static final instance = SignalingService._();

  init({ required String webSocketUrl }) {

    // init Socket
    socket = io(webSocketUrl, OptionBuilder().setTransports(['websocket']).build());

    // listen onConnect Event
    socket!.onConnect((data) {
      log('SOCKET CONNECTED !!');
    });

    // listen onConnectionError event
    socket!.onConnectError((data) {
      log('SOCKET CONNECTION ERROR: $data');
    });

    socket!.on('notifyUser:call', (data) {
      final roomId = data['roomId'];
      final adminSocketId = data['from'];
      final userName = data['userName'];

      Get.dialog(
        IncommingCallDialogBox(roomId: roomId, adminSocketId: adminSocketId, userName: userName),
        barrierDismissible: false,
      );
    });

    // connect socket
    socket!.connect();

  }


}