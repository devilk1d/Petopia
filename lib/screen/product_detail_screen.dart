import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> with SingleTickerProviderStateMixin {
  int _selectedImageIndex = 0;
  String _selectedVariant = 'Feeder';
  int _quantity = 1;
  bool _isFavorite = false;
  final List<String> _images = [
    'assets/images/products/petkit_feeder.png',
    'assets/images/products/petkit_3.jpg',
    'assets/images/products/petkit_4.jpg',
    'assets/images/products/petkit_5.png',
  ];

  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Custom navigation controls at the top
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: _buildTopNavigation(),
                  ),
                ),

                // Image carousel with page indicator
                SliverToBoxAdapter(
                  child: _buildImageCarousel(),
                ),

                // Product info
                SliverToBoxAdapter(
                  child: AnimatedBuilder(
                    animation: _slideAnimation,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: child,
                    ),
                    child: _buildProductInfo(),
                  ),
                ),

                // Extra space for bottom buttons
                SliverToBoxAdapter(
                  child: SizedBox(height: 80),
                ),
              ],
            ),

            // Bottom action buttons (fixed)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),

          // Share button
          GestureDetector(
            onTap: () {/* Handle share */},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.share_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Stack(
      children: [
        // Main image with PageView for swiping
        SizedBox(
          width: double.infinity,
          height: 400, // Reduced height since we don't have the AppBar
          child: PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (index) => setState(() => _selectedImageIndex = index),
            itemBuilder: (context, index) {
              return Hero(
                tag: 'product_image_${_images[index]}',
                child: Image.asset(
                  _images[index],
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[100],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Favorite button
        Positioned(
          top: 20,
          right: 14,
          child: GestureDetector(
            onTap: () => setState(() => _isFavorite = !_isFavorite),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: _isFavorite
                    ? const Icon(
                  Icons.favorite,
                  key: ValueKey('favorite'),
                  color: AppColors.primaryColor,
                  size: 17,
                )
                    : const Icon(
                  Icons.favorite_border,
                  key: ValueKey('favorite_border'),
                  color: Colors.black,
                  size: 17,
                ),
              ),
            ),
          ),
        ),

        // Image indicator dots
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _pageController.animateToPage(
                  entry.key,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                child: Container(
                  width: _selectedImageIndex == entry.key ? 12 : 8,
                  height: _selectedImageIndex == entry.key ? 12 : 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectedImageIndex == entry.key
                        ? AppColors.primaryColor
                        : Colors.grey.withOpacity(0.3),
                    border: _selectedImageIndex == entry.key
                        ? Border.all(color: Colors.white, width: 2)
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Store info with verification badge
          _buildStoreInfo(),
          const SizedBox(height: 16),

          // Product title with improved typography
          const Text(
            'PETKIT YumShare Gemini Dual-hopper with Camera Smart Pet Feeder',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 16),
          _buildVariantSelector(),
          const SizedBox(height: 24),
          _buildQuantityAndPrice(),
          const SizedBox(height: 24),

          // Divider
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 24),
          _buildProductDescription(),
        ],
      ),
    );
  }

  Widget _buildStoreInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/images/icons/petkit.png',
            width: 30,
            height: 30,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 30,
              height: 30,
              color: Colors.grey[200],
              child: const Icon(
                Icons.store,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'PETKIT Indonesia',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.verified,
          size: 16,
          color: Colors.blue,
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.star,
                size: 14,
                color: Color(0xFFFFA000),
              ),
              SizedBox(width: 2),
              Text(
                '4.7',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVariantSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Variant',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildVariantOption('Feeder Set'),
              const SizedBox(width: 12),
              _buildVariantOption('Feeder'),
              const SizedBox(width: 12),
              _buildVariantOption('Feeder Combo'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVariantOption(String title) {
    bool isSelected = _selectedVariant == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedVariant = title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? AppColors.primaryColor : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityAndPrice() {
    return Row(
      children: [
        // Quantity selector
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 50,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (_quantity > 1) setState(() => _quantity--);
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _quantity > 1 ? AppColors.primaryColor : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                child: Text(
                  _quantity.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _quantity++),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        // Price display with discount
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Rp3.580.000',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE4E2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '28%',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE11D48),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Rp2.580.000',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Description',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'PETKIT YumShare Dual-hopper Smart Feeder with Camera, an AI-powered pet feeding master that enables pet owners to create personalized feeding schedules and remotely dispense food using a smartphone app.\n\nWith its integrated camera, you can monitor your pets in real-time and communicate with them through two-way audio, even when you\'re away. The feeder also automatically records precious moments of your pets, which you can watch through the app of their interactions with the feeder.',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 14,
            height: 1.6,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildFeatureItem(Icons.verified_user, 'PETKIT Sole Distributor in Indonesia'),
        const SizedBox(height: 8),
        _buildFeatureItem(Icons.event_available, '1 Year Warranty from date of shipment'),
        const SizedBox(height: 8),
        _buildFeatureItem(Icons.location_on, 'Service center located in Tangerang, Banten'),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            icon,
            size: 16,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 14,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Chat with seller button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const Icon(
              Icons.chat_outlined,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 16),
          // Expanded buttons row
          Expanded(
            child: Row(
              children: [
                // Add to cart button
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48,
                    margin: const EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  'Added to cart',
                                  style: TextStyle(fontFamily: 'SF Pro Display'),
                                ),
                              ],
                            ),
                            backgroundColor: AppColors.success,
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(10),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: AppColors.primaryColor),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Buy now button
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pushNamed('/checkout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}