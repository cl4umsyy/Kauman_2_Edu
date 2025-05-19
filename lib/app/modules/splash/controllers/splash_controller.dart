import 'package:get/get.dart';
import 'dart:async';

class SplashController extends GetxController {
  // Opacity untuk efek fade
  final opacity = 0.0.obs;
  

  @override
  void onReady() {
    super.onReady();
    // Mulai animasi fade in
    fadeIn();
  }


  // Fungsi untuk efek fade in
  void fadeIn() async {
    // Mulai dari opacity 0
    opacity.value = 0.0;
    
    // Animasi fade in selama 1 detik
    for (var i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      opacity.value += 0.1;
    }
    
    // Tunda sebentar agar splash screen terlihat
    await Future.delayed(const Duration(seconds: 2));
    
    // Mulai animasi fade out
    fadeOut();
  }
  
  // Fungsi untuk efek fade out
  void fadeOut() async {
    // Animasi fade out selama 1 detik
    for (var i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      opacity.value -= 0.1;
    }
    
    // Navigasi ke halaman berikutnya (Anda perlu menentukan rute)
    Get.offNamed('/home'); // Ganti dengan rute yang sesuai
  }
}