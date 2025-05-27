import 'package:get/get.dart';

class LibraryController extends GetxController {
  // List of saved books
  final books = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load sample books for demonstration
    loadSampleBooks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadSampleBooks() {
    // Using some sample books - these would normally come from a data source
    books.addAll([
      {
        'id': '1',
        'title': 'Harry Potter and the Philosopher\'s Stone',
        'author': 'J.K. Rowling',
        'coverImage': 'assets/rilis3.png',
        'progress': 75,
      },
      {
        'id': '2',
        'title': 'The Lord of the Rings',
        'author': 'J.R.R. Tolkien',
        'coverImage': 'assets/olahraga12.png',
        'progress': 30,
      },
      {
        'id': '3',
        'title': 'To Kill a Mockingbird',
        'author': 'Harper Lee',
        'coverImage': 'assets/geografi1.png',
        'progress': 100,
      },
      {
        'id': '4',
        'title': '1984',
        'author': 'George Orwell',
        'coverImage': 'assets/bahasa5.png',
        'progress': 45,
      },
      {
        'id': '1',
        'title': 'Harry Potter and the Philosopher\'s Stone',
        'author': 'J.K. Rowling',
        'coverImage': 'assets/sejarah2.png',
        'progress': 75,
      },
      {
        'id': '2',
        'title': 'The Lord of the Rings',
        'author': 'J.R.R. Tolkien',
        'coverImage': 'assets/sejarah1.png',
        'progress': 30,
      },
      {
        'id': '1',
        'title': 'Harry Potter and the Philosopher\'s Stone',
        'author': 'J.K. Rowling',
        'coverImage': 'assets/sejarah10.png',
        'progress': 75,
      },
      {
        'id': '2',
        'title': 'The Lord of the Rings',
        'author': 'J.R.R. Tolkien',
        'coverImage': 'assets/geografi10.png',
        'progress': 30,
      },
      {
        'id': '1',
        'title': 'Harry Potter and the Philosopher\'s Stone',
        'author': 'J.K. Rowling',
        'coverImage': 'assets/bahasa6.png',
        'progress': 75,
      },
      {
        'id': '2',
        'title': 'The Lord of the Rings',
        'author': 'J.R.R. Tolkien',
        'coverImage': 'assets/bahasa7.png',
        'progress': 30,
      },
    ]);
  }

  // Method to clear all books (for demo purposes)
  void clearLibrary() {
    books.clear();
  }

  // Method to add a book to the library
  void addBook(Map<String, dynamic> book) {
    books.add(book);
  }

  // Method to remove a book from the library
  void removeBook(String bookId) {
    books.removeWhere((book) => book['id'] == bookId);
  }

  // Method to update reading progress for a book
  void updateProgress(String bookId, int progress) {
    final index = books.indexWhere((book) => book['id'] == bookId);
    if (index != -1) {
      final book = books[index];
      book['progress'] = progress;
      books[index] = book;
    }
  }
}