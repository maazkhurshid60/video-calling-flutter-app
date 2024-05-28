import 'package:get/get.dart';
import 'package:video_calling_flutter_app/controllers/user_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    
    Get.put(UserController(), permanent: true);

  }
  
}