import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/category_item.dart';
import '../widgets/promo_banner.dart';
import '../widgets/search_bar.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _currentBannerIndex = 0;
  late PageController _bannerController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _categories = [
    {
      'icon': 'assets/images/categories/makanan_icon.png',
      'name': 'Makanan',
      'color': AppColors.makananColor,
    },
    {
      'icon': 'assets/images/categories/vitamin_icon.png',
      'name': 'Vitamin',
      'color': AppColors.vitaminColor,
    },
    {
      'icon': 'assets/images/categories/mainan_icon.png',
      'name': 'Mainan',
      'color': AppColors.mainanColor,
    },
    {
      'icon': 'assets/images/categories/aksesoris_icon.png',
      'name': 'Aksesoris',
      'color': AppColors.aksesorisColor,
    },
    {
      'icon': 'assets/images/categories/kandang_icon.png',
      'name': 'Kandang',
      'color': AppColors.kandangColor,
    },
    {
      'icon': 'assets/images/categories/grooming_icon.png',
      'name': 'Grooming',
      'color': AppColors.groomingColor,
    },
  ];

  final List<Map<String, dynamic>> _promoBanners = [
    {
      'title': 'Diskon Spesial',
      'subtitle': 'Pakan Kucing 50%',
      'description': 'Berlaku sampai 31 Maret',
      'buttonText': 'Belanja Sekarang!',
      'backgroundColor': AppColors.purpleBanner,
      'image': 'assets/images/banners/cat_banner.png',
    },
    {
      'title': 'Gratis Ongkir',
      'subtitle': 'Semua Produk',
      'description': 'Tanpa minimum belanja',
      'buttonText': 'Klaim Sekarang!',
      'backgroundColor': AppColors.orangeBanner,
      'image': 'assets/images/banners/clock_truck_icon.png',
    },
    {
      'title': 'Flash Sale',
      'subtitle': 'Mulai Rp5.000',
      'description': 'Hanya hari ini',
      'buttonText': 'Lihat Semua',
      'backgroundColor': AppColors.greenBanner,
      'image': 'assets/images/banners/money_icon.png',
    },
    {
      'title': 'Bonus Poin',
      'subtitle': 'Setiap Transaksi',
      'description': 'Tukar poin jadi voucher belanja',
      'buttonText': 'Kumpulkan Poin',
      'backgroundColor': AppColors.redBanner,
      'image': 'assets/images/banners/percent_icon.png',
    },
  ];

  final List<Map<String, dynamic>> _productList = [
    {
      'imagePath': 'assets/images/products/royal_canin.png',
      'name': 'Royal Canin Sensible Adult Cat Food',
      'price': 350128.0,
      'rating': 5.0,
      'reviewCount': 5,
      'storeName': 'Cilok Pet Store',
      'storeLogoPath': 'assets/images/icons/cilok.png',
      'isFavorite': true,
    },
    {
      'imagePath': 'assets/images/products/petkit_feeder.png',
      'name': 'PETKIT YumShare Gemini Dua Dispenser',
      'price': 2580000.0,
      'originalPrice': 3580000.0,
      'discountPercentage': 28.0,
      'rating': 5.0,
      'reviewCount': 2,
      'storeName': 'PETKIT Indonesia',
      'storeLogoPath': 'assets/images/icons/petkit.png',
      'isFavorite': false,
    },
    {
      'imagePath': 'assets/images/products/ceramic.png',
      'name': 'Ceramic Pet Bowl Tempat Makan Keramik',
      'price': 250200.0,
      'rating': 4.0,
      'reviewCount': 3,
      'storeName': 'Pet-ority',
      'storeLogoPath': 'assets/images/icons/pet-ority.png',
      'isFavorite': true,
    },
    {
      'imagePath': 'assets/images/products/royal_canin.png',
      'name': 'Royal Canin Kitten Food Package',
      'price': 450000.0,
      'originalPrice': 500000.0,
      'discountPercentage': 10.0,
      'rating': 4.5,
      'reviewCount': 4,
      'storeName': 'Cilok Pet Store',
      'storeLogoPath': 'assets/images/icons/cilok.png',
      'isFavorite': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _bannerController = PageController();

    // Setup animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    // Setup timer to auto-scroll banner
    Future.delayed(Duration.zero, () {
      _autoScrollBanner();
    });
  }

  void _autoScrollBanner() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        if (_currentBannerIndex < _promoBanners.length - 1) {
          _currentBannerIndex++;
        } else {
          _currentBannerIndex = 0;
        }

        _bannerController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );

        _autoScrollBanner();
      }
    });
  }

  // New method to navigate to category products
  void _navigateToCategoryProducts(String categoryName) {
    Navigator.of(context).pushNamed(
      '/category-products',
      arguments: {'category': categoryName},
    );
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // App header with consistent padding
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    children: [
                      // Welcome text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Asan',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Find Your Pet Needs',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Notification icon with badge
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/notif');
                        },
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[200]!, width: 1),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                Icons.notifications_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                              Positioned(
                                top: 10,
                                right: 12,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Search bar with consistent styling
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: CustomSearchBar(),
                      ),
                      const SizedBox(width: 12),
                      // Promo button
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/promos');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          height: 46,
                          decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/icons/promo_icon.png',
                                width: 20,
                                height: 20,
                                color: AppColors.primaryColor,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.local_offer,
                                    size: 20,
                                    color: AppColors.primaryColor,
                                  );
                                },
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Promo',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Wishlist button
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/wishlist');
                        },
                        child: Container(
                          height: 46,
                          width: 46,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Promo banner carousel
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Special Offers',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Banner carousel
                      SizedBox(
                        height: 180,
                        child: PageView.builder(
                          controller: _bannerController,
                          itemCount: _promoBanners.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentBannerIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final banner = _promoBanners[index];
                            return PromoBanner(
                              title: banner['title'],
                              subtitle: banner['subtitle'],
                              description: banner['description'],
                              buttonText: banner['buttonText'],
                              backgroundColor: banner['backgroundColor'],
                              imagePath: banner['image'],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Carousel indicator with improved styling
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: _promoBanners.asMap().entries.map((entry) {
                            return Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentBannerIndex == entry.key
                                    ? AppColors.primaryColor
                                    : Colors.grey.withOpacity(0.3),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Categories carousel - UPDATED with navigation
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Categories horizontal list with onTap navigation
                      SizedBox(
                        height: 110,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            final category = _categories[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: CategoryItem(
                                iconPath: category['icon'],
                                name: category['name'],
                                backgroundColor: category['color'],
                                onTap: () => _navigateToCategoryProducts(category['name']),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Product recommendations
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recommendation',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle see all
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Product grid
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final product = _productList[index];
                      return ProductCard(
                        imagePath: product['imagePath'],
                        name: product['name'],
                        price: product['price'],
                        originalPrice: product['originalPrice'],
                        discountPercentage: product['discountPercentage'] ?? 0.0,
                        rating: product['rating'],
                        reviewCount: product['reviewCount'],
                        storeName: product['storeName'],
                        storeLogoPath: product['storeLogoPath'],
                        isFavorite: product['isFavorite'],
                        onTap: () {
                          Navigator.of(context).pushNamed('/product-detail');
                        },
                        onFavoriteTap: () {
                          // Handle favorite toggle
                          setState(() {
                            product['isFavorite'] = !product['isFavorite'];
                          });
                        },
                      );
                    },
                    childCount: _productList.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}