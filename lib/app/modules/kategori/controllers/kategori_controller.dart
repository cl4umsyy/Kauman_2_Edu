import 'package:get/get.dart';

class KategoriController extends GetxController {
  final selectedCategory = 'Fiksi'.obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;
  final isGridView = true.obs;
  final isFilterApplied = false.obs;
  final filterType = ''.obs; // 'rating', 'popular'
  
  // Updated categories (only 6 main categories)
  final categories = [
    'Fiksi',
    'Pendidikan',
    'Olahraga',
    'Sejarah',
    'Geografi',
    'Bahasa'
  ].obs;
  
  // Sample data dengan detail untuk navigasi ke halaman detail
  final books = <Map<String, dynamic>>[
    // KATEGORI FIKSI - 12 BUKU
    {
      'title': 'Negeri 5 Menara',
      'author': 'Ahmad Fuadi',
      'category': 'Fiksi',
      'rating': 4.5,
      'image': 'assets/fiksi1.png',
      'isPopular': true,
    },
    {
      'title': 'Ronggeng Dukuh Paruk',
      'author': 'Ahmad Tohari',
      'category': 'Fiksi',
      'rating': 4.6,
      'image': 'assets/fiksi2.png',
      'isPopular': false,
    },
    {
      'title': 'Pulang',
      'author': 'Tere Liye',
      'category': 'Fiksi',
      'rating': 4.4,
      'image': 'assets/fiksi3.png',
      'isPopular': true,
    },
    {
      'title': 'Bumi Manusia',
      'author': 'Pramoedya Ananta Toer',
      'category': 'Fiksi',
      'rating': 4.8,
      'image': 'assets/fiksi4.png',
      'isPopular': true,
    },
    {
      'title': 'Laskar Pelangi',
      'author': 'Andrea Hirata',
      'category': 'Fiksi',
      'rating': 4.7,
      'image': 'assets/fiksi5.png',
      'isPopular': true,
    },
    {
      'title': 'Ayat-Ayat Cinta',
      'author': 'Habiburrahman El Shirazy',
      'category': 'Fiksi',
      'rating': 4.3,
      'image': 'assets/fiksi6.png',
      'isPopular': false,
    },
    {
      'title': 'Sang Pemimpi',
      'author': 'Andrea Hirata',
      'category': 'Fiksi',
      'rating': 4.5,
      'image': 'assets/fiksi7.png',
      'isPopular': false,
    },
    {
      'title': 'Perahu Kertas',
      'author': 'Dee Lestari',
      'category': 'Fiksi',
      'rating': 4.2,
      'image': 'assets/fiksi8.png',
      'isPopular': false,
    },
    {
      'title': 'Matahari',
      'author': 'Tere Liye',
      'category': 'Fiksi',
      'rating': 4.4,
      'image': 'assets/fiksi9.png',
      'isPopular': false,
    },
    {
      'title': 'Bulan',
      'author': 'Tere Liye',
      'category': 'Fiksi',
      'rating': 4.3,
      'image': 'assets/fiksi10.png',
      'isPopular': false,
    },
    {
      'title': 'Bintang',
      'author': 'Tere Liye',
      'category': 'Fiksi',
      'rating': 4.5,
      'image': 'assets/fiksi11.png',
      'isPopular': false,
    },
    {
      'title': 'Hujan',
      'author': 'Tere Liye',
      'category': 'Fiksi',
      'rating': 4.6,
      'image': 'assets/fiksi12.png',
      'isPopular': false,
    },
    
    // KATEGORI PENDIDIKAN - 12 BUKU
    {
      'title': 'Pendidikan Karakter',
      'author': 'Thomas Lickona',
      'category': 'Pendidikan',
      'rating': 4.3,
      'image': 'assets/pendidikan1.png',
      'isPopular': false,
    },
    {
      'title': 'Sekolah Anak-Anak Juara',
      'author': 'Munif Chatib',
      'category': 'Pendidikan',
      'rating': 4.4,
      'image': 'assets/pendidikan2.png',
      'isPopular': true,
    },
    {
      'title': 'Guru Sejati',
      'author': 'Jeanne Marie Laskas',
      'category': 'Pendidikan',
      'rating': 4.2,
      'image': 'assets/pendidikan3.png',
      'isPopular': false,
    },
    {
      'title': 'Filosofi Teras',
      'author': 'Henry Manampiring',
      'category': 'Pendidikan',
      'rating': 4.7,
      'image': 'assets/pendidikan4.png',
      'isPopular': true,
    },
    {
      'title': 'Atomic Habits',
      'author': 'James Clear',
      'category': 'Pendidikan',
      'rating': 4.8,
      'image': 'assets/pendidikan5.png',
      'isPopular': true,
    },
    {
      'title': 'Mindset',
      'author': 'Carol S. Dweck',
      'category': 'Pendidikan',
      'rating': 4.5,
      'image': 'assets/pendidikan6.png',
      'isPopular': false,
    },
    {
      'title': 'The 7 Habits',
      'author': 'Stephen Covey',
      'category': 'Pendidikan',
      'rating': 4.6,
      'image': 'assets/pendidikan7.png',
      'isPopular': true,
    },
    {
      'title': 'Sebuah Seni untuk Bersikap Bodo Amat',
      'author': 'Mark Manson',
      'category': 'Pendidikan',
      'rating': 4.3,
      'image': 'assets/pendidikan8.png',
      'isPopular': false,
    },
    {
      'title': 'Rich Dad Poor Dad',
      'author': 'Robert Kiyosaki',
      'category': 'Pendidikan',
      'rating': 4.4,
      'image': 'assets/pendidikan9.png',
      'isPopular': false,
    },
    {
      'title': 'Think and Grow Rich',
      'author': 'Napoleon Hill',
      'category': 'Pendidikan',
      'rating': 4.5,
      'image': 'assets/pendidikan10.png',
      'isPopular': false,
    },
    {
      'title': 'How to Win Friends',
      'author': 'Dale Carnegie',
      'category': 'Pendidikan',
      'rating': 4.6,
      'image': 'assets/pendidikan11.png',
      'isPopular': false,
    },
    {
      'title': 'The Power of Now',
      'author': 'Eckhart Tolle',
      'category': 'Pendidikan',
      'rating': 4.4,
      'image': 'assets/pendidikan12.png',
      'isPopular': false,
    },
    
    // KATEGORI OLAHRAGA - 12 BUKU
    {
      'title': 'Seni Bertarung',
      'author': 'Bruce Lee',
      'category': 'Olahraga',
      'rating': 4.6,
      'image': 'assets/olahraga1.png',
      'isPopular': true,
    },
    {
      'title': 'Psikologi Olahraga',
      'author': 'Jim Taylor',
      'category': 'Olahraga',
      'rating': 4.3,
      'image': 'assets/olahraga2.png',
      'isPopular': false,
    },
    {
      'title': 'Sepak Bola Indonesia',
      'author': 'Akmal Marhali',
      'category': 'Olahraga',
      'rating': 4.1,
      'image': 'assets/olahraga3.png',
      'isPopular': false,
    },
    {
      'title': 'The Champion Mindset',
      'author': 'Joanna Zeiger',
      'category': 'Olahraga',
      'rating': 4.4,
      'image': 'assets/olahraga4.png',
      'isPopular': false,
    },
    {
      'title': 'Basketball Fundamentals',
      'author': 'John Wooden',
      'category': 'Olahraga',
      'rating': 4.5,
      'image': 'assets/olahraga5.png',
      'isPopular': true,
    },
    {
      'title': 'Swimming Science',
      'author': 'G. John Mullen',
      'category': 'Olahraga',
      'rating': 4.2,
      'image': 'assets/olahraga6.png',
      'isPopular': false,
    },
    {
      'title': 'Running Formula',
      'author': 'Jack Daniels',
      'category': 'Olahraga',
      'rating': 4.7,
      'image': 'assets/olahraga7.png',
      'isPopular': false,
    },
    {
      'title': 'Tennis Tactics',
      'author': 'United States Tennis Association',
      'category': 'Olahraga',
      'rating': 4.3,
      'image': 'assets/olahraga8.png',
      'isPopular': false,
    },
    {
      'title': 'Volleyball Systems',
      'author': 'Bill Neville',
      'category': 'Olahraga',
      'rating': 4.1,
      'image': 'assets/olahraga9.png',
      'isPopular': false,
    },
    {
      'title': 'Badminton Techniques',
      'author': 'Tony Grice',
      'category': 'Olahraga',
      'rating': 4.4,
      'image': 'assets/olahraga10.png',
      'isPopular': false,
    },
    {
      'title': 'Fitness Science',
      'author': 'Austin Goh',
      'category': 'Olahraga',
      'rating': 4.5,
      'image': 'assets/olahraga11.png',
      'isPopular': false,
    },
    {
      'title': 'Yoga Practice',
      'author': 'B.K.S. Iyengar',
      'category': 'Olahraga',
      'rating': 4.6,
      'image': 'assets/olahraga12.png',
      'isPopular': false,
    },
    
    // KATEGORI SEJARAH - 12 BUKU
    {
      'title': 'Sejarah Indonesia Modern',
      'author': 'M.C. Ricklefs',
      'category': 'Sejarah',
      'rating': 4.7,
      'image': 'assets/sejarah1.png',
      'isPopular': true,
    },
    {
      'title': 'Majapahit',
      'author': 'Slamet Muljana',
      'category': 'Sejarah',
      'rating': 4.5,
      'image': 'assets/sejarah2.png',
      'isPopular': false,
    },
    {
      'title': 'Perang Dunia II',
      'author': 'Antony Beevor',
      'category': 'Sejarah',
      'rating': 4.8,
      'image': 'assets/sejarah3.png',
      'isPopular': true,
    },
    {
      'title': 'Sriwijaya',
      'author': 'George Coedes',
      'category': 'Sejarah',
      'rating': 4.4,
      'image': 'assets/sejarah4.png',
      'isPopular': false,
    },
    {
      'title': 'Kemerdekaan Indonesia',
      'author': 'Anton E. Lucas',
      'category': 'Sejarah',
      'rating': 4.6,
      'image': 'assets/sejarah5.png',
      'isPopular': true,
    },
    {
      'title': 'Sejarah Dunia Kuno',
      'author': 'Susan Wise Bauer',
      'category': 'Sejarah',
      'rating': 4.3,
      'image': 'assets/sejarah6.png',
      'isPopular': false,
    },
    {
      'title': 'Revolusi Industri',
      'author': 'Peter N. Stearns',
      'category': 'Sejarah',
      'rating': 4.2,
      'image': 'assets/sejarah7.png',
      'isPopular': false,
    },
    {
      'title': 'Sejarah Peradaban Islam',
      'author': 'Marshall G.S. Hodgson',
      'category': 'Sejarah',
      'rating': 4.5,
      'image': 'assets/sejarah8.png',
      'isPopular': false,
    },
    {
      'title': 'Kerajaan Mataram',
      'author': 'H.J. de Graaf',
      'category': 'Sejarah',
      'rating': 4.3,
      'image': 'assets/sejarah9.png',
      'isPopular': false,
    },
    {
      'title': 'Perang Dingin',
      'author': 'John Lewis Gaddis',
      'category': 'Sejarah',
      'rating': 4.4,
      'image': 'assets/sejarah10.png',
      'isPopular': false,
    },
    {
      'title': 'Sejarah Eropa',
      'author': 'Norman Davies',
      'category': 'Sejarah',
      'rating': 4.6,
      'image': 'assets/sejarah11.png',
      'isPopular': false,
    },
    {
      'title': 'Colonialism Indonesia',
      'author': 'Robert Cribb',
      'category': 'Sejarah',
      'rating': 4.1,
      'image': 'assets/sejarah12.png',
      'isPopular': false,
    },
    
    // KATEGORI GEOGRAFI - 12 BUKU
    {
      'title': 'Atlas Indonesia',
      'author': 'Tim Geografi ITB',
      'category': 'Geografi',
      'rating': 4.4,
      'image': 'assets/geografi1.png',
      'isPopular': true,
    },
    {
      'title': 'Geografi Fisik Indonesia',
      'author': 'Bintarto',
      'category': 'Geografi',
      'rating': 4.2,
      'image': 'assets/geografi2.png',
      'isPopular': false,
    },
    {
      'title': 'Peta Dunia Modern',
      'author': 'National Geographic',
      'category': 'Geografi',
      'rating': 4.6,
      'image': 'assets/geografi3.png',
      'isPopular': true,
    },
    {
      'title': 'Geografi Regional',
      'author': 'Harm J. de Blij',
      'category': 'Geografi',
      'rating': 4.3,
      'image': 'assets/geografi4.png',
      'isPopular': false,
    },
    {
      'title': 'Climate Change Geography',
      'author': 'John L. Innes',
      'category': 'Geografi',
      'rating': 4.5,
      'image': 'assets/geografi5.png',
      'isPopular': false,
    },
    {
      'title': 'Urban Geography',
      'author': 'Tim Hall',
      'category': 'Geografi',
      'rating': 4.1,
      'image': 'assets/geografi6.png',
      'isPopular': false,
    },
    {
      'title': 'Economic Geography',
      'author': 'Brett Christophers',
      'category': 'Geografi',
      'rating': 4.2,
      'image': 'assets/geografi7.png',
      'isPopular': false,
    },
    {
      'title': 'Population Geography',
      'author': 'John I. Clarke',
      'category': 'Geografi',
      'rating': 4.0,
      'image': 'assets/geografi8.png',
      'isPopular': false,
    },
    {
      'title': 'Political Geography',
      'author': 'Colin Flint',
      'category': 'Geografi',
      'rating': 4.3,
      'image': 'assets/geografi9.png',
      'isPopular': false,
    },
    {
      'title': 'Cultural Geography',
      'author': 'Mike Crang',
      'category': 'Geografi',
      'rating': 4.4,
      'image': 'assets/geografi10.png',
      'isPopular': false,
    },

    // KATEGORI BAHASA - 12 BUKU
    {
      'title': 'Kamus Besar Bahasa Indonesia',
      'author': 'Tim Balai Pustaka',
      'category': 'Bahasa',
      'rating': 4.5,
      'image': 'assets/bahasa1.png',
      'isPopular': true,
    },
    {
      'title': 'Tata Bahasa Indonesia',
      'author': 'Abdul Chaer',
      'category': 'Bahasa',
      'rating': 4.3,
      'image': 'assets/bahasa2.png',
      'isPopular': false,
    },
    {
      'title': 'English Grammar',
      'author': 'Raymond Murphy',
      'category': 'Bahasa',
      'rating': 4.7,
      'image': 'assets/bahasa3.png',
      'isPopular': true,
    },
    {
      'title': 'Linguistik Umum',
      'author': 'Ferdinand de Saussure',
      'category': 'Bahasa',
      'rating': 4.4,
      'image': 'assets/bahasa4.png',
      'isPopular': false,
    },
    {
      'title': 'Phonetics and Phonology',
      'author': 'Peter Roach',
      'category': 'Bahasa',
      'rating': 4.2,
      'image': 'assets/bahasa5.png',
      'isPopular': false,
    },
    {
      'title': 'Syntax Theory',
      'author': 'Andrew Radford',
      'category': 'Bahasa',
      'rating': 4.1,
      'image': 'assets/bahasa6.png',
      'isPopular': false,
    },
    {
      'title': 'Semantics Introduction',
      'author': 'John I. Saeed',
      'category': 'Bahasa',
      'rating': 4.3,
      'image': 'assets/bahasa7.png',
      'isPopular': false,
    },
    {
      'title': 'Pragmatics',
      'author': 'George Yule',
      'category': 'Bahasa',
      'rating': 4.4,
      'image': 'assets/bahasa8.png',
      'isPopular': false,
    },
    {
      'title': 'Sociolinguistics',
      'author': 'Janet Holmes',
      'category': 'Bahasa',
      'rating': 4.5,
      'image': 'assets/bahasa9.png',
      'isPopular': false,
    },
    {
      'title': 'Applied Linguistics',
      'author': 'Guy Cook',
      'category': 'Bahasa',
      'rating': 4.2,
      'image': 'assets/bahasa10.png',
      'isPopular': false,
    },
  ].obs;

  // Original books backup untuk reset filter
  late List<Map<String, dynamic>> originalBooks;

  @override
  void onInit() {
    super.onInit();
    // Backup original order
    originalBooks = List.from(books);
    
    // Set kategori dari argument jika ada
    final String? categoryFromArgs = Get.arguments?['category'];
    if (categoryFromArgs != null && categories.contains(categoryFromArgs)) {
      selectedCategory.value = categoryFromArgs;
    }
  }

  // Method untuk navigasi ke halaman detail dengan data lengkap
  void navigateToDetail(Map<String, dynamic> book) {
    Get.toNamed('/detail', arguments: {
      'title': book['title'],
      'author': book['author'],
      'coverImage': book['image'],
      'pageCount': book['pageCount'] ?? '200',
      'publishDate': book['publishDate'] ?? 'Unknown',
      'ageRating': book['ageRating'] ?? '8+',
      'description': book['description'] ?? 'Deskripsi tidak tersedia untuk buku ini.',
      'rating': book['rating'] ?? 4.0,
      'category': book['category'],
      'isPopular': book['isPopular'] ?? false,
    });
  }

  // Method untuk mendapatkan buku berdasarkan index di displayedBooks
  Map<String, dynamic> getBookByIndex(int index) {
    return displayedBooks[index];
  }

  // Filtered books berdasarkan kategori yang dipilih
  List<Map<String, dynamic>> get filteredBooks {
    return books.where((book) => book['category'] == selectedCategory.value).toList();
  }

  // Books yang ditampilkan berdasarkan kategori dan pencarian
  List<Map<String, dynamic>> get displayedBooks {
    var filtered = filteredBooks;
    
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered.where((book) {
        final title = book['title'].toString().toLowerCase();
        final author = book['author'].toString().toLowerCase();
        final query = searchQuery.value.toLowerCase();
        
        return title.contains(query) || author.contains(query);
      }).toList();
    }
    
    return filtered;
  }

  // Method untuk mendapatkan buku berdasarkan kategori tertentu
  List<Map<String, dynamic>> getBooksByCategory(String category) {
    return books.where((book) => book['category'] == category).toList();
  }

  // Method untuk mendapatkan jumlah buku per kategori
  int getBooksCountByCategory(String category) {
    return books.where((book) => book['category'] == category).length;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void searchBooks(String query) {
    searchQuery.value = query;
  }

  void toggleViewMode() {
    isGridView.value = !isGridView.value;
  }

  void toggleFavorite(int index) {
    // Get the actual book from displayedBooks
    final displayedBook = displayedBooks[index];
    
    // Find the index in the original books list
    final originalIndex = books.indexWhere((book) => 
      book['title'] == displayedBook['title'] && 
      book['author'] == displayedBook['author']
    );
    
    if (originalIndex != -1) {
      books[originalIndex]['isFavorite'] = !(books[originalIndex]['isFavorite'] ?? false);
      books.refresh();
    }
  }

  void clearSearch() {
    searchQuery.value = '';
  }

  // Filter functions - hanya berlaku untuk kategori yang dipilih
  void sortBooksByRating() {
    final currentCategoryBooks = getBooksByCategory(selectedCategory.value);
    currentCategoryBooks.sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
    
    // Update only books in current category
    for (int i = 0; i < books.length; i++) {
      if (books[i]['category'] == selectedCategory.value) {
        final bookInCategory = currentCategoryBooks.firstWhere(
          (book) => book['title'] == books[i]['title']
        );
        books[i] = bookInCategory;
      }
    }
    
    books.refresh();
    isFilterApplied.value = true;
    filterType.value = 'rating';
  }

  void showOnlyPopular() {
    final currentCategoryBooks = getBooksByCategory(selectedCategory.value);
    final popularBooks = currentCategoryBooks.where((book) => book['isPopular'] == true).toList();
    final otherBooks = currentCategoryBooks.where((book) => book['isPopular'] != true).toList();
    
    final sortedCategoryBooks = [...popularBooks, ...otherBooks];
    
    // Update only books in current category
    int categoryIndex = 0;
    for (int i = 0; i < books.length; i++) {
      if (books[i]['category'] == selectedCategory.value) {
        books[i] = sortedCategoryBooks[categoryIndex];
        categoryIndex++;
      }
    }
    
    books.refresh();
    isFilterApplied.value = true;
    filterType.value = 'popular';
  }

  void resetFilter() {
    books.clear();
    books.addAll(originalBooks);
    books.refresh();
    isFilterApplied.value = false;
    filterType.value = '';
  }
}