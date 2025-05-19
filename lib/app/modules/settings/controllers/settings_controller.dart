import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Film favorit (maksimal 4)
  final favoriteFilms = <Map<String, dynamic>>[].obs;
  
  // Untuk pelacakan apakah ada perubahan yang perlu disimpan
  final hasChanges = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Ambil data film favorit dari penyimpanan lokal saat inisialisasi
    loadFavoriteFilms();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Memuat film favorit dari penyimpanan lokal
  void loadFavoriteFilms() {
    // TODO: Implementasikan pembacaan dari SharedPreferences atau database lokal
    // Ini contoh data dummy
    favoriteFilms.value = [
      {'id': '550', 'title': 'Fight Club', 'posterUrl': 'https://example.com/posters/fight-club.jpg'},
      {'id': '13', 'title': 'Forrest Gump', 'posterUrl': 'https://example.com/posters/forrest-gump.jpg'},
      // Tambahkan film lain jika ada, maksimal 4
    ];
  }

  // Menambahkan film ke daftar favorit
  void addFavoriteFilm(Map<String, dynamic> film) {
    if (favoriteFilms.length < 4) {
      // Periksa film sudah ada di daftar atau tidak
      if (!favoriteFilms.any((element) => element['id'] == film['id'])) {
        favoriteFilms.add(film);
        hasChanges.value = true;
      } else {
        Get.snackbar('Info', 'Film ini sudah ada di daftar favorit');
      }
    } else {
      Get.snackbar('Batas Tercapai', 'Anda hanya dapat menambahkan maksimal 4 film favorit');
    }
  }

  // Menghapus film dari daftar favorit
  void removeFavoriteFilm(String filmId) {
    favoriteFilms.removeWhere((film) => film['id'] == filmId);
    hasChanges.value = true;
  }

  // Mengubah urutan film favorit
  void reorderFavoriteFilms(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final film = favoriteFilms.removeAt(oldIndex);
    favoriteFilms.insert(newIndex, film);
    hasChanges.value = true;
  }

  // Menyimpan perubahan ke penyimpanan lokal
  void saveFavoriteFilms() {
    // TODO: Implementasikan penyimpanan ke SharedPreferences atau database lokal
    Get.snackbar('Berhasil', 'Film favorit berhasil disimpan');
    hasChanges.value = false;
  }

  // Mencari film dari API Letterboxd atau TMDB
  Future<List<Map<String, dynamic>>> searchFilms(String query) async {
    // TODO: Implementasikan pencarian film dari API
    // Contoh respons dummy
    await Future.delayed(const Duration(seconds: 1)); // Simulasi delay API
    return [
      {'id': '550', 'title': 'Fight Club', 'posterUrl': 'https://example.com/posters/fight-club.jpg'},
      {'id': '13', 'title': 'Forrest Gump', 'posterUrl': 'https://example.com/posters/forrest-gump.jpg'},
      {'id': '27205', 'title': 'Inception', 'posterUrl': 'https://example.com/posters/inception.jpg'},
      {'id': '155', 'title': 'The Dark Knight', 'posterUrl': 'https://example.com/posters/dark-knight.jpg'},
      {'id': '680', 'title': 'Pulp Fiction', 'posterUrl': 'https://example.com/posters/pulp-fiction.jpg'},
    ].where((film) => film['title'].toString().toLowerCase().contains(query.toLowerCase())).toList();
  }
}