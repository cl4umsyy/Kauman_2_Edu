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
        automaticallyImplyLeading: false, // This removes the back arrow
        title: const Text(
          'My Library',
          style: TextStyle(
            color: Color(0xFF00B14F),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF00B14F)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF00B14F)),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildLibraryContent(),
      bottomNavigationBar: _buildCustomBottomNavBar(),
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
            color: Color(0xFF00B14F).withOpacity(0.5),
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
              backgroundColor: Color(0xFF00B14F),
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
          // Tambahkan GestureDetector untuk navigasi ke detail
          GestureDetector(
            onTap: () => _navigateToDetail(book),
            child: ClipRRect(
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
                        color: Color(0xFF00B14F),
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

  // Method untuk navigasi ke halaman detail
  void _navigateToDetail(Map<String, dynamic> book) {
    Get.toNamed('/detail', arguments: {
      'title': book['title'],
      'author': book['author'],
      'coverImage': book['coverImage'],
      'pageCount': '200', // Default page count
      'publishDate': '2023', // Default publish date
      'ageRating': '8+', // Default age rating
      'description': _getBookDescription(book['title']), // Custom description based on title
    });
  }

  // Method untuk mendapatkan deskripsi buku berdasarkan judul
  String _getBookDescription(String title) {
    switch (title) {
      case 'Harry Potter and the Philosopher\'s Stone':
        return 'Harry Potter, a young wizard who discovers his magical heritage on his 11th birthday when he receives a letter of acceptance to Hogwarts School of Witchcraft and Wizardry. The story follows Harry as he learns about the wizarding world and discovers the truth about his parents\' death.';
      case 'The Lord of the Rings':
        return 'An epic high fantasy novel that follows the hobbit Frodo Baggins and the Fellowship of the Ring on their quest to destroy the One Ring and defeat the Dark Lord Sauron. Set in Middle-earth, this tale explores themes of friendship, courage, and the struggle between good and evil.';
      case 'To Kill a Mockingbird':
        return 'A gripping tale of racial injustice and loss of innocence set in the fictional town of Maycomb, Alabama, during the 1930s. The story is told through the eyes of Scout Finch, whose father Atticus defends a black man falsely accused of rape.';
      case '1984':
        return 'A dystopian social science fiction novel that presents a nightmarish vision of a totalitarian society. The story follows Winston Smith, a low-ranking member of the ruling Party in London, as he struggles against the oppressive surveillance state of Big Brother.';
      default:
        return 'A fascinating book that takes you on an incredible journey through its pages. Discover new worlds, meet interesting characters, and experience stories that will stay with you long after you finish reading.';
    }
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
          _buildNavItem('Beranda', 0),
          _buildNavItem('Jelajahi', 1),
          _buildNavItem('Perpustakaan', 2, isActive: true),
          _buildNavItem('Akun', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, int index, {bool isActive = false}) {
    final Color activeColor = Color(0xFF00B14F); // Green color
    final Color inactiveColor = Colors.grey;
    
    return InkWell(
      onTap: () {
        switch(index) {
          case 0: // Home
            Get.offAllNamed('/home');
            break;
          case 1: // Jelajahi
            Get.offAllNamed('/jelajahi');
            break;
          case 2: // Library - already on library page
            if (!isActive) {
              Get.offAllNamed('/library');
            }
            break;
          case 3: // Profile
            Get.offAllNamed('/profile');
            break;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Custom container to show active indicator line on top
          Container(
            width: 70,
            height: 3,
            color: isActive ? activeColor : Colors.transparent,
            margin: EdgeInsets.only(bottom: 8),
          ),
          // Icon without circular background
          Icon(
            _getIconForIndex(index),
            color: isActive ? activeColor : inactiveColor,
            size: 24,
          ),
          SizedBox(height: 5),
          // Label text
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
}