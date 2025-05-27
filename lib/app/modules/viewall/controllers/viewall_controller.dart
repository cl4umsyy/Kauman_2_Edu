import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewallController extends GetxController {
  // Variables for view mode
  final isGridView = true.obs;
  
  // Variables for filtering and sorting
  final sortOption = 'relevance'.obs;
  
  // Current category
  final category = ''.obs;
  
  // Sample books data
  final books = <Map<String, dynamic>>[].obs;
  final allBooks = <Map<String, dynamic>>[];
  
  @override
  void onInit() {
    super.onInit();
    // Get category from arguments
    category.value = Get.arguments?['title'] ?? 'Majalah Bulan Ini';
    _loadBooksByCategory();
  }
  
  @override
  void onReady() {
    super.onReady();
  }
  
  @override
  void onClose() {
    super.onClose();
  }
  
  // Load books based on the category
  void _loadBooksByCategory() {
    // Clear any existing data
    allBooks.clear();
    
    // Load appropriate books based on category
    switch(category.value) {
      case 'Buku Populer!':
        _loadPopularBooks();
        break;
      case 'Buku Baru Dirilis':
        _loadNewReleases();
        break;
      case 'Majalah Bulan Ini':
        _loadMonthlyMagazines();
        break;
      default:
        _loadMonthlyMagazines(); // Default to magazines
    }
    
    // Initialize display list with all books for this category
    books.value = List.from(allBooks);
  }
  
  // Load Popular Books
  void _loadPopularBooks() {
    allBooks.addAll([
      {
        'title': 'Laskar Pelangi',
        'subtitle': 'Andrea Hirata',
        'coverImage': 'assets/populer1.png',
      },
      {
        'title': 'To Kill a Mockingbird',
        'subtitle': 'Pramoedya Ananta Toer',
        'coverImage': 'assets/populer2.png',
      },
      {
        'title': 'The Alchemist',
        'subtitle': 'Henry Manampiring',
        'coverImage': 'assets/populer3.png',
      },
      {
        'title': '5cm',
        'subtitle': 'Tere Liye',
        'coverImage': 'assets/populer4.png',
      },
      {
        'title': 'Panchinko',
        'subtitle': 'Leila S. Chudori',
        'coverImage': 'assets/populer5.png',
      },
      {
        'title': 'The Midnight Library',
        'subtitle': 'Leila S. Chudori',
        'coverImage': 'assets/populer6.png',
      },
      {
        'title': 'Atomic Habits',
        'subtitle': 'Leila S. Chudori',
        'coverImage': 'assets/populer7.png',
      },
      {
        'title': 'Filosofi Teras',
        'subtitle': 'Leila S. Chudori',
        'coverImage': 'assets/populer8.png',
      },
      {
        'title': 'Sapiens',
        'subtitle': 'Leila S. Chudori',
        'coverImage': 'assets/populer9.png',
      },
      {
        'title': 'Rich Dad Poor Dad',
        'subtitle': 'Leila S. Chudori',
        'coverImage': 'assets/populer10.png',
      },
      {
        'title': 'Man Search for Meaning',
        'subtitle': 'Leila S. Chudori',
        'coverImage': 'assets/populer11.png',
      },
      {
        'title': 'Thinking, Fast and Slow',
        'subtitle': 'Leila S. Chudori',
        'coverImage': 'assets/populer12.png',
      },
    ]);
  }
  
  // Load New Releases
  void _loadNewReleases() {
    allBooks.addAll([
      {
        'title': 'Timun Jelita',
        'subtitle': 'Andrea Hirata',
        'coverImage': 'assets/rilis1.png',
      },
      {
        'title': 'We Do Not Part',
        'subtitle': 'Max Brooks',
        'coverImage': 'assets/rilis2.png',
      },
      {
        'title': 'Sunrise On The Reaping',
        'subtitle': 'Tere Liye',
        'coverImage': 'assets/rilis3.png',
      },
      {
        'title': 'Herbal Healing',
        'subtitle': 'Endar Wismulyani',
        'coverImage': 'assets/rilis4.png',
      },
      {
        'title': 'Luka Cita',
        'subtitle': 'Tere Liye',
        'coverImage': 'assets/rilis5.png',
      },
      {
        'title': 'Cerita Cinta Enrico',
        'subtitle': 'Leila S. Chudori',
        'coverImage': 'assets/rilis6.png',
      },
      {
        'title': 'Perempuan Yang Menangis Kepada Bulan Hitam',
        'subtitle': 'Leila S. Chudori',
        'coverImage': 'assets/rilis7.png',
      },
      {
        'title': 'Kenduri Arwah',
        'subtitle': 'Leila S. Chudori',
        'coverImage': 'assets/rilis8.png',
      },
    ]);
  }
  
  // Load Monthly Magazines
  void _loadMonthlyMagazines() {
    allBooks.addAll([
      {
        'title': 'Bobo',
        'subtitle': 'Trobos Livestock / May 2025',
        'coverImage': 'assets/majalah1.png',
      },
      {
        'title': 'Bobo',
        'subtitle': 'Hidup / Ed 20 2025',
        'coverImage': 'assets/majalah2.png',
      },
      {
        'title': 'Yukmakan',
        'subtitle': 'Bobo / Ed 06 2025',
        'coverImage': 'assets/majalah3.png',
      },
      {
        'title': 'Otomotif',
        'subtitle': 'Kontan / Ed 33 2025',
        'coverImage': 'assets/majalah4.png',
      },
      {
        'title': 'Vogue',
        'subtitle': 'Tempo / Ed 18 2025',
        'coverImage': 'assets/majalah5.png',
      },
      {
        'title': 'Majalah Neymar',
        'subtitle': 'NatGeo / May 2025',
        'coverImage': 'assets/olahraga4.png',
      },
      {
        'title': 'Majalah Voli',
        'subtitle': 'NatGeo / May 2025',
        'coverImage': 'assets/olahraga5.png',
      },
      {
        'title': 'Majalah Voli jepang',
        'subtitle': 'NatGeo / May 2025',
        'coverImage': 'assets/olahraga6.png',
      },
      {
        'title': 'Majalah Voli Eropa',
        'subtitle': 'NatGeo / May 2025',
        'coverImage': 'assets/olahraga7.png',
      },
      {
        'title': 'Majalah Tennis',
        'subtitle': 'NatGeo / May 2025',
        'coverImage': 'assets/olahraga11.png',
      },
      {
        'title': 'Majalah Messi',
        'subtitle': 'NatGeo / May 2025',
        'coverImage': 'assets/olahraga12.png',
      },
    ]);
  }
  
  // Toggle between grid and list view
  void toggleViewMode() {
    isGridView.value = !isGridView.value;
  }
  
  // Apply filters and sorting
  void applyFilters() {
    final filtered = List<Map<String, dynamic>>.from(allBooks);
    
    // Apply sorting
    switch (sortOption.value) {
      case 'newest':
        filtered.sort((a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));
        break;
      case 'oldest':
        filtered.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));
        break;
      case 'relevance':
        // Default sorting or relevance algorithm
        break;
    }
    
    // Update the displayed books
    books.value = filtered;
  }
}