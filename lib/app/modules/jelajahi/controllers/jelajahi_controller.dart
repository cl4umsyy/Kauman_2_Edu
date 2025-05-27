import 'package:get/get.dart';

class JelajahiController extends GetxController {
  final selectedIndex = 1.obs; // Default ke tab Search/Jelajahi (index 1)
  final count = 0.obs;
  
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
    super.onClose();
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  void increment() => count.value++;

  // Method untuk navigasi ke halaman kategori dengan parameter
  void navigateToCategory(String categoryName) {
    Get.toNamed('/kategori', arguments: {'category': categoryName});
  }

  // Method untuk navigasi ke halaman detail buku
  void navigateToBookDetail({
    required String title,
    required String author,
    required String coverImage,
    String? description,
    String? pageCount,
    String? publishDate,
    String? ageRating,
  }) {
    Get.toNamed('/detail', arguments: {
      'title': title,
      'author': author,
      'coverImage': coverImage,
      'description': description,
      'pageCount': pageCount ?? '200',
      'publishDate': publishDate ?? '2023',
      'ageRating': ageRating ?? '13+',
    });
  }
}