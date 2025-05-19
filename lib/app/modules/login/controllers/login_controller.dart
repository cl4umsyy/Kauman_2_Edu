import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../../detail/controllers/detail_controller.dart';

class LoginController extends GetxController {
  // Text controllers for all fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  // Observable variables for form validation
  final RxBool isEmailValid = true.obs;
  final RxBool isPasswordValid = true.obs;
  final RxBool isNameValid = true.obs;
  final RxBool isConfirmPasswordValid = true.obs;
  final RxBool isLoading = false.obs;
  
  // Page state (login or create account)
  final RxBool isLoginPage = true.obs;
  
  // Password visibility
  final RxBool showPassword = false.obs;
  final RxBool showConfirmPassword = false.obs;
  
  // Terms agreement for registration
  final RxBool agreedToTerms = false.obs;
  
  // Store arguments passed from book detail
  var returnToDetail = false;
  var bookTitle = '';
  var shouldRedirectToDetail = false;
  
  @override
  void onInit() {
    super.onInit();
    
    // Get arguments if they exist
    if (Get.arguments != null) {
      if (Get.arguments['returnToDetail'] != null) {
        returnToDetail = Get.arguments['returnToDetail'];
      }
      if (Get.arguments['bookTitle'] != null) {
        bookTitle = Get.arguments['bookTitle'];
      }
      if (Get.arguments['shouldRedirectToDetail'] != null) {
        shouldRedirectToDetail = Get.arguments['shouldRedirectToDetail'];
      }
    }
  }


  @override
  void onClose() {
    // Clean up controllers
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
  
  // Return to home screen without logging in
  void returnToHome() {
    Get.back(); // Navigate back to previous screen (home or detail)
  }
  
  // Toggle between login and create account pages
  void togglePage() {
    isLoginPage.value = !isLoginPage.value;
    
    // Clear form fields when switching
    if (isLoginPage.value) {
      // Clear create account fields
      nameController.clear();
      confirmPasswordController.clear();
      agreedToTerms.value = false;
    } else {
      // Clear login fields (optional, depends on your UX preference)
      // emailController.clear();
      // passwordController.clear();
    }
    
    // Reset validation states
    isEmailValid.value = true;
    isPasswordValid.value = true;
    isNameValid.value = true;
    isConfirmPasswordValid.value = true;
  }
  
  // Toggle password visibility
  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }
  
  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }
  
  // Toggle terms agreement
  void toggleTermsAgreement() {
    agreedToTerms.value = !agreedToTerms.value;
  }
  
  // Modified validation methods to always return true
  bool validateName(String name) {
    // Modified to always return true for easier login
    return true;
  }
  
  bool validateEmail(String email) {
    // Modified to always return true for easier login
    return true;
  }
  
  bool validatePassword(String password) {
    // Modified to always return true for easier login
    return true;
  }
  
  bool validateConfirmPassword(String password, String confirmPassword) {
    // Modified to always return true for easier login
    return true;
  }
  
  // Navigate to detail page and clear navigation history
  void navigateToDetailPage() {
    Get.offAllNamed('/detail');
  }
  
  // Handle login process - modified to replace current screen with detail page
  Future<void> login() async {
    // Always set validation to true
    isEmailValid.value = true;
    isPasswordValid.value = true;
    
    // Show loading indicator
    isLoading.value = true;
    
    try {
      // Simulate API call with a shorter delay
      await Future.delayed(Duration(milliseconds: 500));
      
      // Always successful login, regardless of credentials
      final HomeController homeController = Get.find<HomeController>();
      homeController.setLoggedIn(true);
      
      // If coming from book detail with specific book info
      if (returnToDetail) {
        // Go back to detail screen
        Get.back();
        
        // Show success message with book info
        Get.snackbar(
          'Success', 
          'You\'ve successfully logged in! "$bookTitle" has been added to your list.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      } 
      else {
        // Replace current screen with detail page rather than navigating
        Get.offAllNamed('/detail');
        
        // Show success message
        Get.snackbar(
          'Success', 
          'You\'ve successfully logged in!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      // Handle errors
      Get.snackbar(
        'Error', 
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      // Hide loading indicator
      isLoading.value = false;
    }
  }
  
  // Handle create account process - modified to replace current screen with detail page
  Future<void> createAccount() async {
    // Always set validation to true
    isNameValid.value = true;
    isEmailValid.value = true;
    isPasswordValid.value = true;
    isConfirmPasswordValid.value = true;
    
    // Only check terms agreement
    if (!agreedToTerms.value) {
      Get.snackbar(
        'Terms Required', 
        'You must agree to the Terms and Conditions',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }
    
    // Show loading indicator
    isLoading.value = true;
    
    try {
      // Simulate API call with a shorter delay
      await Future.delayed(Duration(milliseconds: 500));
      
      // Always successful account creation
      final HomeController homeController = Get.find<HomeController>();
      homeController.setLoggedIn(true);
      
      // If coming from book detail with specific book info
      if (returnToDetail) {
        // Go back to detail screen
        Get.back();
        
        // Show success message with book info
        Get.snackbar(
          'Success', 
          'Account created! "$bookTitle" has been added to your list.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
      else {
        // Replace current screen with detail page rather than navigating
        Get.offAllNamed('/detail');
        
        // Show success message
        Get.snackbar(
          'Success', 
          'Account created successfully! You are now logged in.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      // Handle errors
      Get.snackbar(
        'Error', 
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      // Hide loading indicator
      isLoading.value = false;
    }
  }
  
  // Handle forgot password
  void forgotPassword() {
    // For this example, we'll just show a message
    Get.snackbar(
      'Forgot Password', 
      'This feature is not implemented yet.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  // Handle social logins
  void socialLogin(String provider) {
    Get.snackbar(
      '$provider Login', 
      'This feature is not implemented yet.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}