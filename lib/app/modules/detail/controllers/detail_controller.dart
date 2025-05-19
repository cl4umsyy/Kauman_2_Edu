import 'package:get/get.dart';

class DetailController extends GetxController {
  // Book information
  final bookTitle = 'The Little Mermaid'.obs;
  final bookAuthor = 'Hans Christian Andersen'.obs;
  final pageCount = '200'.obs;
  final publishDate = 'April 2022'.obs;
  final ageRating = '8+'.obs;
  final isBookmarked = false.obs;
  
  // Book description with initial truncated text
  final bookDescription = '''The Little Mermaid lives in an underwater kingdom with her widowed father (Mer-King), her dowager grandmother, and her five older sisters, each of whom had been born one year apart. When a mermaid turns fifteen, she is permitted to swim to the surface for the first time to catch a glimpse of the world above, and when the sisters become old enough, each of them visits the upper world and returns...'''.obs;
  
  // Full description for expanding
  final fullDescription = '''The Little Mermaid lives in an underwater kingdom with her widowed father (Mer-King), her dowager grandmother, and her five older sisters, each of whom had been born one year apart. When a mermaid turns fifteen, she is permitted to swim to the surface for the first time to catch a glimpse of the world above, and when the sisters become old enough, each of them visits the upper world and returns with a passionate fascination with the world above.

The Little Mermaid's fascination is even greater than her siblings'. She endures the "excruciating pain" of having her fish tail transformed into legs in order to live on land, losing her beautiful voice in the process. Despite suffering emotionally and physically, she never wins the prince's love, and the story ends with the mermaid choosing between killing the prince to save herself or accepting her own death.'''.obs;
  
  // Path to book cover image
  final String bookCover = 'assets/1.png';
  


  
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