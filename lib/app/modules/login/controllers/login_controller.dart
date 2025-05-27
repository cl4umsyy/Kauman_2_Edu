import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../create_acc/views/create_acc_view.dart';

class LoginController extends GetxController {
  // Text Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // Observable variables
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final isUsernameFocused = false.obs;
  final isPasswordFocused = false.obs;
  
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
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
  
  // Set focus states
  void setUsernameFocus(bool focused) {
    isUsernameFocused.value = focused;
  }
  
  void setPasswordFocus(bool focused) {
    isPasswordFocused.value = focused;
  }
  
  // Validation dengan pesan Indonesia
  bool _validateInputs() {
    if (usernameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Username tidak boleh kosong',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return false;
    }
    
    if (passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Password tidak boleh kosong',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return false;
    }
    
    if (passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password minimal 6 karakter',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return false;
    }
    
    return true;
  }
  
  // Login function
  Future<void> login() async {
    if (!_validateInputs()) return;
    
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      
      // Demo validation - sesuaikan dengan kebutuhan
      if (username.isNotEmpty && password.length >= 6) {
        Get.snackbar(
          'Berhasil',
          'Login berhasil! Selamat datang, $username',
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade800,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
        
        // Clear text fields after successful login
        _clearInputs();
        
        // Navigate to home page after successful login
        await Future.delayed(const Duration(seconds: 1));
        Get.offNamed('/home');
        
      } else {
        Get.snackbar(
          'Error',
          'Username atau password salah',
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade800,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      }
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Clear inputs helper function
  void _clearInputs() {
    usernameController.clear();
    passwordController.clear();
    isUsernameFocused.value = false;
    isPasswordFocused.value = false;
  }
  
  // Forgot password function
  void forgotPassword() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Lupa Password',
          style: TextStyle(
            color: Color(0xFF2D2D2D),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Fitur reset password akan segera tersedia. Silakan hubungi administrator untuk bantuan.',
          style: TextStyle(color: Color(0xFF666666)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color(0xFF00B14F),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
  
  // Navigate to create account page - DIPERBAIKI
  void goToCreateAccount() {
    try {
      // Clear current inputs before navigating
      _clearInputs();
      
      // Debug print untuk memastikan method dipanggil
      print('Navigating to CreateAccView...');
      
      // Menggunakan Get.to() sebagai alternatif jika named route bermasalah
      Get.to(
        () => const CreateAccView(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
      
      // Optional: Show info snackbar setelah navigasi berhasil
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.snackbar(
          'Info',
          'Silakan lengkapi form registrasi',
          backgroundColor: Colors.blue.shade100,
          colorText: Colors.blue.shade800,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      });
      
    } catch (e) {
      // Fallback menggunakan named route jika Get.to() gagal
      print('Error with Get.to(), trying named route: $e');
      
      try {
        Get.toNamed('/create_acc');
      } catch (e2) {
        print('Error with named route: $e2');
        
        // Show error message jika semua metode navigasi gagal
        Get.snackbar(
          'Error',
          'Tidak dapat membuka halaman registrasi. Silakan coba lagi.',
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade800,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      }
    }
  }
}

