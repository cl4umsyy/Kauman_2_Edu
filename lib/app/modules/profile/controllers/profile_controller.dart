import 'package:get/get.dart';

class ProfileController extends GetxController {
  final username = 'Claumsyy'.obs;
  final bio = 'alright alright alright'.obs;
  
  // Buku favorit - menggunakan data statis atau dari memory
  final favoriteBooks = <Map<String, dynamic>>[].obs;
  
  // Recent activity untuk buku
  final recentActivity = <Map<String, dynamic>>[
    {
      'title': 'The Enormous Crocodile',
      'author': 'Matt Haig',
      'coverUrl': 'assets/fiksi5.png',
      'rating': 4.5,
      'hasNotes': true,
      'dateRead': '2024-01-15',
      'genre': 'Fiction'
    },
    {
      'title': 'Atlas Dunia',
      'author': 'Andy Weir',
      'coverUrl': 'assets/geografi1.png',
      'rating': 5.0,
      'hasNotes': true,
      'dateRead': '2024-01-10',
      'genre': 'Science Fiction'
    },
    {
      'title': 'Bukan 350 Tahun Dijajah',
      'author': 'Taylor Jenkins Reid',
      'coverUrl': 'assets/sejarah1.png',
      'rating': 4.0,
      'hasNotes': false,
      'dateRead': '2024-01-05',
      'genre': 'Historical Fiction'
    },
    {
      'title': 'Panggil aku kartini saja',
      'author': 'Tara Westover',
      'coverUrl': 'assets/sejarah5.png',
      'rating': 4.5,
      'hasNotes': true,
      'dateRead': '2024-01-01',
      'genre': 'Memoir'
    },
  ].obs;
  
  // Placeholder untuk distribusi rating
  final ratingsDistribution = [2, 8, 15, 25, 40].obs;

  @override
  void onInit() {
    super.onInit();
    // Load data default saat inisialisasi
    loadDefaultData();
    
    // Setup listener untuk perubahan dari SettingsController
    _setupSettingsListener();
  }

  // Setup listener untuk mendengarkan perubahan dari SettingsController
  void _setupSettingsListener() {
    // Cek apakah SettingsController sudah ada
    if (Get.isRegistered<SettingsController>()) {
      final settingsController = Get.find<SettingsController>();
      
      // Listen untuk perubahan favoriteBooks dari SettingsController
      ever(settingsController.favoriteBooks, (List<Map<String, dynamic>> books) {
        favoriteBooks.value = List<Map<String, dynamic>>.from(books);
        print('ProfileController: Favorite books updated from SettingsController - ${books.length} books');
      });
    }
  }

  // Load data default (menggantikan fungsi SharedPreferences)
  void loadDefaultData() {
    // Set default favorite books jika belum ada
    if (favoriteBooks.isEmpty) {
      favoriteBooks.value = [
        {
          'id': '1',
          'title': 'Atomic Habits',
          'author': 'F. Scott Fitzgerald',
          'coverUrl': 'assets/populer7.png',
          'genre': 'Classic Literature'
        },
        {
          'id': '2',
          'title': 'Timun Jelita',
          'author': 'Raditya Dika',
          'coverUrl': 'assets/rilis1.png',
          'genre': 'Dystopian Fiction'
        },
        {
          'id': '3',
          'title': 'Pulang',
          'author': 'Harper Lee',
          'coverUrl': 'assets/sejarah8.png',
          'genre': 'Classic Literature'
        },
        {
          'id': '4',
          'title': 'Sunrise On The Reaping',
          'author': 'Jane Austen',
          'coverUrl': 'assets/rilis3.png',
          'genre': 'Romance'
        },
      ];
    }
  }

  // Method untuk update buku favorit dari SettingsController
  void updateFavoriteBooks(List<Map<String, dynamic>> newFavoriteBooks) {
    favoriteBooks.value = List<Map<String, dynamic>>.from(newFavoriteBooks);
    favoriteBooks.refresh(); // Force refresh UI
    print('ProfileController: Favorite books manually updated - ${newFavoriteBooks.length} books');
  }

  // Method untuk sinkronisasi dengan SettingsController
  void syncWithSettings() {
    try {
      if (Get.isRegistered<SettingsController>()) {
        final settingsController = Get.find<SettingsController>();
        updateFavoriteBooks(settingsController.favoriteBooks.toList());
      }
    } catch (e) {
      print('Error syncing with SettingsController: $e');
    }
  }

  // Method untuk menambah aktivitas baca baru
  void addRecentActivity(Map<String, dynamic> book) {
    // Tambahkan ke awal list (aktivitas terbaru)
    recentActivity.insert(0, book);
    
    // Batasi maksimal 10 aktivitas terakhir
    if (recentActivity.length > 10) {
      recentActivity.removeRange(10, recentActivity.length);
    }
  }

  // Method untuk update rating distribusi
  void updateRatingsDistribution(List<int> newDistribution) {
    ratingsDistribution.value = newDistribution;
  }

  // Method untuk update bio
  void updateBio(String newBio) {
    bio.value = newBio;
    print('Bio updated to: $newBio');
  }

  // Method untuk update username
  void updateUsername(String newUsername) {
    username.value = newUsername;
    print('Username updated to: $newUsername');
  }

  // Method untuk mendapatkan statistik buku
  Map<String, int> getBookStats() {
    return {
      'totalFavorites': favoriteBooks.length,
      'totalRead': recentActivity.length,
      'totalRatings': ratingsDistribution.isEmpty ? 0 : ratingsDistribution.reduce((a, b) => a + b),
    };
  }

  // Method untuk refresh data profil
  void refreshProfileData() {
    // Reload default data dan sync dengan settings
    loadDefaultData();
    syncWithSettings();
    print('Profile data refreshed');
  }

  @override
  void onClose() {
    super.onClose();
  }
}

// Import untuk SettingsController (pastikan ada di bagian atas file)
class SettingsController extends GetxController {
  final favoriteBooks = <Map<String, dynamic>>[].obs;
  // ... other properties
}