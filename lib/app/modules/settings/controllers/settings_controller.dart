import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

// Simple in-memory storage service
class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();
  
  final Map<String, String> _storage = {};
  
  String? getString(String key) => _storage[key];
  
  Future<bool> setString(String key, String value) async {
    _storage[key] = value;
    return true;
  }
  
  Future<bool> remove(String key) async {
    _storage.remove(key);
    return true;
  }
  
  Future<bool> clear() async {
    _storage.clear();
    return true;
  }
}

class SettingsController extends GetxController {
  // Buku favorit (maksimal 4) - menggunakan reactive list
  final favoriteBooks = <Map<String, dynamic>>[].obs;
  
  // Untuk pelacakan apakah ada perubahan yang perlu disimpan
  final hasChanges = false.obs;
  
  // Key untuk Storage
  static const String _favoritesBooksKey = 'favorite_books';
  
  // Storage service instance
  final _storage = StorageService();
  
  @override
  void onInit() {
    super.onInit();
    // Ambil data buku favorit dari penyimpanan lokal saat inisialisasi
    loadFavoriteBooks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Memuat buku favorit dari penyimpanan lokal
  Future<void> loadFavoriteBooks() async {
    try {
      final booksJson = _storage.getString(_favoritesBooksKey);
      
      if (booksJson != null) {
        final List<dynamic> booksList = json.decode(booksJson);
        favoriteBooks.value = booksList.cast<Map<String, dynamic>>();
      } else {
        // Data default jika belum ada
        favoriteBooks.value = [
          {
            'id': '1',
            'title': 'The Great Gatsby',
            'author': 'F. Scott Fitzgerald',
            'coverUrl': 'assets/books/book_001.png',
            'genre': 'Classic Literature'
          },
          {
            'id': '2',
            'title': '1984',
            'author': 'George Orwell',
            'coverUrl': 'assets/books/book_002.png',
            'genre': 'Dystopian Fiction'
          },
        ];
        // Simpan data default
        await saveFavoriteBooks();
      }
    } catch (e) {
      print('Error loading favorite books: $e');
      // Fallback ke data kosong jika error
      favoriteBooks.clear();
    }
  }

  // Menambahkan buku ke daftar favorit
  void addFavoriteBook(Map<String, dynamic> book) {
    if (favoriteBooks.length < 4) {
      // Periksa buku sudah ada di daftar atau tidak
      if (!favoriteBooks.any((element) => element['id'] == book['id'])) {
        favoriteBooks.add(book);
        hasChanges.value = true;
        // Auto save untuk sinkronisasi real-time
        saveFavoriteBooks();
      } else {
        Get.snackbar(
          'Info', 
          'Buku ini sudah ada di daftar favorit',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Batas Tercapai', 
        'Anda hanya dapat menambahkan maksimal 4 buku favorit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Menghapus buku dari daftar favorit
  void removeFavoriteBook(String bookId) {
    favoriteBooks.removeWhere((book) => book['id'] == bookId);
    hasChanges.value = true;
    // Auto save untuk sinkronisasi real-time
    saveFavoriteBooks();
  }

  // Mengubah urutan buku favorit
  void reorderFavoriteBooks(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final book = favoriteBooks.removeAt(oldIndex);
    favoriteBooks.insert(newIndex, book);
    hasChanges.value = true;
    // Auto save untuk sinkronisasi real-time
    saveFavoriteBooks();
  }

  // Menyimpan perubahan ke penyimpanan lokal
  Future<void> saveFavoriteBooks() async {
    try {
      final booksJson = json.encode(favoriteBooks.toList());
      await _storage.setString(_favoritesBooksKey, booksJson);
      
      Get.snackbar(
        'Berhasil', 
        'Buku favorit berhasil disimpan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      hasChanges.value = false;
      
      // Update profile controller jika ada
      _updateProfileController();
    } catch (e) {
      print('Error saving favorite books: $e');
      Get.snackbar(
        'Error', 
        'Gagal menyimpan buku favorit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Update profile controller untuk sinkronisasi real-time
  void _updateProfileController() {
    try {
      // Direct update ke ProfileController jika sudah ada
      if (Get.isRegistered<ProfileController>()) {
        final profileController = Get.find<ProfileController>();
        profileController.updateFavoriteBooks(favoriteBooks.toList());
      }
    } catch (e) {
      print('Profile controller not found: $e');
    }
  }

  // Database buku lengkap (simplified version - skip 74 assets as requested)
  List<Map<String, dynamic>> get _allBooksDatabase => [
   {'id': '001', 'title': 'The Great Gatsby', 'author': 'F. Scott Fitzgerald', 'coverUrl': 'assets/books/book_001.png', 'genre': 'Classic Literature', 'description': 'A classic American novel set in the Jazz Age.'},
    {'id': '002', 'title': '1984', 'author': 'George Orwell', 'coverUrl': 'assets/books/book_002.png', 'genre': 'Dystopian Fiction', 'description': 'A dystopian social science fiction novel.'},
    {'id': '003', 'title': 'To Kill a Mockingbird', 'author': 'Harper Lee', 'coverUrl': 'assets/books/book_003.png', 'genre': 'Classic Literature', 'description': 'A novel about racial injustice and moral growth.'},
    {'id': '004', 'title': 'Pride and Prejudice', 'author': 'Jane Austen', 'coverUrl': 'assets/books/book_004.png', 'genre': 'Romance', 'description': 'A romantic novel of manners.'},
    {'id': '005', 'title': 'The Catcher in the Rye', 'author': 'J.D. Salinger', 'coverUrl': 'assets/books/book_005.png', 'genre': 'Coming-of-age', 'description': 'A controversial novel about teenage rebellion.'},
    {'id': '006', 'title': 'Animal Farm', 'author': 'George Orwell', 'coverUrl': 'assets/books/book_006.png', 'genre': 'Political Satire', 'description': 'An allegorical novella about farm animals.'},
    {'id': '007', 'title': 'Lord of the Flies', 'author': 'William Golding', 'coverUrl': 'assets/books/book_007.png', 'genre': 'Adventure', 'description': 'A story about British boys stranded on an island.'},
    {'id': '008', 'title': 'The Handmaid\'s Tale', 'author': 'Margaret Atwood', 'coverUrl': 'assets/books/book_008.png', 'genre': 'Dystopian Fiction', 'description': 'A dystopian novel set in a totalitarian society.'},
    {'id': '009', 'title': 'Brave New World', 'author': 'Aldous Huxley', 'coverUrl': 'assets/books/book_009.png', 'genre': 'Science Fiction', 'description': 'A dystopian vision of the future.'},
    {'id': '010', 'title': 'The Outsiders', 'author': 'S.E. Hinton', 'coverUrl': 'assets/books/book_010.png', 'genre': 'Young Adult', 'description': 'A coming-of-age novel about teenage gangs.'},
    
    // Fantasy
    {'id': '011', 'title': 'Harry Potter and the Philosopher\'s Stone', 'author': 'J.K. Rowling', 'coverUrl': 'assets/books/book_011.png', 'genre': 'Fantasy', 'description': 'The first book in the Harry Potter series.'},
    {'id': '012', 'title': 'The Lord of the Rings', 'author': 'J.R.R. Tolkien', 'coverUrl': 'assets/books/book_012.png', 'genre': 'Fantasy', 'description': 'An epic high fantasy novel.'},
    {'id': '013', 'title': 'The Hobbit', 'author': 'J.R.R. Tolkien', 'coverUrl': 'assets/books/book_013.png', 'genre': 'Fantasy', 'description': 'A fantasy adventure about Bilbo Baggins.'},
    {'id': '014', 'title': 'Game of Thrones', 'author': 'George R.R. Martin', 'coverUrl': 'assets/books/book_014.png', 'genre': 'Fantasy', 'description': 'Epic fantasy series about power struggles.'},
    {'id': '015', 'title': 'The Chronicles of Narnia', 'author': 'C.S. Lewis', 'coverUrl': 'assets/books/book_015.png', 'genre': 'Fantasy', 'description': 'Fantasy series about a magical world.'},
    {'id': '016', 'title': 'The Name of the Wind', 'author': 'Patrick Rothfuss', 'coverUrl': 'assets/books/book_016.png', 'genre': 'Fantasy', 'description': 'The first book in The Kingkiller Chronicle.'},
    {'id': '017', 'title': 'Mistborn', 'author': 'Brandon Sanderson', 'coverUrl': 'assets/books/book_017.png', 'genre': 'Fantasy', 'description': 'Epic fantasy with unique magic system.'},
    {'id': '018', 'title': 'The Way of Kings', 'author': 'Brandon Sanderson', 'coverUrl': 'assets/books/book_018.png', 'genre': 'Fantasy', 'description': 'First book in The Stormlight Archive.'},
    
    // Science Fiction
    {'id': '019', 'title': 'Dune', 'author': 'Frank Herbert', 'coverUrl': 'assets/books/book_019.png', 'genre': 'Science Fiction', 'description': 'A science fiction novel set in the distant future.'},
    {'id': '020', 'title': 'Foundation', 'author': 'Isaac Asimov', 'coverUrl': 'assets/books/book_020.png', 'genre': 'Science Fiction', 'description': 'The first novel in the Foundation series.'},
    {'id': '021', 'title': 'Ender\'s Game', 'author': 'Orson Scott Card', 'coverUrl': 'assets/books/book_021.png', 'genre': 'Science Fiction', 'description': 'A military science fiction novel.'},
    {'id': '022', 'title': 'The Martian', 'author': 'Andy Weir', 'coverUrl': 'assets/books/book_022.png', 'genre': 'Science Fiction', 'description': 'A survival story set on Mars.'},
    {'id': '023', 'title': 'Neuromancer', 'author': 'William Gibson', 'coverUrl': 'assets/books/book_023.png', 'genre': 'Cyberpunk', 'description': 'A groundbreaking cyberpunk novel.'},
    {'id': '024', 'title': 'The Hitchhiker\'s Guide to the Galaxy', 'author': 'Douglas Adams', 'coverUrl': 'assets/books/book_024.png', 'genre': 'Science Fiction Comedy', 'description': 'A comedic science fiction series.'},
    
    // Romance
    {'id': '025', 'title': 'Me Before You', 'author': 'Jojo Moyes', 'coverUrl': 'assets/books/book_025.png', 'genre': 'Romance', 'description': 'A romantic drama about love and loss.'},
    {'id': '026', 'title': 'The Notebook', 'author': 'Nicholas Sparks', 'coverUrl': 'assets/books/book_026.png', 'genre': 'Romance', 'description': 'A love story spanning decades.'},
    {'id': '027', 'title': 'Outlander', 'author': 'Diana Gabaldon', 'coverUrl': 'assets/books/book_027.png', 'genre': 'Historical Romance', 'description': 'Time-traveling romance adventure.'},
    {'id': '028', 'title': 'The Fault in Our Stars', 'author': 'John Green', 'coverUrl': 'assets/books/book_028.png', 'genre': 'Young Adult Romance', 'description': 'A love story between two cancer patients.'},
    {'id': '029', 'title': 'It Ends with Us', 'author': 'Colleen Hoover', 'coverUrl': 'assets/books/book_029.png', 'genre': 'Contemporary Romance', 'description': 'A complex love story with difficult themes.'},
    
    // Mystery & Thriller
    {'id': '030', 'title': 'Gone Girl', 'author': 'Gillian Flynn', 'coverUrl': 'assets/books/book_030.png', 'genre': 'Psychological Thriller', 'description': 'A psychological thriller about a marriage gone wrong.'},
    {'id': '031', 'title': 'The Girl with the Dragon Tattoo', 'author': 'Stieg Larsson', 'coverUrl': 'assets/books/book_031.png', 'genre': 'Crime Thriller', 'description': 'A crime thriller set in Sweden.'},
    {'id': '032', 'title': 'The Da Vinci Code', 'author': 'Dan Brown', 'coverUrl': 'assets/books/book_032.png', 'genre': 'Mystery Thriller', 'description': 'A mystery thriller involving religious secrets.'},
    {'id': '033', 'title': 'Sherlock Holmes', 'author': 'Arthur Conan Doyle', 'coverUrl': 'assets/books/book_033.png', 'genre': 'Mystery', 'description': 'Classic detective stories.'},
    {'id': '034', 'title': 'Agatha Christie Collection', 'author': 'Agatha Christie', 'coverUrl': 'assets/books/book_034.png', 'genre': 'Mystery', 'description': 'Classic murder mysteries.'},
    
    // Horror
    {'id': '035', 'title': 'Stephen King\'s IT', 'author': 'Stephen King', 'coverUrl': 'assets/books/book_035.png', 'genre': 'Horror', 'description': 'A horror novel about a shape-shifting entity.'},
    {'id': '036', 'title': 'The Shining', 'author': 'Stephen King', 'coverUrl': 'assets/books/book_036.png', 'genre': 'Horror', 'description': 'A psychological horror novel.'},
    {'id': '037', 'title': 'Dracula', 'author': 'Bram Stoker', 'coverUrl': 'assets/books/book_037.png', 'genre': 'Gothic Horror', 'description': 'The classic vampire novel.'},
    {'id': '038', 'title': 'Frankenstein', 'author': 'Mary Shelley', 'coverUrl': 'assets/books/book_038.png', 'genre': 'Gothic Horror', 'description': 'The original science fiction horror story.'},
    
    // Non-Fiction
    {'id': '039', 'title': 'Sapiens', 'author': 'Yuval Noah Harari', 'coverUrl': 'assets/books/book_039.png', 'genre': 'History', 'description': 'A brief history of humankind.'},
    {'id': '040', 'title': 'Educated', 'author': 'Tara Westover', 'coverUrl': 'assets/books/book_040.png', 'genre': 'Memoir', 'description': 'A memoir about education and family.'},
    {'id': '041', 'title': 'Becoming', 'author': 'Michelle Obama', 'coverUrl': 'assets/books/book_041.png', 'genre': 'Biography', 'description': 'Memoir of the former First Lady.'},
    {'id': '042', 'title': 'The 7 Habits of Highly Effective People', 'author': 'Stephen Covey', 'coverUrl': 'assets/books/book_042.png', 'genre': 'Self-Help', 'description': 'A self-improvement guide.'},
    {'id': '043', 'title': 'Atomic Habits', 'author': 'James Clear', 'coverUrl': 'assets/books/book_043.png', 'genre': 'Self-Help', 'description': 'A guide to building good habits.'},
    
    // Literary Fiction
    {'id': '044', 'title': 'The Kite Runner', 'author': 'Khaled Hosseini', 'coverUrl': 'assets/books/book_044.png', 'genre': 'Literary Fiction', 'description': 'A powerful story of friendship and redemption.'},
    {'id': '045', 'title': 'Life of Pi', 'author': 'Yann Martel', 'coverUrl': 'assets/books/book_045.png', 'genre': 'Adventure Fiction', 'description': 'A survival story with a philosophical twist.'},
    {'id': '046', 'title': 'The Book Thief', 'author': 'Markus Zusak', 'coverUrl': 'assets/books/book_046.png', 'genre': 'Historical Fiction', 'description': 'A story set in Nazi Germany.'},
    {'id': '047', 'title': 'One Hundred Years of Solitude', 'author': 'Gabriel García Márquez', 'coverUrl': 'assets/books/book_047.png', 'genre': 'Magical Realism', 'description': 'A multi-generational saga.'},
    
    // Young Adult
    {'id': '048', 'title': 'The Hunger Games', 'author': 'Suzanne Collins', 'coverUrl': 'assets/books/book_048.png', 'genre': 'Young Adult Dystopian', 'description': 'A dystopian trilogy about survival games.'},
    {'id': '049', 'title': 'Divergent', 'author': 'Veronica Roth', 'coverUrl': 'assets/books/book_049.png', 'genre': 'Young Adult Dystopian', 'description': 'A dystopian series about faction-based society.'},
    {'id': '050', 'title': 'The Maze Runner', 'author': 'James Dashner', 'coverUrl': 'assets/books/book_050.png', 'genre': 'Young Adult Sci-Fi', 'description': 'A sci-fi thriller series.'},
    {'id': '051', 'title': 'Twilight', 'author': 'Stephenie Meyer', 'coverUrl': 'assets/books/book_051.png', 'genre': 'Young Adult Paranormal', 'description': 'A vampire romance series.'},
    {'id': '052', 'title': 'Percy Jackson', 'author': 'Rick Riordan', 'coverUrl': 'assets/books/book_052.png', 'genre': 'Young Adult Fantasy', 'description': 'Modern Greek mythology adventure.'},
    
    // Historical Fiction
    {'id': '053', 'title': 'All Quiet on the Western Front', 'author': 'Erich Maria Remarque', 'coverUrl': 'assets/books/book_053.png', 'genre': 'Historical Fiction', 'description': 'A World War I novel.'},
    {'id': '054', 'title': 'The Pillars of the Earth', 'author': 'Ken Follett', 'coverUrl': 'assets/books/book_054.png', 'genre': 'Historical Fiction', 'description': 'Medieval historical fiction.'},
    {'id': '055', 'title': 'War and Peace', 'author': 'Leo Tolstoy', 'coverUrl': 'assets/books/book_055.png', 'genre': 'Historical Fiction', 'description': 'Epic Russian historical novel.'},
    {'id': '056', 'title': 'The Other Boleyn Girl', 'author': 'Philippa Gregory', 'coverUrl': 'assets/books/book_056.png', 'genre': 'Historical Fiction', 'description': 'Tudor historical fiction.'},
    
    // Contemporary Fiction
    {'id': '057', 'title': 'Where the Crawdads Sing', 'author': 'Delia Owens', 'coverUrl': 'assets/books/book_057.png', 'genre': 'Contemporary Fiction', 'description': 'A mystery set in the American South.'},
    {'id': '058', 'title': 'The Seven Husbands of Evelyn Hugo', 'author': 'Taylor Jenkins Reid', 'coverUrl': 'assets/books/book_058.png', 'genre': 'Contemporary Fiction', 'description': 'A story about a Hollywood icon.'},
    {'id': '059', 'title': 'Little Fires Everywhere', 'author': 'Celeste Ng', 'coverUrl': 'assets/books/book_059.png', 'genre': 'Contemporary Fiction', 'description': 'A story about family secrets.'},
    {'id': '060', 'title': 'The Silent Patient', 'author': 'Alex Michaelides', 'coverUrl': 'assets/books/book_060.png', 'genre': 'Psychological Thriller', 'description': 'A psychological thriller about a silent patient.'},
    
    // Adventure
    {'id': '061', 'title': 'Into the Wild', 'author': 'Jon Krakauer', 'coverUrl': 'assets/books/book_061.png', 'genre': 'Adventure Non-Fiction', 'description': 'True story of wilderness adventure.'},
    {'id': '062', 'title': 'Robinson Crusoe', 'author': 'Daniel Defoe', 'coverUrl': 'assets/books/book_062.png', 'genre': 'Adventure', 'description': 'Classic survival adventure story.'},
    {'id': '063', 'title': 'Treasure Island', 'author': 'Robert Louis Stevenson', 'coverUrl': 'assets/books/book_063.png', 'genre': 'Adventure', 'description': 'Classic pirate adventure story.'},
    {'id': '064', 'title': 'The Count of Monte Cristo', 'author': 'Alexandre Dumas', 'coverUrl': 'assets/books/book_064.png', 'genre': 'Adventure', 'description': 'Classic revenge adventure story.'},
    
    // Philosophy & Religion
    {'id': '065', 'title': 'Man\'s Search for Meaning', 'author': 'Viktor Frankl', 'coverUrl': 'assets/books/book_065.png', 'genre': 'Philosophy', 'description': 'A Holocaust survivor\'s philosophical memoir.'},
    {'id': '066', 'title': 'The Alchemist', 'author': 'Paulo Coelho', 'coverUrl': 'assets/books/book_066.png', 'genre': 'Philosophical Fiction', 'description': 'A philosophical novel about following dreams.'},
    {'id': '067', 'title': 'Siddhartha', 'author': 'Hermann Hesse', 'coverUrl': 'assets/books/book_067.png', 'genre': 'Philosophical Fiction', 'description': 'A spiritual journey novel.'},
    
    // Business & Economics
    {'id': '068', 'title': 'Think and Grow Rich', 'author': 'Napoleon Hill', 'coverUrl': 'assets/books/book_068.png', 'genre': 'Business', 'description': 'A classic business and success guide.'},
    {'id': '069', 'title': 'Rich Dad Poor Dad', 'author': 'Robert Kiyosaki', 'coverUrl': 'assets/books/book_069.png', 'genre': 'Personal Finance', 'description': 'A guide to financial literacy.'},
    {'id': '070', 'title': 'The Lean Startup', 'author': 'Eric Ries', 'coverUrl': 'assets/books/book_070.png', 'genre': 'Business', 'description': 'A guide to building successful startups.'},
    
    // Comedy & Humor
    {'id': '071', 'title': 'Good Omens', 'author': 'Terry Pratchett & Neil Gaiman', 'coverUrl': 'assets/books/book_071.png', 'genre': 'Comedy Fantasy', 'description': 'A humorous take on the apocalypse.'},
    {'id': '072', 'title': 'The Discworld Series', 'author': 'Terry Pratchett', 'coverUrl': 'assets/books/book_072.png', 'genre': 'Comedy Fantasy', 'description': 'Humorous fantasy series.'},
    
    // Indonesian Literature
    {'id': '073', 'title': 'Laskar Pelangi', 'author': 'Andrea Hirata', 'coverUrl': 'assets/books/book_073.png', 'genre': 'Indonesian Literature', 'description': 'Indonesian novel about education and friendship.'},
    {'id': '074', 'title': 'Ayat-Ayat Cinta', 'author': 'Habiburrahman El Shirazy', 'coverUrl': 'assets/books/book_074.png', 'genre': 'Indonesian Literature', 'description': 'Indonesian Islamic romance novel.'},
  ];


  // Mencari buku dari database dengan algoritma pencarian yang lebih baik
  Future<List<Map<String, dynamic>>> searchBooks(String query) async {
    // Simulasi delay pencarian
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (query.trim().isEmpty) {
      return [];
    }
    
    final searchQuery = query.toLowerCase().trim();
    final results = <Map<String, dynamic>>[];
    
    // Algoritma pencarian dengan prioritas
    for (final book in _allBooksDatabase) {
      final title = book['title'].toString().toLowerCase();
      final author = book['author'].toString().toLowerCase();
      final genre = book['genre'].toString().toLowerCase();
      final description = book['description'].toString().toLowerCase();
      
      int relevanceScore = 0;
      
      // Exact match pada title (prioritas tertinggi)
      if (title == searchQuery) {
        relevanceScore += 100;
      }
      // Title starts with query
      else if (title.startsWith(searchQuery)) {
        relevanceScore += 80;
      }
      // Title contains query
      else if (title.contains(searchQuery)) {
        relevanceScore += 60;
      }
      
      // Author match
      if (author.contains(searchQuery)) {
        relevanceScore += 40;
      }
      
      // Genre match
      if (genre.contains(searchQuery)) {
        relevanceScore += 30;
      }
      
      // Description match
      if (description.contains(searchQuery)) {
        relevanceScore += 10;
      }
      
      // Partial word matching
      final queryWords = searchQuery.split(' ');
      for (final word in queryWords) {
        if (word.length > 2) { // Skip very short words
          if (title.contains(word)) relevanceScore += 20;
          if (author.contains(word)) relevanceScore += 15;
          if (genre.contains(word)) relevanceScore += 10;
        }
      }
      
      if (relevanceScore > 0) {
        final bookWithScore = Map<String, dynamic>.from(book);
        bookWithScore['_relevanceScore'] = relevanceScore;
        results.add(bookWithScore);
      }
    }
    
    // Sort by relevance score (descending)
    results.sort((a, b) => b['_relevanceScore'].compareTo(a['_relevanceScore']));
    
    // Remove the relevance score before returning
    for (final book in results) {
      book.remove('_relevanceScore');
    }
    
    // Return top 20 results to avoid overwhelming the UI
    return results.take(20).toList();
  }

  // Method untuk mendapatkan buku berdasarkan genre
  Future<List<Map<String, dynamic>>> getBooksByGenre(String genre) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return _allBooksDatabase
        .where((book) => book['genre'].toString().toLowerCase().contains(genre.toLowerCase()))
        .toList();
  }

  // Method untuk mendapatkan buku populer (simulasi)
  Future<List<Map<String, dynamic>>> getPopularBooks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Return first 8 books as "popular"
    return _allBooksDatabase.take(8).toList();
  }

  // Method untuk mendapatkan rekomendasi buku berdasarkan genre favorit
  Future<List<Map<String, dynamic>>> getRecommendedBooks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (favoriteBooks.isEmpty) {
      return getPopularBooks();
    }
    
    // Get genres from favorite books
    final favoriteGenres = favoriteBooks
        .map((book) => book['genre'].toString())
        .toSet()
        .toList();
    
    final recommendations = <Map<String, dynamic>>[];
    
    for (final genre in favoriteGenres) {
      final genreBooks = await getBooksByGenre(genre);
      // Filter out books that are already in favorites
      final filteredBooks = genreBooks.where((book) => 
          !favoriteBooks.any((fav) => fav['id'] == book['id'])
      ).take(3).toList();
      
      recommendations.addAll(filteredBooks);
    }
    
    return recommendations.take(10).toList();
  }

  // Method untuk mendapatkan semua genre yang tersedia
  List<String> get availableGenres {
    final genres = _allBooksDatabase
        .map((book) => book['genre'].toString())
        .toSet()
        .toList();
    genres.sort();
    return genres;
  }

  // Method untuk mendapatkan buku terbaru (simulasi)
  Future<List<Map<String, dynamic>>> getNewBooks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Return last 6 books as "new releases"
    final allBooks = _allBooksDatabase;
    return allBooks.length > 6 
        ? allBooks.sublist(allBooks.length - 6)
        : allBooks;
  }

  // Method untuk reset ke default (untuk testing)
  void resetToDefault() {
    favoriteBooks.clear();
    hasChanges.value = true;
    loadFavoriteBooks();
  }

  // Method untuk mendapatkan statistik buku favorit
  Map<String, int> get favoriteBookStats {
    final stats = <String, int>{};
    
    for (final book in favoriteBooks) {
      final genre = book['genre'].toString();
      stats[genre] = (stats[genre] ?? 0) + 1;
    }
    
    return stats;
  }

  // Method untuk export favorite books (untuk backup)
  String exportFavoriteBooks() {
    return json.encode({
      'exported_at': DateTime.now().toIso8601String(),
      'favorite_books': favoriteBooks.toList(),
    });
  }

  // Method untuk import favorite books (dari backup)
  Future<bool> importFavoriteBooks(String jsonData) async {
    try {
      final data = json.decode(jsonData);
      final List<dynamic> importedBooks = data['favorite_books'];
      
      if (importedBooks.length > 4) {
        Get.snackbar(
          'Error', 
          'Data backup mengandung lebih dari 4 buku favorit',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
      
      favoriteBooks.value = importedBooks.cast<Map<String, dynamic>>();
      hasChanges.value = true;
      await saveFavoriteBooks();
      
      Get.snackbar(
        'Berhasil', 
        'Buku favorit berhasil diimpor',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      return true;
    } catch (e) {
      print('Error importing favorite books: $e');
      Get.snackbar(
        'Error', 
        'Gagal mengimpor buku favorit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }
}

// Dummy ProfileController class untuk menghindari error
class ProfileController extends GetxController {
  void updateFavoriteBooks(List<Map<String, dynamic>> books) {
    // Implementation untuk update favorite books di profile
    print('Profile updated with ${books.length} favorite books');
  }
}