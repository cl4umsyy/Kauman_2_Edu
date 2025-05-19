import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../detail/controllers/detail_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    
    // Ensure DetailController is available for navigation
    if (!Get.isRegistered<DetailController>()) {
      Get.lazyPut<DetailController>(
        () => DetailController(),
      );
    }
  }
}