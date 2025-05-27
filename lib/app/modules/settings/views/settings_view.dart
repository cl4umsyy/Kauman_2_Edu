import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import 'dart:async';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        shadowColor: Colors.black12,
        actions: [
          Obx(() => controller.hasChanges.value
              ? Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: TextButton.icon(
                    icon: const Icon(Icons.save_outlined, size: 18),
                    label: const Text('Simpan'),
                    onPressed: controller.saveFavoriteBooks,
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            
            // Section Pengaturan Umum
            _buildGeneralSettingsSection(),
            
            const SizedBox(height: 32),
            
            // Section Akun
            _buildAccountSection(),
          ],
        ),
      ),
    );
  }
  
  // Section Buku Favorit
 
  
  // Section Pengaturan Umum
  Widget _buildGeneralSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.settings_outlined,
                color: Colors.blue[700],
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Pengaturan Umum',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildSettingsTile(
                icon: Icons.palette_outlined,
                title: 'Tema Aplikasi',
                subtitle: 'Pilih tema terang atau gelap',
                iconColor: Colors.purple,
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.notifications_outlined,
                title: 'Notifikasi',
                subtitle: 'Atur pemberitahuan aplikasi',
                iconColor: Colors.orange,
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.language_outlined,
                title: 'Bahasa',
                subtitle: 'Indonesia',
                iconColor: Colors.green,
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.security_outlined,
                title: 'Privasi & Keamanan',
                subtitle: 'Kelola data dan privasi Anda',
                iconColor: Colors.red,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // Section Akun
  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.person_outline,
                color: Colors.green[700],
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Akun',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildSettingsTile(
                icon: Icons.edit_outlined,
                title: 'Edit Profil',
                subtitle: 'Ubah informasi profil Anda',
                iconColor: Colors.blue,
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.help_outline,
                title: 'Bantuan & Dukungan',
                subtitle: 'FAQ dan hubungi support',
                iconColor: Colors.teal,
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.info_outline,
                title: 'Tentang Aplikasi',
                subtitle: 'Versi 1.0.0',
                iconColor: Colors.grey,
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingsTile(
                icon: Icons.logout_outlined,
                title: 'Keluar',
                subtitle: 'Keluar dari akun Anda',
                iconColor: Colors.red,
                onTap: () {
                  _showLogoutDialog();
                },
                isDestructive: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // Widget untuk tile pengaturan
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDestructive ? Colors.red : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[400],
      ),
    );
  }
  
  // Divider untuk pemisah
  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[100],
      indent: 68,
    );
  }
  
  // Widget untuk empty state buku favorit
  Widget _buildEmptyFavorites(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.menu_book_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada buku favorit',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tambahkan buku favorit untuk menampilkannya di profil Anda',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
  
  // Widget untuk daftar buku favorit
  Widget _buildFavoritesList() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ReorderableListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.favoriteBooks.length,
        onReorder: controller.reorderFavoriteBooks,
        itemBuilder: (context, index) {
          final book = controller.favoriteBooks[index];
          return Container(
            key: ValueKey(book['id']),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 48,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: book['coverUrl'] != null
                      ? Image.asset(
                          book['coverUrl'],
                          width: 48,
                          height: 72,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 48,
                            height: 72,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.menu_book, color: Colors.white, size: 24),
                          ),
                        )
                      : const Icon(Icons.menu_book, color: Colors.white, size: 24),
                ),
              ),
              title: Text(
                book['title'] ?? 'Unknown Title',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book['author'] ?? 'Unknown Author',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Posisi ${index + 1}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.drag_handle,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red, size: 20),
                    onPressed: () => _showDeleteConfirmation(book),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  // Dialog konfirmasi hapus buku
  void _showDeleteConfirmation(Map<String, dynamic> book) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Buku Favorit'),
        content: Text('Apakah Anda yakin ingin menghapus "${book['title']}" dari daftar favorit?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.removeFavoriteBook(book['id']);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
  
  // Dialog logout
  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Keluar dari Akun'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // TODO: Implement logout logic
              Get.snackbar('Info', 'Berhasil keluar dari akun');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
  
  // Dialog pencarian buku dengan real-time search
  void _showBookSearchDialog(BuildContext context) {
    final searchController = TextEditingController();
    final searchResults = <Map<String, dynamic>>[].obs;
    final isSearching = false.obs;
    final showPopularBooks = true.obs;
    Timer? debounceTimer;
    
    // Load popular books initially
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      searchResults.value = await controller.getPopularBooks();
    });
    
    void performSearch(String query) {
      if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
      
      debounceTimer = Timer(const Duration(milliseconds: 500), () async {
        if (query.trim().isEmpty) {
          showPopularBooks.value = true;
          searchResults.value = await controller.getPopularBooks();
        } else {
          showPopularBooks.value = false;
          isSearching.value = true;
          searchResults.value = await controller.searchBooks(query);
          isSearching.value = false;
        }
      });
    }
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Cari Buku Favorit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      debounceTimer?.cancel();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Ketik judul buku, pengarang, atau genre...',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      performSearch('');
                    },
                  ),
                ),
                onChanged: performSearch,
                autofocus: true,
              ),
              
              const SizedBox(height: 20),
              
              // Header untuk menunjukkan status
              Obx(() => Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  showPopularBooks.value 
                      ? 'Buku Populer' 
                      : 'Hasil Pencarian (${searchResults.length})',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              )),
              
              const SizedBox(height: 12),
              
              Expanded(
                child: Obx(() {
                  if (isSearching.value) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Mencari buku...'),
                        ],
                      ),
                    );
                  }
                  
                  if (searchResults.isEmpty && !showPopularBooks.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Buku tidak ditemukan',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Coba kata kunci yang berbeda',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final book = searchResults[index];
                      final isAlreadyFavorite = controller.favoriteBooks
                          .any((element) => element['id'] == book['id']);
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 48,
                              height: 72,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: book['coverUrl'] != null
                                  ? Image.asset(
                                      book['coverUrl'],
                                      width: 48,
                                      height: 72,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        width: 48,
                                        height: 72,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(Icons.menu_book, color: Colors.white),
                                      ),
                                    )
                                  : const Icon(Icons.menu_book, color: Colors.white),
                            ),
                          ),
                          title: Text(
                            book['title'] ?? 'Unknown Title',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book['author'] ?? 'Unknown Author',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  book['genre'] ?? '',
                                  style: TextStyle(
                                    color: Colors.blue[700],
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: isAlreadyFavorite
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Dipilih',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                    size: 20,
                                  ),
                                ),
                          onTap: isAlreadyFavorite
                              ? null
                              : () {
                                  controller.addFavoriteBook(book);
                                  debounceTimer?.cancel();
                                  Navigator.of(context).pop();
                                },
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}