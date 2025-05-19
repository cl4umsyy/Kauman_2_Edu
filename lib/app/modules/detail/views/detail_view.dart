import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Blurred Background Image
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Background image with gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(controller.bookCover),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  // Book cover
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Book cover with shadow
                        Container(
                          height: 200,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(controller.bookCover),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Book title and author
                        const SizedBox(width: 20),
                        Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 190,
                              child: Text(
                                controller.bookTitle.value,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              controller.bookAuthor.value,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Average rating
                            Row(
                              children: [
                                ...List.generate(5, (index) => 
                                  Icon(
                                    index < 4 ? Icons.star : Icons.star_half,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "4.5 (254 ratings)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.bookmark_border, color: Colors.white),
                ),
                onPressed: () => controller.toggleBookmark(),
              ),
              const SizedBox(width: 8),
            ],
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.calendar_today,
                          title: "Published",
                          value: controller.publishDate.value,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.menu_book,
                          title: "Pages",
                          value: controller.pageCount.value.toString(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.person_outline,
                          title: "Age Rating",
                          value: controller.ageRating.value,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Action buttons
                  Row(
                    children: [
                      // Read PDF Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Open PDF viewer
                            Get.toNamed('/pdf-viewer');
                          },
                          icon: const Icon(Icons.picture_as_pdf),
                          label: const Text("Read PDF"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Download Button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Download logic
                            Get.snackbar(
                              "Downloading",
                              "Starting download...",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          icon: const Icon(Icons.download),
                          label: const Text("Download"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blue[800],
                            side: BorderSide(color: Colors.blue[800]!),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Synopsis
                  const Text(
                    "Synopsis",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Book description
                  Obx(() => Text(
                    controller.bookDescription.value,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  )),
                  
                  // Read more button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => controller.expandDescription(),
                      child: Text(
                        'Read More',
                        style: TextStyle(
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Rating and Review Section
                  _buildRatingSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Divider
                  const Divider(),
                  
                  const SizedBox(height: 16),
                  
                  // Reviews header with count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Reviews",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "See all (254)",
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Review items
                  _buildReviewItem(
                    reviewerName: 'Samy Heard',
                    rating: 4,
                    date: '24 Feb',
                    reviewText: 'This story still charms me after all these years. The beautiful prose and meaningful messages are why this remains a classic after well over 150 years.',
                    profileImage: 'assets/profiles/profile1.jpg',
                  ),
                  
                  const Divider(),
                  
                  _buildReviewItem(
                    reviewerName: 'Alex Johnson',
                    rating: 5,
                    date: '12 Mar',
                    reviewText: 'Absolutely stunning masterpiece. The character development is incredible and the narrative pacing is perfect. I couldn\'t put it down!',
                    profileImage: 'assets/profiles/profile2.jpg',
                  ),
                  
                  const Divider(),
                  
                  _buildReviewItem(
                    reviewerName: 'Mai Lee',
                    rating: 4,
                    date: '5 Apr',
                    reviewText: 'I thoroughly enjoyed this book. The author has a way with words that pulls you completely into the story world.',
                    profileImage: 'assets/profiles/profile3.jpg',
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Add Comment Section
                  _buildAddCommentSection(),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      // Add floating button to write a review
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showReviewDialog(context);
        },
        backgroundColor: Colors.blue[800],
        icon: const Icon(Icons.rate_review, color: Colors.white),
        label: const Text("Write Review", style: TextStyle(color: Colors.white)),
      ),
    );
  }
  
  Widget _buildInfoCard({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue[800], size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildRatingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Reader Ratings",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Average rating big number
              Text(
                "4.5",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(width: 16),
              // Star breakdown
              Expanded(
                child: Column(
                  children: [
                    _buildRatingBar(5, 0.7),
                    _buildRatingBar(4, 0.2),
                    _buildRatingBar(3, 0.05),
                    _buildRatingBar(2, 0.03),
                    _buildRatingBar(1, 0.02),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Based on 254 ratings",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRatingBar(int stars, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            "$stars",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.amber, size: 12),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[300],
                color: Colors.amber,
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "${(percentage * 100).toInt()}%",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildReviewItem({
    required String reviewerName,
    required int rating,
    required String date,
    required String reviewText,
    String? profileImage,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Profile photo
              CircleAvatar(
                radius: 20,
                backgroundImage: profileImage != null 
                    ? AssetImage(profileImage) 
                    : null,
                backgroundColor: Colors.grey[300],
                child: profileImage == null 
                    ? Text(
                        reviewerName[0],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ) 
                    : null,
              ),
              const SizedBox(width: 12),
              
              // Reviewer info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) => 
                          Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          date,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Like button
              IconButton(
                icon: const Icon(Icons.thumb_up_outlined, size: 18),
                color: Colors.grey[600],
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Review text
          Text(
            reviewText,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Reply button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.reply, size: 16),
              label: const Text("Reply"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[700],
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAddCommentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add a Comment",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              // Comment input
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Share your thoughts...",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue[800]!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Post Comment"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Dialog for adding a review with rating
  void _showReviewDialog(BuildContext context) {
    int selectedRating = 0;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Write a Review"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Rate this book",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              // Star rating selector
              StatefulBuilder(
                builder: (context, setState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < selectedRating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 32,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                      );
                    }),
                  );
                }
              ),
              const SizedBox(height: 16),
              const Text(
                "Your review",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Share your thoughts about this book...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Save review logic here
              Navigator.pop(context);
              Get.snackbar(
                "Thank you!",
                "Your review has been submitted",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
            ),
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}