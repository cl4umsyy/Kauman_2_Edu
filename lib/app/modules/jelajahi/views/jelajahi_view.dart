import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/jelajahi_controller.dart';

class JelajahiView extends GetView<JelajahiController> {
  const JelajahiView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jelajahi'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari buku, penulis, atau penerbit...',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              
              const SizedBox(height: 24.0),
              
              // Categories Row
              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 18.0, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                height: 100.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildCategoryItem(Icons.book, 'Fiksi'),
                    _buildCategoryItem(Icons.school, 'Pendidikan'),
                    _buildCategoryItem(Icons.business, 'Bisnis'),
                    _buildCategoryItem(Icons.favorite, 'Romansa'),
                    _buildCategoryItem(Icons.psychology, 'Pengembangan Diri'),
                    _buildCategoryItem(Icons.menu_book, 'Agama'),
                    _buildCategoryItem(Icons.public, 'Sastra Dunia'),
                  ],
                ),
              ),
              
              const SizedBox(height: 24.0),
              
              // Buku Terbaru
              _buildSectionHeader('Buku Terbaru', ''),
              const SizedBox(height: 12.0),
              SizedBox(
                height: 220.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildBookItem('Laut Bercerita', 'Leila S. Chudori'),
                    _buildBookItem('Filosofi Teras', 'Henry Manampiring'),
                    _buildBookItem('Pulang', 'Tere Liye'),
                    _buildBookItem('Bicara Itu Ada Seninya', 'Oh Su Hyang'),
                    _buildBookItem('Hujan', 'Tere Liye'),
                  ],
                ),
              ),
              
              const SizedBox(height: 24.0),
              
              // Rekomendasi Untuk Anda
              _buildSectionHeader('Rekomendasi Untuk Anda', 'Lihat Semua'),
              const SizedBox(height: 12.0),
              SizedBox(
                height: 220.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildBookItem('Atomic Habits', 'James Clear'),
                    _buildBookItem('Sapiens', 'Yuval Noah Harari'),
                    _buildBookItem('Psikologi Kepribadian', 'Alwisol'),
                    _buildBookItem('Rich Dad Poor Dad', 'Robert T. Kiyosaki'),
                    _buildBookItem('The Psychology of Money', 'Morgan Housel'),
                  ],
                ),
              ),
              
              const SizedBox(height: 24.0),
              
              // Buku Best Seller
              _buildSectionHeader('Best Seller', 'Lihat Semua'),
              const SizedBox(height: 12.0),
              SizedBox(
                height: 220.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildBookItem('Bumi', 'Tere Liye'),
                    _buildBookItem('Sebuah Seni untuk Bersikap Bodo Amat', 'Mark Manson'),
                    _buildBookItem('Mindset', 'Carol S. Dweck'),
                    _buildBookItem('Quiet', 'Susan Cain'),
                    _buildBookItem('Ikigai', 'Héctor García & Francesc Miralles'),
                  ],
                ),
              ),
              
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }
  
  Widget _buildBottomNavBar() {
    return Container(
      height: 60, // Tinggi untuk navbar
      decoration: BoxDecoration(
        color: Color(0xFF4CD964), // Warna background hijau yang sama dengan halaman lain
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
          _buildNavItem(Icons.home_rounded, 'Beranda', '/home'),
          _buildNavItem(Icons.search_rounded, 'Jelajahi', '/jelajahi', isActive: true),
          _buildNavItem(Icons.menu_book_rounded, 'Perpustakaan', '/library'),
          _buildNavItem(Icons.person_rounded, 'Profil', '/profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, String route, {bool isActive = false}) {
    return InkWell(
      onTap: () {
        if (route != '/jelajahi' || !isActive) {
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
  
  Widget _buildCategoryItem(IconData icon, String title) {
    return Container(
      width: 80.0,
      margin: const EdgeInsets.only(right: 12.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 28.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0, 
            fontWeight: FontWeight.bold,
          ),
        ),
        action.isNotEmpty
            ? TextButton(
                onPressed: () {},
                child: Text(
                  action,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
  
  Widget _buildBookItem(String title, String author) {
    return Container(
      width: 120.0,
      margin: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Image
          Container(
            height: 160.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.book,
                size: 40.0,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}