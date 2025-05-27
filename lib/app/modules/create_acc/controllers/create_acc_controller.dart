import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccController extends GetxController {
  // Text Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  // Observable variables
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isFullNameFocused = false.obs;
  final isEmailFocused = false.obs;
  final isUsernameFocused = false.obs;
  final isPasswordFocused = false.obs;
  final isConfirmPasswordFocused = false.obs;
  final agreeToTerms = false.obs;
  
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
    fullNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
  
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }
  
  // Set focus states
  void setFullNameFocus(bool focused) {
    isFullNameFocused.value = focused;
  }
  
  void setEmailFocus(bool focused) {
    isEmailFocused.value = focused;
  }
  
  void setUsernameFocus(bool focused) {
    isUsernameFocused.value = focused;
  }
  
  void setPasswordFocus(bool focused) {
    isPasswordFocused.value = focused;
  }
  
  void setConfirmPasswordFocus(bool focused) {
    isConfirmPasswordFocused.value = focused;
  }
  
  void toggleTermsAgreement() {
    agreeToTerms.value = !agreeToTerms.value;
  }
  
  // Clear all inputs helper function
  void _clearAllInputs() {
    fullNameController.clear();
    emailController.clear();
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    agreeToTerms.value = false;
    
    // Reset focus states
    isFullNameFocused.value = false;
    isEmailFocused.value = false;
    isUsernameFocused.value = false;
    isPasswordFocused.value = false;
    isConfirmPasswordFocused.value = false;
  }
  
  // Simple validation - hanya cek field tidak kosong
  bool _validateInputs() {
    if (fullNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Nama lengkap tidak boleh kosong',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return false;
    }
    
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Email tidak boleh kosong',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return false;
    }
    
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
    
    if (confirmPasswordController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Konfirmasi password tidak boleh kosong',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return false;
    }
    
    if (!agreeToTerms.value) {
      Get.snackbar(
        'Error',
        'Anda harus menyetujui syarat dan ketentuan',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return false;
    }
    
    // Semua validasi ketat dihapus - semua input bebas diterima
    return true;
  }
  
  // Create Account function
  Future<void> createAccount() async {
    if (!_validateInputs()) return;
    
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      String fullName = fullNameController.text.trim();
      String email = emailController.text.trim();
      String username = usernameController.text.trim();
      
      // Berhasil tanpa validasi ketat
      Get.snackbar(
        'Berhasil',
        'Akun berhasil dibuat! Selamat datang, $fullName',
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      
      // Clear all inputs after successful registration
      _clearAllInputs();
      
      // Navigate to home page after successful registration using offAllNamed
      // This will clear the entire navigation stack and go directly to home
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed('/home');
      
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
  
  // Show Terms and Conditions
  void showTermsAndConditions() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Syarat dan Ketentuan',
          style: TextStyle(
            color: Color(0xFF2D2D2D),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '1. Penggunaan Aplikasi',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Dengan menggunakan aplikasi Kauman Edu, Anda setuju untuk menggunakan layanan ini dengan bijak dan bertanggung jawab.',
                style: TextStyle(color: Color(0xFF666666)),
              ),
              SizedBox(height: 16),
              Text(
                '2. Privasi Data',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Kami berkomitmen untuk melindungi privasi dan keamanan data pribadi Anda sesuai dengan kebijakan privasi yang berlaku.',
                style: TextStyle(color: Color(0xFF666666)),
              ),
              SizedBox(height: 16),
              Text(
                '3. Konten Edukasi',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Semua konten edukasi yang disediakan dalam aplikasi ini adalah untuk tujuan pembelajaran dan tidak boleh disalahgunakan.',
                style: TextStyle(color: Color(0xFF666666)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Tutup',
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
  
  // Navigate back to login page
  void goToLogin() {
    try {
      // Clear current inputs before navigating back
      _clearAllInputs();
      
      // Debug print untuk memastikan method dipanggil
      print('Navigating back to LoginView...');
      
      // Menggunakan Get.back() terlebih dahulu
      Get.back();
      
      // Optional: Show info snackbar
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.snackbar(
          'Info',
          'Kembali ke halaman login',
          backgroundColor: Colors.blue.shade100,
          colorText: Colors.blue.shade800,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 1),
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      });
      
    } catch (e) {
      print('Error navigating back: $e');
      
      // Fallback jika Get.back() gagal
      try {
        Get.offNamed('/login');
      } catch (e2) {
        print('Error with named route: $e2');
        
        Get.snackbar(
          'Error',
          'Tidak dapat kembali ke halaman login. Silakan restart aplikasi.',
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