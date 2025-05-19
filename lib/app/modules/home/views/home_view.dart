import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildSectionHeader('Buku Teratas!', onViewAll: () {}),
                    const SizedBox(height: 16),
                    _buildHorizontalBookList(controller.topBooks),
                    const SizedBox(height: 32),
                    _buildSectionHeader('Buku Sekolah', onViewAll: () {}),
                    const SizedBox(height: 16),
                    _buildHorizontalBookList(controller.studyGuides),
                    const SizedBox(height: 32),
                    _buildSectionHeader('Cerita Rakyat', onViewAll: () {}),
                    const SizedBox(height: 16),
                    _buildHorizontalBookList(controller.ceritaRakyat),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFF4CD964),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_rounded, 0, 'Beranda', isActive: true),
          _buildNavItem(Icons.search_rounded, 1, 'Jelajahi'),
          _buildNavItem(Icons.menu_book_rounded, 2, 'Perpustakaan'),
          _buildNavItem(Icons.person_rounded, 3, 'Profil'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label, {bool isActive = false}) {
    return InkWell(
      onTap: () {
        // Update the controller index regardless of navigation
        controller.updateIndex(index);
        
        // Handle navigation based on the selected index
        switch(index) {
          case 0: // Home - already on home page, no navigation needed
            break;
          case 1: // Search
            Get.toNamed('/jelajahi');
            break;
          case 2: // Library
            Get.toNamed('/library');
            break;
          case 3: // Profile
            Get.toNamed('/profile');
            break;
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

  // Rest of the methods remain the same
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/kucing.png'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Hello, Claumsyy!',
            style: TextStyle(
              color: Color(0xFF4CD964),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFF4CD964), width: 1),
            ),
            child: Icon(Icons.settings_outlined, color: Color(0xFF4CD964), size: 20),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFF4CD964), width: 1),
            ),
            child: Icon(Icons.notifications_outlined, color: Color(0xFF4CD964), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF4CD964), width: 1.5),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search books, topics, etc...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 16, bottom: 4),
                ),
              ),
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.search, color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required Function onViewAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4CD964),
            ),
          ),
          TextButton(
            onPressed: () => onViewAll(),
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'View all',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF4CD964).withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalBookList(List<Map<String, String>> books) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        padding: EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          return _buildBookCard(books[index]);
        },
      ),
    );
  }

  Widget _buildBookCard(Map<String, String> book) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/login');
      },
      child: Container(
        width: 130,
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Image.asset(
                        book['coverImage'] ?? 'assets/kucing.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(Icons.book, color: Colors.grey),
                            ),
                          );
                        },
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.transparent,
                              ],
                              stops: [0.0, 0.5],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (book['title'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  book['title']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (book['author'] != null)
              Text(
                book['author']!,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}