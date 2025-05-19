import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size to make responsive adjustments
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: const Color(0xFF5CE488), // Set Scaffold background color
      body: SafeArea(
        child: Obx(() => AnimatedOpacity(
          opacity: controller.opacity.value,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF5CE488), // Green background color
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo simbol buku dan orang
                  Container(
                    width: screenSize.width * 0.2, // Slightly smaller to match image
                    height: screenSize.width * 0.2,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/Vector3.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // Reduced spacing
                  // Text Kauman2 Edu - with the two-color styling
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kauman2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width * 0.08, // Slightly smaller font
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0, // Removed letter spacing
                        ),
                      ),
                      Text(
                        ' Edu',
                        style: TextStyle(
                          color: const Color(0xFF4A6741), // Darker green for "Edu" part
                          fontSize: screenSize.width * 0.08, // Same size as "Kauman2"
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0, // Removed letter spacing
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5), // Reduced spacing
                  // Subtext
                  Text(
                    'Membangun Generasi Cerdas dengan Literasi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenSize.width * 0.03, // Slightly smaller font
                      letterSpacing: 0, // Removed letter spacing
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}