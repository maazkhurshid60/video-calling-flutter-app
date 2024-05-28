import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as navigator;
import 'package:get/get.dart';
import 'package:video_calling_flutter_app/screens/home_screen/home_screen.dart';
import 'package:video_calling_flutter_app/services/signaling_service.dart';
import 'package:video_calling_flutter_app/utils/toasts.dart';


class VideoCallScreen extends StatefulWidget {
  final String adminSocketId;
  const VideoCallScreen({super.key, required this.adminSocketId});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {

  final socket = SignalingService.instance.socket!;

  final _localVideoRenderer = RTCVideoRenderer();
  
  final _remoteVideoRenderer = RTCVideoRenderer();

  MediaStream? _localStream;

  RTCPeerConnection? _rtcPeerConnection;

  List<RTCIceCandidate> rtcIceCandidates = [];

  bool isAudioOn = false, isVideoOn = true, isFrontCameraSelected = true;

  @override
  void initState() {
    
    _localVideoRenderer.initialize();
    _remoteVideoRenderer.initialize();

    _setupPeerConnection();
    super.initState();
  }

  _setupPeerConnection() async {

    _rtcPeerConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:19302',
            "stun:global.stun.twilio.com:3478",
          ]
        }
      ]
    });
    _rtcPeerConnection!.onIceCandidate =
          (RTCIceCandidate candidate) => rtcIceCandidates.add(candidate);

    _rtcPeerConnection!.onTrack = (event) {
      log('GOT TRACKS!!!!');
      setState(() {
        _remoteVideoRenderer.srcObject = event.streams[0];
      });
    };

    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': isVideoOn ? {'facingMode': 'user'} : false
    }); 

    _localStream!.getVideoTracks().forEach((track) {
      log(track.id ?? 'No Track');
      _rtcPeerConnection!.addTrack(track, _localStream!);
    });

    _localVideoRenderer.srcObject = _localStream;
    setState(() { });

    socket.on('incomming:call', handleIncomingCall);
    socket.on('peer:nego:needed', handleNegoNeeded);
    socket.on('admin:ended:call', handleAdminCallEnded);


  }

  void handleIncomingCall(data) async {
    final offer = data['offer'];

    print('ICOMING CALL $offer');
    final sdp = offer['sdp'];
    final type = offer['type'];
    await _rtcPeerConnection!.setRemoteDescription(RTCSessionDescription(sdp, type));
    final answer = await _rtcPeerConnection!.createAnswer({ "mandatory": {
        "OfferToReceiveAudio": true,
        "OfferToReceiveVideo": true,
      }, });
    await _rtcPeerConnection!.setLocalDescription(answer);
    socket.emit('call:accepted', { "to" : widget.adminSocketId, "answer": answer.toMap() });

  }

  void handleNegoNeeded(data) async {
    final rtcSDP = data['offer']['sdp'];
    await _rtcPeerConnection!.setRemoteDescription(RTCSessionDescription(rtcSDP, data['offer']['type']));
    final answer = await _rtcPeerConnection!.createAnswer({ "mandatory": {
        "OfferToReceiveAudio": true,
        "OfferToReceiveVideo": true,
      }, });
    await _rtcPeerConnection!.setLocalDescription(answer);

    socket.emit('peer:nego:done', { "to" : data['from'], "answer": answer.toMap() });

    final state = await _rtcPeerConnection!.getIceGatheringState();
    log(state.toString());

    _remoteVideoRenderer.srcObject!.getAudioTracks().forEach((track) { 
      track.enabled = false;
    });

  }

  void handleAdminCallEnded(data) {
    log('ADMIN ENDED CALL');
    MyCustomToast.showSuccessToast('Admin Ended Call!');

    _localVideoRenderer.dispose();
    _remoteVideoRenderer.dispose();
    _localStream?.dispose();
    _rtcPeerConnection?.dispose();

    Get.offAll(() => const HomeScreen());
  }

  @override
  void dispose() {
    _localVideoRenderer.dispose();
    _remoteVideoRenderer.dispose();
    _localStream?.dispose();
    _rtcPeerConnection?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              
              Container(
                width: Get.mediaQuery.size.width, 
                height: Get.mediaQuery.size.height,
                decoration: const BoxDecoration(
                  color: Colors.black87
                ),
                child: RTCVideoView(_remoteVideoRenderer),
              ),
              Positioned(
                bottom: 10,
                right: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: Get.mediaQuery.size.width * 0.24, 
                    height: Get.mediaQuery.size.height * 0.25,
                    child: RTCVideoView(_localVideoRenderer, mirror: isFrontCameraSelected, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,),
                  ),
                ),
              ),
              
              
            ],
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // controller.disposeLocalRenderers();
          //     Get.back();
          //   },
          //   backgroundColor: AppColors.redIconColor,
          //   child: const Icon(Icons.call_end, color: AppColors.whiteColor,),
          // ),
        ),
      ),
    );
  }
}
