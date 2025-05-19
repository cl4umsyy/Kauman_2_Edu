import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Obx(() => Column(
              children: [
                // Green curved container with logo
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: const BoxDecoration(
                    color: Color(0xFF7EE293), // Light green color
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Book and person logo
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFF7EE293),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/Vector3.png',
                            width: 100,
                            height: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Title text (changes based on page mode)
                Text(
                  controller.isLoginPage.value ? 'Welcome Back!' : 'Create Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4D4D4D),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // CONDITIONAL FIELDS BASED ON PAGE MODE
                
                // Name field (only for create account)
                if (!controller.isLoginPage.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: TextField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                        errorText: controller.isNameValid.value ? null : 'Name is required',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Color(0xFF7EE293)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Color(0xFF7EE293), width: 2),
                        ),
                        prefixIcon: Icon(Icons.person, color: Color(0xFF7EE293)),
                      ),
                    ),
                  ),
                
                // Email field (common for both)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      errorText: controller.isEmailValid.value ? null : 'Please enter a valid email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Color(0xFF7EE293)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Color(0xFF7EE293), width: 2),
                      ),
                      prefixIcon: Icon(Icons.email, color: Color(0xFF7EE293)),
                    ),
                  ),
                ),
                
                // Password field (common for both)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: TextField(
                    controller: controller.passwordController,
                    obscureText: !controller.showPassword.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      errorText: controller.isPasswordValid.value ? null : 'Password must be at least 6 characters',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Color(0xFF7EE293)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Color(0xFF7EE293), width: 2),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF7EE293)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.showPassword.value ? Icons.visibility_off : Icons.visibility,
                          color: Color(0xFF7EE293),
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                ),
                
                // Confirm Password field (only for create account)
                if (!controller.isLoginPage.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: TextField(
                      controller: controller.confirmPasswordController,
                      obscureText: !controller.showConfirmPassword.value,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        errorText: controller.isConfirmPasswordValid.value ? null : 'Passwords do not match',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Color(0xFF7EE293)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Color(0xFF7EE293), width: 2),
                        ),
                        prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF7EE293)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.showConfirmPassword.value ? Icons.visibility_off : Icons.visibility,
                            color: Color(0xFF7EE293),
                          ),
                          onPressed: controller.toggleConfirmPasswordVisibility,
                        ),
                      ),
                    ),
                  ),
                
                // Terms and Conditions checkbox (only for create account)
                if (!controller.isLoginPage.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: Row(
                      children: [
                        Checkbox(
                          value: controller.agreedToTerms.value,
                          onChanged: (_) => controller.toggleTermsAgreement(),
                          activeColor: Color(0xFF7EE293),
                        ),
                        Expanded(
                          child: Text(
                            'I agree to the Terms and Conditions',
                            style: TextStyle(
                              color: Color(0xFF4D4D4D),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 20),
                
                // Primary action button (Login or Create Account)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value 
                        ? null 
                        : (controller.isLoginPage.value 
                            ? () => controller.login() 
                            : () => controller.createAccount()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7EE293),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              controller.isLoginPage.value ? 'Login' : 'Create Account',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 15),
                
                // Secondary action button (Switch between Login and Create Account)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () => controller.togglePage(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF7EE293)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        controller.isLoginPage.value ? 'Create New Account' : 'Back to Login',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF7EE293),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Bottom padding
                const SizedBox(height: 30),
              ],
            )),
          ),
        ],
      ),
    );
  }
}