import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Cat', 'Dog', 'Birds', 'Fishes'];
  final Set<int> _favoriteArticles = {};

  final List<Map<String, dynamic>> _articles = [
    {
      'image': 'assets/images/article/kucing1.jpg',
      'title': 'Kucing: Hewan Peliharaan yang Menggemaskan',
      'category': 'Cat',
      'desc': 'Temukan cara merawat kucing kesayangan Anda'
    },
    {
      'image': 'assets/images/article/kucing2.jpg',
      'title': 'Mengenal Lebih Dalam tentang Kucing Anda',
      'category': 'Cat',
      'desc': 'Panduan lengkap memahami perilaku kucing'
    },
    {
      'image': 'assets/images/article/anjing1.jpg',
      'title': 'Anjing Lucu Namun Cocok untuk Penjaga',
      'category': 'Dog',
      'desc': 'Rekomendasi ras anjing untuk keluarga'
    },
    {
      'image': 'assets/images/article/anjing2.jpg',
      'title': '10 Fakta Baru Agar Anda Lebih Dekat dengan Anjing',
      'category': 'Dog',
      'desc': 'Anjing lebih pintar dari yang Anda kira'
    },
    {
      'image': 'assets/images/article/burung1.jpg',
      'title': 'Panduan Memilih Sangkar Burung',
      'category': 'Birds',
      'desc': 'Tips memilih sangkar yang nyaman untuk burung'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredArticles = _selectedCategory == 'All'
        ? _articles
        : _articles.where((article) => article['category'] == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with decoration
            Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title with gradient
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [AppColors.primaryColor, AppColors.primaryDark],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: const Text(
                      'Articles',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Category tabs with animated selection indicator
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = category == _selectedCategory;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: isSelected
                                  ? Border.all(color: AppColors.primaryColor, width: 1.5)
                                  : null,
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                color: isSelected ? AppColors.primaryColor : Colors.grey[500],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Articles list
            Expanded(
              child: filteredArticles.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) => _buildArticleCard(filteredArticles[index], index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.article_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No articles found',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try selecting a different category',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(Map<String, dynamic> article, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/article-detail');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with category badge and favorite button
            Stack(
              children: [
                // Image with gradient overlay
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    children: [
                      Image.asset(
                        article['image'],
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 180,
                            color: Colors.grey[300],
                            child: const Center(child: Icon(Icons.image_not_supported)),
                          );
                        },
                      ),
                      // Gradient overlay for better text visibility
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                              stops: const [0.6, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Category badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      article['category'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // Favorite button
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // Toggle status favorit berdasarkan index artikel
                        if (_favoriteArticles.contains(index)) {
                          _favoriteArticles.remove(index);
                        } else {
                          _favoriteArticles.add(index);
                        }
                      });
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _favoriteArticles.contains(index)
                            ? Icons.favorite  // Ikon filled jika favorit
                            : Icons.favorite_border,  // Ikon outline jika tidak favorit
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),

                // Title at bottom of image
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      article['title'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),

            // Description and Read More button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Expanded(
                    child: Text(
                      article['desc'],
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Read more button
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/article-detail');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Read',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}