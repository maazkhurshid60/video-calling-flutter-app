import 'dart:developer';

import 'package:get/get.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';
import 'package:video_calling_flutter_app/services/signaling_service.dart';
import 'package:video_calling_flutter_app/services/user_service.dart';
import 'package:video_calling_flutter_app/utils/constants.dart';

import '../models/call_history_model.dart';

class HomeScreenController extends GetxController {

  Rx<bool> isDataLoading = true.obs;
  RxList<CallHistory> userCallLogs = <CallHistory>[].obs;

  Rx<String> errorMessageWhileLoading = ''.obs;

  void toggleDataLoading(bool value) {
    isDataLoading.value = value;
    update();
  }

  Future<void> getUserCallLogs() async {

    try {

      toggleDataLoading(true);

      final result = await UserServices.getUserCallLogs();

      if(result['statusCode'] == 200) {

        final dataList = result['data'];
        final List<CallHistory> callLogsDataModelsList = [];

        for (var callLogJson in dataList) {
          final callLogModel = CallHistory.fromJson(callLogJson);
          callLogsDataModelsList.add(callLogModel);
        }

        log(callLogsDataModelsList.length.toString());

        userCallLogs.value = callLogsDataModelsList.reversed.toList();

        print(userCallLogs);

        toggleDataLoading(false);

        update();

      }
      
    } catch (e) {
      toggleDataLoading(false);
      errorMessageWhileLoading.value = e.toString();
      update();
    }

  }

  @override
  void onInit() async {
    super.onInit();
    await getUserCallLogs();

    final socket = SignalingService.instance.socket!;
    final user = Get.find<UserController>();

    socket.emit('join:user:app', { "email" : user.user.value!.userEmail });
   
  }

}