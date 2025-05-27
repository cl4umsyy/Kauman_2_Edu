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
                    _buildSectionHeader('Buku Populer!', onViewAll: () {
                      Get.toNamed('/viewall', arguments: {'title': 'Buku Populer!'});
                    }),
                    const SizedBox(height: 16),
                    _buildHorizontalBookList(controller.topBooks),
                    const SizedBox(height: 32),
                    _buildSectionHeader('Baru dirilis', onViewAll: () {
                      Get.toNamed('/viewall', arguments: {'title': 'Buku Baru Dirilis'});
                    }),
                    const SizedBox(height: 16),
                    _buildHorizontalBookList(controller.studyGuides),
                    const SizedBox(height: 32),
                    _buildSectionHeader('Majalah Bulan Ini', onViewAll: () {
                      Get.toNamed('/viewall', arguments: {'title': 'Majalah Bulan Ini'});
                    }),
                    const SizedBox(height: 16),
                    _buildHorizontalBookList(controller.monthlyMagazines),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildCustomBottomNavBar(),
    );
  }

  Widget _buildCustomBottomNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('Beranda', 'assets/kucing.png', 0, isActive: true),
          _buildNavItem('Jelajahi', 'assets/kucing.png', 1),
          _buildNavItem('Perpustakaan', 'assets/kucing.png', 2),
          _buildNavItem('Akun', 'assets/kucing.png', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String iconAsset, int index, {bool isActive = false}) {
    final Color activeColor = Color(0xFF00B14F);
    final Color inactiveColor = Colors.grey;
    
    return InkWell(
      onTap: () {
        controller.updateIndex(index);
        
        switch(index) {
          case 0: // Home - already on home page
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 3,
            color: isActive ? activeColor : Colors.transparent,
            margin: EdgeInsets.only(bottom: 8),
          ),
          Icon(
            _getIconForIndex(index),
            color: isActive ? activeColor : inactiveColor,
            size: 24,
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isActive ? activeColor : inactiveColor,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home_rounded;
      case 1:
        return Icons.search_rounded;
      case 2:
        return Icons.menu_book_rounded;
      case 3:
        return Icons.person_rounded;
      default:
        return Icons.home_rounded;
    }
  }

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
            'Hello!',
            style: TextStyle(
              color: Color(0xFF00B14F),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => Get.toNamed('/settings'),
            child: Container(
              width: 40,
              height: 40,
              child: Icon(Icons.settings_outlined, color: Color(0xFF00B14F), size: 30),
            ),
          ),
          const SizedBox(width: 8),
          // Updated notification icon with navigation
          GestureDetector(
            onTap: () => Get.toNamed('/notifikasi'),
            child: Container(
              width: 40,
              height: 40,
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.notifications_outlined, 
                      color: Color(0xFF00B14F), 
                      size: 30
                    ),
                  ),
                  // Optional: Add notification badge
                  // Positioned(
                  //   right: 8,
                  //   top: 8,
                  //   child: Container(
                  //     padding: EdgeInsets.all(2),
                  //     decoration: BoxDecoration(
                  //       color: Colors.red,
                  //       borderRadius: BorderRadius.circular(6),
                  //     ),
                  //     constraints: BoxConstraints(
                  //       minWidth: 12,
                  //       minHeight: 12,
                  //     ),
                  //     child: Text(
                  //       '3', // Replace with actual unread count
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 8,
                  //       ),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
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
          border: Border.all(color: Color(0xFF00B14F), width: 1.5),
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
              color: Colors.black87,
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
                color: Color(0xFF00B14F).withOpacity(0.8),
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
        Get.toNamed('/detail', arguments: {
          'title': book['title'] ?? 'Unknown Title',
          'author': book['author'] ?? 'Unknown Author',
          'coverImage': book['coverImage'] ?? 'assets/kucing.png',
        });
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