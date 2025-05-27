import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/viewall_controller.dart';

class ViewallView extends GetView<ViewallController> {
  const ViewallView({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Get the category title from arguments and controller
    final String title = controller.category.value;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: Obx(() => controller.isGridView.value 
              ? _buildGridView() 
              : _buildListView()
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => _showFilterBottomSheet(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.filter_list, color: Colors.black54, size: 20),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Filter',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Obx(() => InkWell(
            onTap: () => controller.toggleViewMode(),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Icon(
                controller.isGridView.value 
                  ? Icons.grid_view 
                  : Icons.view_list,
                color: Colors.black54,
                size: 24,
              ),
            ),
          )),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Filter',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Urutkan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            _buildSortingOptions(),
            SizedBox(height: 32),
            _buildApplyButton(),
            SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildSortingOptions() {
    return Obx(() => Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildFilterChip('Paling Sesuai', 'relevance', controller.sortOption),
        _buildFilterChip('Terbaru', 'newest', controller.sortOption),
        _buildFilterChip('Terlama', 'oldest', controller.sortOption),
      ],
    ));
  }

  Widget _buildFilterChip(String label, String value, Rx<String> currentOption) {
    final bool isSelected = currentOption.value == value;
    
    return InkWell(
      onTap: () {
        currentOption.value = value;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
          color: isSelected ? Color(0xFF00B14F) : Colors.white,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildApplyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          controller.applyFilters();
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF00B14F),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Terapkan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get screen width and density
        final screenWidth = constraints.maxWidth;
        final screenDensity = MediaQuery.of(context).devicePixelRatio;
        
        // Optimized for Infinix Hot 40 Pro (6.78" display)
        int crossAxisCount = 2;
        double childAspectRatio = 0.58; // Made more compact for better fit
        double horizontalPadding = 12.0;
        double spacing = 10.0;
        
        // Fine-tune for different screen densities and widths
        if (screenWidth <= 360) {
          // Very small screens
          crossAxisCount = 2;
          childAspectRatio = 0.55;
          horizontalPadding = 8.0;
          spacing = 8.0;
        } else if (screenWidth <= 400) {
          // Infinix Hot 40 Pro range
          crossAxisCount = 2;
          childAspectRatio = 0.58;
          horizontalPadding = 10.0;
          spacing = 10.0;
        } else if (screenWidth <= 450) {
          // Slightly larger screens
          crossAxisCount = 2;
          childAspectRatio = 0.62;
          horizontalPadding = 12.0;
          spacing = 12.0;
        } else {
          // Large screens
          crossAxisCount = 3;
          childAspectRatio = 0.65;
          horizontalPadding = 16.0;
          spacing = 12.0;
        }
        
        return GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 8,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: controller.books.length,
          itemBuilder: (context, index) {
            final book = controller.books[index];
            return _buildBookCard(book, screenWidth);
          },
        );
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: controller.books.length,
      itemBuilder: (context, index) {
        final book = controller.books[index];
        return _buildBookListItem(book);
      },
    );
  }

  Widget _buildBookCard(Map<String, dynamic> book, double screenWidth) {
    final String categoryType = _getCategoryTagText(controller.category.value);
    final Color categoryColor = _getCategoryColor(controller.category.value);
    
    // Responsive font sizes based on screen width
    double titleFontSize = screenWidth <= 360 ? 11 : 12;
    double subtitleFontSize = screenWidth <= 360 ? 9 : 10;
    double tagFontSize = screenWidth <= 360 ? 8 : 9;
    
    return GestureDetector(
      onTap: () {
        Get.toNamed('/detail', arguments: {
          'title': book['title'] ?? 'Unknown Title',
          'subtitle': book['subtitle'] ?? 'Unknown Subtitle',
          'coverImage': book['coverImage'] ?? 'assets/kucing.png',
          'isPremium': book['isPremium'] ?? false,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image with optimized height ratio
            Expanded(
              flex: 75, // Increased image area
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(
                        book['coverImage'] ?? 'assets/kucing.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Icon(Icons.book, color: Colors.grey, size: 24),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  if (book['isPremium'] == true)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Icon(Icons.diamond_outlined, size: 12, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
            
            // Content info with optimized height
            Expanded(
              flex: 25, // Reduced text area for better proportions
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Category tag
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        categoryType,
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: tagFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    
                    // Title and subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            book['title'] ?? 'Unknown Title',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: titleFontSize,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if ((book['subtitle'] ?? '').isNotEmpty) ...[
                            SizedBox(height: 1),
                            Text(
                              book['subtitle'] ?? '',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: subtitleFontSize,
                                height: 1.1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookListItem(Map<String, dynamic> book) {
    final String categoryType = _getCategoryTagText(controller.category.value);
    final Color categoryColor = _getCategoryColor(controller.category.value);
    
    return GestureDetector(
      onTap: () {
        Get.toNamed('/detail', arguments: {
          'title': book['title'] ?? 'Unknown Title',
          'subtitle': book['subtitle'] ?? 'Unknown Subtitle',
          'coverImage': book['coverImage'] ?? 'assets/kucing.png',
          'isPremium': book['isPremium'] ?? false,
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image with fixed width
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    book['coverImage'] ?? 'assets/kucing.png',
                    width: 75,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 75,
                        height: 110,
                        color: Colors.grey.shade200,
                        child: Center(
                          child: Icon(Icons.book, color: Colors.grey, size: 20),
                        ),
                      );
                    },
                  ),
                  
                  if (book['isPremium'] == true)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Icon(Icons.diamond_outlined, size: 10, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
            
            // Content info with flexible width
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        categoryType,
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book['title'] ?? 'Unknown Title',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2),
                          Text(
                            book['subtitle'] ?? 'Unknown Subtitle',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _getCategoryTagText(String category) {
    switch(category) {
      case 'Cerita Rakyat':
        return 'Cerita Rakyat';
      case 'Buku Populer!':
        return 'Populer';
      case 'Buku Baru Dirilis':
        return 'Baru';
      case 'Majalah Bulan Ini':
        return 'Majalah';
      default:
        return 'Digital';
    }
  }
  
  Color _getCategoryColor(String category) {
    switch(category) {
      case 'Cerita Rakyat':
        return Color(0xFF8B4513);
      case 'Buku Populer!':
        return Color(0xFF9C27B0);
      case 'Buku Baru Dirilis':
        return Color(0xFF2196F3);
      case 'Majalah Bulan Ini':
        return Color(0xFF00B14F);
      default:
        return Color(0xFF00B14F);
    }
  }
}