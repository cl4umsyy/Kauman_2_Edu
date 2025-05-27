import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../home/controllers/home_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Safely get access to the home controller for the navbar
    HomeController homeController;
    try {
      homeController = Get.find<HomeController>();
    } catch (e) {
      // If HomeController not found, create a new instance
      homeController = Get.put(HomeController());
    }
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Obx(() => Text(
          controller.username.value,
          style: const TextStyle(
            color: Color(0xFF00B14F),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          overflow: TextOverflow.ellipsis,
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF00B14F)),
            onPressed: () => _showOptionsMenu(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile header - Made responsive
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.015, // 1.5% of screen height
                  horizontal: 16,
                ),
                child: Center(
                  child: Column(
                    children: [
                      // Profile picture - Responsive size
                      Container(
                        width: screenWidth * 0.25, // 25% of screen width
                        height: screenWidth * 0.25,
                        constraints: const BoxConstraints(
                          minWidth: 80,
                          maxWidth: 120,
                          minHeight: 80,
                          maxHeight: 120,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF55C6B3),
                          image: const DecorationImage(
                            image: AssetImage('assets/kucing.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: const Color(0xFF00B14F), width: 2),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      // Bio - Made flexible
                      Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          controller.bio.value,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16, // Reduced from 18
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              
              const Divider(height: 1, color: Color(0xFFE0E0E0)),
              
              // Favorites section - Now using rectangle layout like recent activity
              _buildSection(
                title: 'BUKU FAVORIT',
                child: _buildBooksGrid(controller.favoriteBooks, showRating: false, screenWidth: screenWidth),
              ),
              
              const Divider(height: 1, color: Color(0xFFE0E0E0)),
              
              // Recent activity section
              _buildSection(
                title: 'AKTIVITAS TERBARU',
                child: _buildBooksGrid(controller.recentActivity, showRating: true, screenWidth: screenWidth),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/library');
                  },
                  child: const Text(
                    'Lihat aktivitas lainnya',
                    style: TextStyle(
                      color: Color(0xFF00B14F),
                      fontSize: 14, // Reduced from 16
                    ),
                  ),
                ),
              ),
              
              const Divider(height: 1, color: Color(0xFFE0E0E0)),
              
              // Ratings section
              _buildSection(
                title: 'DISTRIBUSI RATING',
                child: _buildRatingsDistribution(screenWidth),
              ),
              
              SizedBox(height: screenHeight * 0.05), // 5% of screen height
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildCustomBottomNavBar(),
    );
  }
  
  // Show options menu with Settings option
  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFF00B14F)),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFF00B14F)),
              title: const Text('Edit Profil'),
              onTap: () {
                Navigator.pop(context);
                _showEditProfileDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Color(0xFF00B14F)),
              title: const Text('Bagikan Profil'),
              onTap: () {
                Navigator.pop(context);
                Get.snackbar(
                  'Info',
                  'Fitur berbagi profil akan segera hadir',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF00B14F),
                  colorText: Colors.white,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  // Show edit profile dialog - Made responsive
  void _showEditProfileDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final usernameController = TextEditingController(text: controller.username.value);
    final bioController = TextEditingController(text: controller.bio.value);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit Profil', style: TextStyle(fontSize: 18)),
        contentPadding: const EdgeInsets.all(20),
        content: SizedBox(
          width: screenWidth * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.updateUsername(usernameController.text);
              controller.updateBio(bioController.text);
              Navigator.pop(context);
              Get.snackbar(
                'Berhasil',
                'Profil berhasil diperbarui',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF00B14F),
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B14F),
              foregroundColor: Colors.white,
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF00B14F),
              fontSize: 14, // Reduced from 16
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child,
      ],
    );
  }
  
  // Updated books grid with rectangle layout for both favorites and recent activity
  Widget _buildBooksGrid(dynamic booksData, {required bool showRating, required double screenWidth}) {
    return Obx(() {
      List<dynamic> books = [];
      
      if (booksData is RxList) {
        books = booksData.value;
      } else if (booksData is List) {
        books = booksData;
      }
      
      if (books.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(24), // Reduced padding
          child: Column(
            children: [
              Icon(
                Icons.menu_book_outlined,
                size: 48, // Reduced from 64
                color: Colors.grey[400],
              ),
              const SizedBox(height: 12),
              Text(
                showRating ? 'Belum ada aktivitas' : 'Belum ada buku favorit',
                style: TextStyle(
                  fontSize: 14, // Reduced from 16
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  showRating 
                      ? 'Mulai baca buku untuk melihat aktivitas'
                      : 'Tambahkan buku favorit di pengaturan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12, // Reduced from 13
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        );
      }
      
      // Calculate responsive grid
      int crossAxisCount = 4;
      if (screenWidth < 350) {
        crossAxisCount = 3;
      } else if (screenWidth > 500) {
        crossAxisCount = 5;
      }
      
      // Both favorites and recent activity now use rectangle layout (aspect ratio 0.6)
      double childAspectRatio = 0.6; // Rectangle layout for both sections
      
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12), // Reduced padding
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 8, // Reduced spacing
            mainAxisSpacing: 8,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return _buildBookItem(book, showRating);
          },
        ),
      );
    });
  }
  
  // Updated book item widget - both favorites and recent activity use same layout now
  Widget _buildBookItem(Map<String, dynamic> book, bool showRating) {
    return Column(
      children: [
        // Book cover - Rectangle layout for both favorites and recent activity
        Expanded(
          flex: 4, // Use flex 4 for rectangle layout for both sections
          child: GestureDetector(
            onTap: () => _showBookDetail(book),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), // Reduced radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3, // Reduced blur
                    offset: const Offset(0, 1),
                  ),
                ],
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: book['coverUrl'] != null
                    ? Image.asset(
                        book['coverUrl'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.menu_book,
                            color: Colors.white,
                            size: 24, // Reduced icon size
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.menu_book,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
              ),
            ),
          ),
        ),
        
        // Rating and notes (only for recent activity)
        if (showRating && book.containsKey('rating'))
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: _buildRatingStars(book['rating']?.toDouble() ?? 0.0),
                  ),
                  if (book['hasNotes'] == true) ...[
                    const SizedBox(width: 2),
                    const Icon(Icons.note, color: Color(0xFF00B14F), size: 10),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
  
  // Show book detail dialog - Made responsive
  void _showBookDetail(Map<String, dynamic> book) {
    final screenWidth = MediaQuery.of(Get.context!).size.width;
    
    showDialog(
      context: Get.context!,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(maxWidth: screenWidth * 0.85),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Book cover
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 100, // Reduced from 120
                  height: 150, // Reduced from 180
                  color: Colors.grey[300],
                  child: book['coverUrl'] != null
                      ? Image.asset(
                          book['coverUrl'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.menu_book,
                            color: Colors.white,
                            size: 40, // Reduced from 48
                          ),
                        )
                      : const Icon(
                          Icons.menu_book,
                          color: Colors.white,
                          size: 40,
                        ),
                ),
              ),
              const SizedBox(height: 16),
              // Book title
              Text(
                book['title'] ?? 'Unknown Title',
                style: const TextStyle(
                  fontSize: 16, // Reduced from 18
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Author
              Text(
                book['author'] ?? 'Unknown Author',
                style: TextStyle(
                  fontSize: 13, // Reduced from 14
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Genre (if available)
              if (book['genre'] != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00B14F).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    book['genre'],
                    style: const TextStyle(
                      fontSize: 11, // Reduced from 12
                      color: Color(0xFF00B14F),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              // Rating (if available)
              if (book['rating'] != null) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRatingStars(book['rating']?.toDouble() ?? 0.0),
                    const SizedBox(width: 8),
                    Text(
                      '${book['rating']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 20),
              // Close button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B14F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Color(0xFF00B14F), size: 12); // Reduced from 14
        } else if (index == rating.floor() && rating % 1 != 0) {
          return const Icon(Icons.star_half, color: Color(0xFF00B14F), size: 12);
        } else {
          return const Icon(Icons.star_border, color: Color(0xFF00B14F), size: 12);
        }
      }),
    );
  }
  
  Widget _buildRatingsDistribution(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12), // Reduced padding
      child: Container(
        padding: const EdgeInsets.all(16), // Reduced from 20
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8, // Reduced blur
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Rating summary
            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFF00B14F), size: 20), // Reduced from 24
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(() {
                    final total = controller.ratingsDistribution.reduce((a, b) => a + b);
                    return Text(
                      '$total total rating',
                      style: const TextStyle(
                        fontSize: 14, // Reduced from 16
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 12), // Reduced from 16
            // Distribution chart
            SizedBox(
              height: 80, // Reduced from 100
              child: Obx(() {
                final distribution = controller.ratingsDistribution;
                final maxValue = distribution.isEmpty ? 1 : distribution.reduce((a, b) => a > b ? a : b).toDouble();
                
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                    distribution.length,
                    (index) => Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${distribution[index]}',
                            style: TextStyle(
                              fontSize: 10, // Reduced from 12
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            width: screenWidth * 0.08, // Responsive width
                            constraints: const BoxConstraints(minWidth: 25, maxWidth: 40),
                            height: maxValue > 0 ? (distribution[index] / maxValue) * 50 : 0, // Reduced from 70
                            decoration: BoxDecoration(
                              color: const Color(0xFF00B14F).withOpacity(0.7 + (index * 0.05)),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              index + 1,
                              (starIndex) => const Icon(
                                Icons.star,
                                color: Color(0xFF00B14F),
                                size: 6, // Reduced from 8
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom navigation bar with responsive design
  Widget _buildCustomBottomNavBar() {
    return Container(
      height: 65, // Reduced from 70
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8, // Reduced blur
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('Beranda', Icons.home_rounded, 0),
            _buildNavItem('Jelajahi', Icons.search_rounded, 1),
            _buildNavItem('Perpustakaan', Icons.menu_book_rounded, 2),
            _buildNavItem('Akun', Icons.person_rounded, 3, isActive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, int index, {bool isActive = false}) {
    final Color activeColor = const Color(0xFF00B14F);
    final Color inactiveColor = Colors.grey;
    
    return Expanded(
      child: InkWell(
        onTap: () {
          if (!isActive) {
            switch(index) {
              case 0:
                Get.offAllNamed('/home');
                break;
              case 1:
                Get.offAllNamed('/jelajahi');
                break;
              case 2:
                Get.offAllNamed('/library');
                break;
              case 3:
                break;
            }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Active indicator
            Container(
              width: 50, // Reduced from 70
              height: 2, // Reduced from 3
              color: isActive ? activeColor : Colors.transparent,
              margin: const EdgeInsets.only(bottom: 6), // Reduced margin
            ),
            // Icon
            Icon(
              icon,
              color: isActive ? activeColor : inactiveColor,
              size: 22, // Reduced from 24
            ),
            const SizedBox(height: 3), // Reduced spacing
            // Label text
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeColor : inactiveColor,
                fontSize: 10, // Reduced from 12
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
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