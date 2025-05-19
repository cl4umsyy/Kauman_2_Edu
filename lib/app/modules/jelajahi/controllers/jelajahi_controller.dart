import 'package:get/get.dart';

class JelajahiController extends GetxController {
  final selectedIndex = 1.obs; // Default ke tab Search/Jelajahi (index 1)
  final count = 0.obs;
  
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  void increment() => count.value++;
}