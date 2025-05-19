import 'package:get/get.dart';

class HomeController extends GetxController {
  // Selected index for bottom navigation
  final selectedIndex = 0.obs;
  
  // Flag to check if user is logged in
  final isLoggedIn = false.obs;
  
  // Books for Top Available section (6 books) using Map instead of model
  final List<Map<String, String>> topBooks = [
    {
      'title': 'How Do You Live?',
      'author': 'Yoshino Genzaburo',
      'coverImage': 'assets/1.png',
    },
    {
      'title': 'Zachary Ying',
      'author': 'Xiran Jay Zhao',
      'coverImage': 'assets/2.png',
    },
    {
      'title': 'Book Title 3',
      'author': 'Author 3',
      'coverImage': 'assets/3.png',
    },
    {
      'title': 'Book Title 4',
      'author': 'Author 4',
      'coverImage': 'assets/4.png',
    },
    {
      'title': 'Book Title 5',
      'author': 'Author 5',
      'coverImage': 'assets/5.png',
    },
    {
      'title': 'Book Title 6',
      'author': 'Author 6',
      'coverImage': 'assets/6.png',
    },
  ];

  // Books for Study Guides section (5 books) using Map instead of model
  final List<Map<String, String>> studyGuides = [
    {
      'title': 'Pendidikan Agama Islam',
      'author': 'Author 1',
      'coverImage': 'assets/7.png',
    },
    {
      'title': 'Bahasa Indonesia',
      'author': 'Author 2',
      'coverImage': 'assets/8.png',
    },
    {
      'title': 'Matematika',
      'author': 'Author 3',
      'coverImage': 'assets/9.png',
    },
    {
      'title': 'Study Guide 4',
      'author': 'Author 4',
      'coverImage': 'assets/10.png',
    },
    {
      'title': 'Study Guide 5',
      'author': 'Author 5',
      'coverImage': 'assets/11.png',
    },
  ];
  
  // Books for Cerita Rakyat section (5 books)
  final List<Map<String, String>> ceritaRakyat = [
    {
      'title': 'Malin Kundang',
      'author': 'Cerita Sumatra',
      'coverImage': 'assets/12.png',
    },
    {
      'title': 'Timun Mas',
      'author': 'Cerita Jawa',
      'coverImage': 'assets/13.png',
    },
    {
      'title': 'Sangkuriang',
      'author': 'Cerita Sunda',
      'coverImage': 'assets/14.png',
    },
    {
      'title': 'Bawang Merah Bawang Putih',
      'author': 'Cerita Nusantara',
      'coverImage': 'assets/15.png',
    },
    {
      'title': 'Si Kancil',
      'author': 'Cerita Indonesia',
      'coverImage': 'assets/16.png',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    // Here you could check for stored login credentials
    checkLoginStatus();
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
  
  // Method to check if user is logged in
  void checkLoginStatus() {
    // This would typically involve checking stored credentials
    // For now, we'll just set it to false
    isLoggedIn.value = false;
  }
  
  // Method to update login status after successful login
  void setLoggedIn(bool status) {
    isLoggedIn.value = status;
  }
}