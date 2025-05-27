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
        automaticallyImplyLeading: false, // This removes the back arrow
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
              
              // Categories Row (removed Islam category)
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
                    _buildCategoryItem(Icons.auto_stories, 'Fiksi', onTap: () {
                      controller.navigateToCategory('Fiksi');
                    }),
                    _buildCategoryItem(Icons.school, 'Pendidikan', onTap: () {
                      controller.navigateToCategory('Pendidikan');
                    }),
                    _buildCategoryItem(Icons.sports_soccer, 'Olahraga', onTap: () {
                      controller.navigateToCategory('Olahraga');
                    }),
                    _buildCategoryItem(Icons.history_edu, 'Sejarah', onTap: () {
                      controller.navigateToCategory('Sejarah');
                    }),
                    _buildCategoryItem(Icons.public, 'Geografi', onTap: () {
                      controller.navigateToCategory('Geografi');
                    }),
                    _buildCategoryItem(Icons.translate, 'Bahasa', onTap: () {
                      controller.navigateToCategory('Bahasa');
                    }),
                  ],
                ),
              ),
              
              const SizedBox(height: 24.0),
              
              // Buku Terbaru
              _buildSectionHeader('Paling Banyak Dibaca', ''),
              const SizedBox(height: 12.0),
              SizedBox(
                height: 220.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildBookItem(
                      'Sunrise On The Reaping', 
                      'Leila S. Chudori', 
                      'assets/rilis3.png',
                      description: 'Novel yang mengisahkan tentang perjalanan hidup para aktivis yang hilang paksa pada masa Orde Baru. Cerita yang menyentuh tentang perjuangan, cinta, dan harapan di tengah kegelapan sejarah Indonesia.',
                      pageCount: '379',
                      publishDate: '2017',
                      ageRating: '17+',
                    ),
                    _buildBookItem(
                      'We Do Not Part', 
                      'Henry Manampiring', 
                      'assets/rilis2.png',
                      description: 'Buku yang membahas tentang filosofi Stoikisme dan bagaimana menerapkannya dalam kehidupan sehari-hari untuk mencapai ketenangan pikiran dan kebijaksanaan hidup.',
                      pageCount: '272',
                      publishDate: '2018',
                      ageRating: '13+',
                    ),
                    _buildBookItem(
                      'Strategi Menjinakkan DIPONEGORO', 
                      'Tere Liye', 
                      'assets/sejarah2.png',
                      description: 'Sebuah novel yang mengisahkan perjalanan pulang seorang anak yang telah lama merantau. Kisah tentang keluarga, pengampunan, dan makna dari kata "pulang".',
                      pageCount: '424',
                      publishDate: '2015',
                      ageRating: '13+',
                    ),
                    _buildBookItem(
                      'Panggail Aku Kartini Saja', 
                      'Oh Su Hyang', 
                      'assets/sejarah5.png',
                      description: 'Panduan praktis untuk meningkatkan kemampuan berkomunikasi dan berbicara di depan umum dengan percaya diri dan efektif.',
                      pageCount: '208',
                      publishDate: '2019',
                      ageRating: '13+',
                    ),
                    _buildBookItem(
                      'Bumi', 
                      'Tere Liye', 
                      'assets/rekomen4.png',
                      description: 'Melanjutkan serial Bumi, novel ini mengisahkan petualangan Raib, Ali, dan Seli dalam menghadapi tantangan baru di dunia paralel yang penuh misteri.',
                      pageCount: '320',
                      publishDate: '2016',
                      ageRating: '13+',
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24.0),
              
              // Rekomendasi Untuk Anda
              _buildSectionHeader('Rekomendasi Untuk Anda', ''),
              const SizedBox(height: 12.0),
              SizedBox(
                height: 220.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildBookItem(
                      'Atomic Habits', 
                      'James Clear', 
                      'assets/rekomen5.png',
                      description: 'Panduan praktis untuk membangun kebiasaan baik dan menghilangkan kebiasaan buruk melalui perubahan kecil yang memberikan hasil luar biasa.',
                      pageCount: '320',
                      publishDate: '2018',
                      ageRating: '13+',
                    ),
                    _buildBookItem(
                      'Sapiens', 
                      'Yuval Noah Harari', 
                      'assets/rekomen4.png',
                      description: 'Sejarah singkat umat manusia dari masa berburu hingga era digital. Harari mengeksplorasi bagaimana Homo sapiens menjadi spesies dominan di Bumi.',
                      pageCount: '512',
                      publishDate: '2011',
                      ageRating: '15+',
                    ),
                    _buildBookItem(
                      'Psikologi Kepribadian', 
                      'Alwisol', 
                      'assets/populer8.png',
                      description: 'Buku teks komprehensif tentang berbagai teori kepribadian dari perspektif psikologi, cocok untuk mahasiswa dan praktisi psikologi.',
                      pageCount: '456',
                      publishDate: '2019',
                      ageRating: '17+',
                    ),
                    _buildBookItem(
                      'Rich Dad Poor Dad', 
                      'Robert T. Kiyosaki', 
                      'assets/populer5.png',
                      description: 'Pelajaran tentang keuangan dan investasi yang diajarkan melalui perbandingan pola pikir dua ayah dengan filosofi hidup yang berbeda.',
                      pageCount: '336',
                      publishDate: '1997',
                      ageRating: '13+',
                    ),
                    _buildBookItem(
                      'The Psychology of Money', 
                      'Morgan Housel', 
                      'assets/olahraga12.png',
                      description: 'Eksplorasi mendalam tentang hubungan psikologi dan perilaku manusia dengan uang, investasi, dan pengambilan keputusan finansial.',
                      pageCount: '256',
                      publishDate: '2020',
                      ageRating: '15+',
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24.0),
              
              // Buku Best Seller
              _buildSectionHeader('Rekomendasi Minggu Ini', ''),
              const SizedBox(height: 12.0),
              SizedBox(
                height: 220.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildBookItem(
                      'Bumi', 
                      'Tere Liye', 
                      'assets/rekomen1.png',
                      description: 'Novel pertama dari serial Bumi yang mengisahkan petualangan Raib, gadis dengan kekuatan menghilang, dalam dunia paralel yang penuh dengan keajaiban dan bahaya.',
                      pageCount: '440',
                      publishDate: '2014',
                      ageRating: '13+',
                    ),
                    _buildBookItem(
                      'Sebuah Seni untuk Bersikap Bodo Amat', 
                      'Mark Manson', 
                      'assets/rekomen2.png',
                      description: 'Pendekatan kontroversial namun praktis untuk menjalani hidup yang lebih baik dengan fokus pada hal-hal yang benar-benar penting.',
                      pageCount: '224',
                      publishDate: '2016',
                      ageRating: '17+',
                    ),
                    _buildBookItem(
                      'Mindset', 
                      'Carol S. Dweck', 
                      'assets/rekomen3.png',
                      description: 'Penelitian psikologi tentang pola pikir tetap versus pola pikir berkembang dan bagaimana hal ini mempengaruhi kesuksesan dalam hidup.',
                      pageCount: '276',
                      publishDate: '2006',
                      ageRating: '13+',
                    ),
                    _buildBookItem(
                      'Quiet', 
                      'Susan Cain', 
                      'assets/rekomen4.png',
                      description: 'Eksplorasi mendalam tentang kekuatan introvert dalam dunia yang tidak bisa berhenti berbicara, mengungkap potensi tersembunyi kaum introvert.',
                      pageCount: '352',
                      publishDate: '2012',
                      ageRating: '15+',
                    ),
                    _buildBookItem(
                      'Ikigai', 
                      'Héctor García & Francesc Miralles', 
                      'assets/rekomen5.png',
                      description: 'Rahasia orang Jepang untuk hidup bahagia dan berumur panjang. Panduan menemukan tujuan hidup dan kebahagiaan sejati.',
                      pageCount: '208',
                      publishDate: '2016',
                      ageRating: '13+',
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32.0),
            ],
          ),
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
          _buildNavItem('Beranda', 0),
          _buildNavItem('Jelajahi', 1, isActive: true),
          _buildNavItem('Perpustakaan', 2),
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
          case 1: // Jelajahi - already on jelajahi page
            if (!isActive) {
              Get.offAllNamed('/jelajahi');
            }
            break;
          case 2: // Library
            Get.offAllNamed('/library');
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
  
  Widget _buildCategoryItem(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.0,
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color(0xFF00B14F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                icon,
                color: Color(0xFF00B14F),
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
                    color: Color(0xFF00B14F),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
  
  Widget _buildBookItem(
    String title, 
    String author, 
    String coverPath, {
    String? description,
    String? pageCount,
    String? publishDate,
    String? ageRating,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to detail page with book information
        controller.navigateToBookDetail(
          title: title,
          author: author,
          coverImage: coverPath,
          description: description,
          pageCount: pageCount,
          publishDate: publishDate,
          ageRating: ageRating,
        );
      },
      child: Container(
        width: 120.0,
        margin: const EdgeInsets.only(right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image from assets folder
            Container(
              height: 160.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3.0,
                    offset: const Offset(0, 2),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(coverPath),
                  fit: BoxFit.cover,
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
      ),
    );
  }
}