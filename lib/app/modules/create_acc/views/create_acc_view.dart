import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_acc_controller.dart';

class CreateAccView extends StatelessWidget {
  const CreateAccView({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateAccController controller = Get.put(CreateAccController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              
              // Header with Back Button
              Row(
                children: [
                  GestureDetector(
                    onTap: controller.goToLogin,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF2D2D2D),
                        size: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Buat Akun Baru',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 44), // Balance the back button
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Logo Section
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF00B14F),
                      Color(0xFF00D15A),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00B14F).withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.school_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Bergabung dengan Kauman Edu',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Registration Form Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 30,
                      offset: Offset(0, 10),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 15,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Full Name Field
                    _buildTextField(
                      controller: controller.fullNameController,
                      label: 'Nama Lengkap',
                      hint: 'Masukkan nama lengkap Anda',
                      icon: Icons.person_outline_rounded,
                      isFocused: controller.isFullNameFocused,
                      onFocusChange: controller.setFullNameFocus,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Email Field
                    _buildTextField(
                      controller: controller.emailController,
                      label: 'Email',
                      hint: 'Masukkan alamat email Anda',
                      icon: Icons.email_outlined,
                      isFocused: controller.isEmailFocused,
                      onFocusChange: controller.setEmailFocus,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Username Field
                    _buildTextField(
                      controller: controller.usernameController,
                      label: 'Username',
                      hint: 'Pilih username unik Anda',
                      icon: Icons.alternate_email_outlined,
                      isFocused: controller.isUsernameFocused,
                      onFocusChange: controller.setUsernameFocus,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Password Field
                    _buildPasswordField(
                      controller: controller.passwordController,
                      label: 'Password',
                      hint: 'Buat password yang kuat',
                      isFocused: controller.isPasswordFocused,
                      onFocusChange: controller.setPasswordFocus,
                      isHidden: controller.isPasswordHidden,
                      onToggleVisibility: controller.togglePasswordVisibility,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Confirm Password Field
                    _buildPasswordField(
                      controller: controller.confirmPasswordController,
                      label: 'Konfirmasi Password',
                      hint: 'Ketik ulang password Anda',
                      isFocused: controller.isConfirmPasswordFocused,
                      onFocusChange: controller.setConfirmPasswordFocus,
                      isHidden: controller.isConfirmPasswordHidden,
                      onToggleVisibility: controller.toggleConfirmPasswordVisibility,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Terms and Conditions Checkbox
                    Obx(() => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: controller.toggleTermsAgreement,
                          child: Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(
                              color: controller.agreeToTerms.value
                                  ? Color(0xFF00B14F)
                                  : Colors.transparent,
                              border: Border.all(
                                color: controller.agreeToTerms.value
                                    ? Color(0xFF00B14F)
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: controller.agreeToTerms.value
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: controller.toggleTermsAgreement,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  height: 1.4,
                                ),
                                children: [
                                  TextSpan(text: 'Saya setuju dengan '),
                                  WidgetSpan(
                                    child: GestureDetector(
                                      onTap: controller.showTermsAndConditions,
                                      child: Text(
                                        'Syarat dan Ketentuan',
                                        style: TextStyle(
                                          color: Color(0xFF00B14F),
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Color(0xFF00B14F),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(text: ' yang berlaku'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    
                    const SizedBox(height: 32),
                    
                    // Create Account Button
                    Obx(() => Container(
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF00B14F),
                            Color(0xFF00D15A),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF00B14F).withOpacity(0.4),
                            blurRadius: 15,
                            offset: Offset(0, 6),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.createAccount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: controller.isLoading.value
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                'Buat Akun',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    )),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Back to Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun? ",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: controller.goToLogin,
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Masuk Sekarang',
                      style: TextStyle(
                        color: Color(0xFF00B14F),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required RxBool isFocused,
    required Function(bool) onFocusChange,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
          ),
        ),
        const SizedBox(height: 12),
        Obx(() => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: isFocused.value
                ? [
                    BoxShadow(
                      color: Color(0xFF00B14F).withOpacity(0.1),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            onTap: () => onFocusChange(true),
            onTapOutside: (_) => onFocusChange(false),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              prefixIcon: Icon(
                icon,
                color: isFocused.value
                    ? Color(0xFF00B14F)
                    : Colors.grey.shade400,
                size: 22,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Color(0xFF00B14F), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              filled: true,
              fillColor: isFocused.value
                  ? Color(0xFF00B14F).withOpacity(0.05)
                  : Colors.grey.shade50,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required RxBool isFocused,
    required Function(bool) onFocusChange,
    required RxBool isHidden,
    required VoidCallback onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
          ),
        ),
        const SizedBox(height: 12),
        Obx(() => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: isFocused.value
                ? [
                    BoxShadow(
                      color: Color(0xFF00B14F).withOpacity(0.1),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: controller,
            onTap: () => onFocusChange(true),
            onTapOutside: (_) => onFocusChange(false),
            obscureText: isHidden.value,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                color: isFocused.value
                    ? Color(0xFF00B14F)
                    : Colors.grey.shade400,
                size: 22,
              ),
              suffixIcon: IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  isHidden.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey.shade400,
                  size: 22,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Color(0xFF00B14F), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              filled: true,
              fillColor: isFocused.value
                  ? Color(0xFF00B14F).withOpacity(0.05)
                  : Colors.grey.shade50,
            ),
          ),
        )),
      ],
    );
  }
}