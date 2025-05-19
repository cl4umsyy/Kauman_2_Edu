import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/library_controller.dart';

class LibraryView extends GetView<LibraryController> {
  const LibraryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Library',
          style: TextStyle(
            color: Color(0xFF4CD964),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF4CD964)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF4CD964)),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildLibraryContent(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildLibraryContent() {
    return Obx(() => controller.books.isEmpty
      ? _buildEmptyLibrary()
      : _buildBooksList()
    );
  }

  Widget _buildEmptyLibrary() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: Color(0xFF4CD964).withOpacity(0.5),
            size: 80,
          ),
          const SizedBox(height: 16),
          Text(
            'Your library is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Books you save will appear here',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Get.toNamed('/home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4CD964),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text('Browse Books'),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: controller.books.length,
      itemBuilder: (context, index) {
        final book = controller.books[index];
        return _buildBookItem(book);
      },
    );
  }

  Widget _buildBookItem(Map<String, dynamic> book) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              book['coverImage'],
              width: 80,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 120,
                  color: Colors.grey[200],
                  child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    book['author'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        size: 16,
                        color: Color(0xFF4CD964),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${book['progress']}% completed',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey[600],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // Bottom Navigation Bar with consistent navigation
  Widget _buildBottomNavBar() {
    return Container(
      height: 60, // Height for navbar
      decoration: BoxDecoration(
        color: Color(0xFF4CD964), // Green background color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_rounded, 'Beranda', '/home'),
          _buildNavItem(Icons.search_rounded, 'Jelajahi', '/jelajahi'),
          _buildNavItem(Icons.menu_book_rounded, 'Perpustakaan', '/library', isActive: true),
          _buildNavItem(Icons.person_rounded, 'Profil', '/profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, String route, {bool isActive = false}) {
    return InkWell(
      onTap: () {
        if (route != '/library' || !isActive) {
          Get.offAllNamed(route);
        }
      },
      child: Container(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
              size: 26,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}