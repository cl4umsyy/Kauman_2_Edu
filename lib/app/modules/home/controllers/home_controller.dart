import 'package:get/get.dart';

class HomeController extends GetxController {
  // Selected index for bottom navigation
  final selectedIndex = 0.obs;
  
  // Books for Top Available section (6 books) using Map instead of model
  final List<Map<String, String>> topBooks = [
    {
      'title': 'Laskar pelangi',
      'coverImage': 'assets/populer1.png',
    },
    {
      'title': 'To Kill a Mockingbird',
      'coverImage': 'assets/populer2.png',
    },
    {
      'title': 'The Alchemist',
      'coverImage': 'assets/populer3.png',
    },
    {
      'title': '5cm',
      'coverImage': 'assets/populer4.png',
    },
    {
      'title': 'Panchinko',
      'coverImage': 'assets/populer5.png',
    },
  ];

  // Books for Study Guides section (5 books) using Map instead of model
  final List<Map<String, String>> studyGuides = [
    {
      'title': 'Timun Jelita',
      'coverImage': 'assets/rilis1.png',
    },
    {
      'title': 'We Do Not Part',
      'coverImage': 'assets/rilis2.png',
    },
    {
      'title': 'Sunrise On The Reaping',
      'coverImage': 'assets/rilis3.png',
    },
    {
      'title': 'Herbal Healing',
      'coverImage': 'assets/rilis4.png',
    },
    {
      'title': 'Luka Cita',
      'coverImage': 'assets/rilis5.png',
    },
  ];
  // Monthly Magazines (new section)
  final List<Map<String, String>> monthlyMagazines = [
    {
      'title': 'Bobo / Ed 03 2025',
      'coverImage': 'assets/majalah1.png',
    },
    {
      'title': 'Bobo / Ed 01 2025',
      'coverImage': 'assets/majalah2.png',
    },
    {
      'title': 'YukMakan / may 2025',
      'coverImage': 'assets/majalah3.png',
    },
    {
      'title': 'Otomotif / feb 2025',
      'coverImage': 'assets/majalah4.png',
    },
    {
      'title': 'Vogue / jan 2025',
      'coverImage': 'assets/majalah5.png',
    },
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}