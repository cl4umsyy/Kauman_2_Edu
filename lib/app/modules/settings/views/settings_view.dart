import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
        actions: [
          Obx(() => controller.hasChanges.value
              ? IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: controller.saveFavoriteFilms,
                  tooltip: 'Simpan Perubahan',
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Pengaturan Film Favorit
          const Text(
            'Film Favorit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pilih hingga 4 film favorit untuk ditampilkan di profil Anda',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          
          // Daftar Film Favorit
          Obx(() {
            return controller.favoriteFilms.isEmpty
                ? _buildEmptyFavorites()
                : _buildFavoritesList();
          }),
          
          const SizedBox(height: 24),
          
          // Tombol tambah film favorit
          Obx(() => controller.favoriteFilms.length < 4
              ? ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Film Favorit'),
                  onPressed: () => _showFilmSearchDialog(context),
                )
              : const SizedBox.shrink()),
          
          const Divider(height: 32),
          
          // Pengaturan lainnya dapat ditambahkan di sini
          const ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Tema Aplikasi'),
            trailing: Icon(Icons.chevron_right),
          ),
          
          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifikasi'),
            trailing: Icon(Icons.chevron_right),
          ),
          
          const ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privasi'),
            trailing: Icon(Icons.chevron_right),
          ),
          
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('Keluar'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
  
  // Widget untuk menampilkan pesan ketika daftar favorit kosong
  Widget _buildEmptyFavorites() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'Belum ada film favorit yang dipilih',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
  
  // Widget untuk menampilkan daftar film favorit
  Widget _buildFavoritesList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ReorderableListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.favoriteFilms.length,
        onReorder: controller.reorderFavoriteFilms,
        itemBuilder: (context, index) {
          final film = controller.favoriteFilms[index];
          return ListTile(
            key: ValueKey(film['id']),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                film['posterUrl'],
                width: 40,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 40,
                  height: 60,
                  color: Colors.grey,
                  child: const Icon(Icons.movie, color: Colors.white),
                ),
              ),
            ),
            title: Text(film['title']),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => controller.removeFavoriteFilm(film['id']),
            ),
          );
        },
      ),
    );
  }
  
  // Dialog untuk mencari dan menambahkan film
  void _showFilmSearchDialog(BuildContext context) {
    final searchController = TextEditingController();
    final searchResults = <Map<String, dynamic>>[].obs;
    final isSearching = false.obs;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cari Film'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Ketik judul film...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: searchController.clear,
                  ),
                ),
                onSubmitted: (value) async {
                  if (value.trim().isNotEmpty) {
                    isSearching.value = true;
                    searchResults.value = await controller.searchFilms(value);
                    isSearching.value = false;
                  }
                },
              ),
              const SizedBox(height: 16),
              Obx(() {
                if (isSearching.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (searchResults.isEmpty) {
                  return const Text('Belum ada hasil pencarian');
                }
                
                return Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final film = searchResults[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            film['posterUrl'],
                            width: 40,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 40,
                              height: 60,
                              color: Colors.grey,
                              child: const Icon(Icons.movie, color: Colors.white),
                            ),
                          ),
                        ),
                        title: Text(film['title']),
                        onTap: () {
                          controller.addFavoriteFilm(film);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }
}