import 'package:get/get.dart';

class DetailController extends GetxController {
  // Book information - initialized with default values
  final bookTitle = ''.obs;
  final bookAuthor = ''.obs;
  final pageCount = ''.obs;
  final publishDate = ''.obs;
  final ageRating = ''.obs;
  final isBookmarked = false.obs;
  final String bookCover;
  
  // Book description with initial truncated text
  final bookDescription = ''.obs;
  
  // Full description for expanding
  final fullDescription = ''.obs;
  
  // Constructor to receive data from arguments
  DetailController() : bookCover = Get.arguments?['coverImage'] ?? 'assets/default_cover.png';
  
  @override
  void onInit() {
    super.onInit();
    // Get book data from arguments
    Map<String, dynamic> args = Get.arguments ?? {};
    
    bookTitle.value = args['title'] ?? 'Unknown Title';
    bookAuthor.value = args['author'] ?? 'Unknown Author';
    pageCount.value = args['pageCount'] ?? '200';
    publishDate.value = args['publishDate'] ?? 'Unknown';
    ageRating.value = args['ageRating'] ?? '8+';
    
    // Set descriptions based on the book
    _initializeBookDescription(args);
  }
  
  // Initialize book description based on book title or other info
  void _initializeBookDescription(Map<String, dynamic> args) {
    // You can have different descriptions for different books
    // or fetch from a database/API in a real app
    if (args.containsKey('description')) {
      // Use provided description if available
      String desc = args['description'];
      // Create a truncated version for initial display
      bookDescription.value = desc.length > 200 ? '${desc.substring(0, 200)}...' : desc;
      fullDescription.value = desc;
    } else {
      // Default descriptions based on the book title
      String defaultDesc = 'This is a fascinating book about ${bookTitle.value} written by ${bookAuthor.value}.';
      String defaultFullDesc = '$defaultDesc It explores various themes and characters in a captivating narrative that keeps readers engaged from start to finish.';
      
      // For specific books, provide custom descriptions
      if (bookTitle.value.contains('Little Mermaid')) {
        bookDescription.value = '''The Little Mermaid lives in an underwater kingdom with her widowed father (Mer-King), her dowager grandmother, and her five older sisters, each of whom had been born one year apart. When a mermaid turns fifteen, she is permitted to swim to the surface for the first time to catch a glimpse of the world above, and when the sisters become old enough, each of them visits the upper world and returns...''';
        
        fullDescription.value = '''The Little Mermaid lives in an underwater kingdom with her widowed father (Mer-King), her dowager grandmother, and her five older sisters, each of whom had been born one year apart. When a mermaid turns fifteen, she is permitted to swim to the surface for the first time to catch a glimpse of the world above, and when the sisters become old enough, each of them visits the upper world and returns with a passionate fascination with the world above.

The Little Mermaid's fascination is even greater than her siblings'. She endures the "excruciating pain" of having her fish tail transformed into legs in order to live on land, losing her beautiful voice in the process. Despite suffering emotionally and physically, she never wins the prince's love, and the story ends with the mermaid choosing between killing the prince to save herself or accepting her own death.''';
      } else {
        bookDescription.value = defaultDesc;
        fullDescription.value = defaultFullDesc;
      }
    }
  }
  
  // Toggle bookmark status
  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
  }
  
  // Expand description when "Read More" is tapped
  void expandDescription() {
    bookDescription.value = fullDescription.value;
  }
  
  // Handle adding to list functionality
  void addToList() {
    // Implement logic to add book to user's list
    Get.snackbar(
      'Added to List',
      '${bookTitle.value} has been added to your reading list',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  // Navigate back to home screen
  void goToHome() {
    Get.offAllNamed('/home');
  }
}