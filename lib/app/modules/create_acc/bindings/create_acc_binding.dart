import 'package:get/get.dart';

import '../controllers/create_acc_controller.dart';

class CreateAccBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccController>(
      () => CreateAccController(),
    );
  }
}
