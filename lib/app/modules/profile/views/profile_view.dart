import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../home/controllers/home_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Safely get access to the home controller for the navbar
    HomeController homeController;
    try {
      homeController = Get.find<HomeController>();
    } catch (e) {
      // If HomeController not found, create a new instance
      homeController = Get.put(HomeController());
    }
    
    return Scaffold(
      backgroundColor: Colors.white, // White background to match home page
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4CD964)),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
          controller.username.value,
          style: const TextStyle(
            color: Color(0xFF4CD964),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF4CD964)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    // Profile picture
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF55C6B3),
                        image: const DecorationImage(
                          image: AssetImage('assets/kucing.png'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: const Color(0xFF4CD964), width: 2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Bio
                    Obx(() => Text(
                      controller.bio.value,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    )),
                  ],
                ),
              ),
            ),
            
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            
            // Favorites section
            _buildSection(
              title: 'FAVORITES',
              child: _buildMovieGrid(controller.favoriteMovies, showRating: false),
            ),
            
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            
            // Recent activity section
            _buildSection(
              title: 'RECENT ACTIVITY',
              child: _buildMovieGrid(controller.recentActivity, showRating: true),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: InkWell(
                onTap: () {},
                child: const Text(
                  'More activity',
                  style: TextStyle(
                    color: Color(0xFF4CD964),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            
            // Ratings section
            _buildSection(
              title: 'RATINGS',
              child: _buildRatingsDistribution(),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(homeController),
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
              color: Color(0xFF4CD964),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child,
      ],
    );
  }
  
  Widget _buildMovieGrid(List<dynamic> movies, {required bool showRating}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Column(
            children: [
              // Movie poster without title
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: AssetImage(movie['posterUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              
              // Rating stars (if needed)
              if (showRating && movie.containsKey('rating'))
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildRatingStars(movie['rating']),
                      const SizedBox(width: 4),
                      if (movie['hasNotes'] == true)
                        const Icon(Icons.menu, color: Color(0xFF4CD964), size: 16),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Color(0xFF4CD964), size: 12);
        } else if (index == rating.floor() && rating % 1 != 0) {
          return const Icon(Icons.star_half, color: Color(0xFF4CD964), size: 12);
        } else {
          return const Icon(Icons.star_border, color: Color(0xFF4CD964), size: 12);
        }
      }),
    );
  }
  
  Widget _buildRatingsDistribution() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            const Icon(Icons.star, color: Color(0xFF4CD964), size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Obx(() {
                final distribution = controller.ratingsDistribution;
                final maxValue = distribution.reduce((a, b) => a > b ? a : b).toDouble();
                
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                    distribution.length,
                    (index) => Container(
                      width: 40,
                      height: (distribution[index] / maxValue) * 80,
                      color: const Color(0xFF4CD964).withOpacity(0.7 + (index * 0.05)),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(width: 8),
            Row(
              children: List.generate(
                5,
                (index) => const Icon(Icons.star, color: Color(0xFF4CD964), size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Navbar yang telah diperbaiki
  Widget _buildBottomNavBar(HomeController homeController) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF4CD964),
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
          _buildNavItem(Icons.home_rounded, 'Beranda', onTap: () => Get.offNamed('/home')),
          _buildNavItem(Icons.search_rounded, 'Jelajahi', onTap: () => Get.offNamed('/search')),
          _buildNavItem(Icons.menu_book_rounded, 'Perpustakaan', onTap: () => Get.offNamed('/library')),
          _buildNavItem(Icons.person_rounded, 'Profil', isActive: true),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {Function()? onTap, bool isActive = false}) {
    return InkWell(
      onTap: isActive ? null : onTap,
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