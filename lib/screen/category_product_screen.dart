import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/product_card.dart';

class CategoryProductsPage extends StatefulWidget {
  const CategoryProductsPage({Key? key}) : super(key: key);

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  // Sample products data for each category
  final Map<String, List<Map<String, dynamic>>> _categoryProducts = {
    'Makanan': [
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
      {
        'imagePath': 'assets/images/products/royal_canin.png',
        'name': 'Whiskas Adult Cat Food',
        'price': 150000.0,
        'rating': 4.2,
        'reviewCount': 12,
        'storeName': 'Pet Shop Jaya',
        'storeLogoPath': 'assets/images/icons/cilok.png',
        'isFavorite': false,
      },
    ],
    'Vitamin': [
      {
        'imagePath': 'assets/images/products/royal_canin.png',
        'name': 'Pet Multivitamin Drops',
        'price': 120000.0,
        'rating': 4.8,
        'reviewCount': 7,
        'storeName': 'Pet-ority',
        'storeLogoPath': 'assets/images/icons/pet-ority.png',
        'isFavorite': false,
      },
      {
        'imagePath': 'assets/images/products/royal_canin.png',
        'name': 'Cat Calcium Supplement',
        'price': 89000.0,
        'originalPrice': 110000.0,
        'discountPercentage': 19.0,
        'rating': 4.3,
        'reviewCount': 6,
        'storeName': 'PETKIT Indonesia',
        'storeLogoPath': 'assets/images/icons/petkit.png',
        'isFavorite': true,
      },
    ],
    'Mainan': [
      {
        'imagePath': 'assets/images/products/royal_canin.png',
        'name': 'Cat Interactive Toy Ball',
        'price': 45000.0,
        'rating': 4.7,
        'reviewCount': 15,
        'storeName': 'Pet-ority',
        'storeLogoPath': 'assets/images/icons/pet-ority.png',
        'isFavorite': false,
      },
      {
        'imagePath': 'assets/images/products/royal_canin.png',
        'name': 'Mouse Teaser Wand',
        'price': 35000.0,
        'rating': 4.9,
        'reviewCount': 22,
        'storeName': 'Cilok Pet Store',
        'storeLogoPath': 'assets/images/icons/cilok.png',
        'isFavorite': true,
      },
    ],
    'Aksesoris': [
      {
        'imagePath': 'assets/images/products/royal_canin.png',
        'name': 'Cat Collar with Bell',
        'price': 29000.0,
        'rating': 4.5,
        'reviewCount': 16,
        'storeName': 'Pet Shop Jaya',
        'storeLogoPath': 'assets/images/icons/cilok.png',
        'isFavorite': true,
      },
      {
        'imagePath': 'assets/images/products/royal_canin.png',
        'name': 'Pet Fashion Bow Tie',
        'price': 19000.0,
        'originalPrice': 25000.0,
        'discountPercentage': 24.0,
        'rating': 4.2,
        'reviewCount': 8,
        'storeName': 'PETKIT Indonesia',
        'storeLogoPath': 'assets/images/icons/petkit.png',
        'isFavorite': false,
      },
    ],
    'Kandang': [
      {
        'imagePath': 'assets/images/products/royal_canin.png',
        'name': 'Premium Cat Cage Large',
        'price': 1250000.0,
        'originalPrice': 1500000.0,
        'discountPercentage': 16.7,
        'rating': 4.9,
        'reviewCount': 4,
        'storeName': 'Pet-ority',
        'storeLogoPath': 'assets/images/icons/pet-ority.png',
        'isFavorite': true,
      },
      {
        'imagePath': 'assets/images/products/royal_canin.png',
        'name': 'Cat House Wooden',
        'price': 875000.0,
        'rating': 4.6,
        'reviewCount': 7,
        'storeName': 'Cilok Pet Store',
        'storeLogoPath': 'assets/images/icons/cilok.png',
        'isFavorite': false,
      },
    ],
    'Grooming': [
      {
        'imagePath': 'assets/images/products/royal_canin.png',
        'name': 'Cat Shampoo Anti Flea',
        'price': 75000.0,
        'rating': 4.8,
        'reviewCount': 14,
        'storeName': 'Pet Shop Jaya',
        'storeLogoPath': 'assets/images/icons/cilok.png',
        'isFavorite': false,
      },
      {
        'imagePath': 'assets/images/products/royal_canin.png',
        'name': 'Pet Grooming Brush Set',
        'price': 125000.0,
        'originalPrice': 150000.0,
        'discountPercentage': 16.7,
        'rating': 4.7,
        'reviewCount': 9,
        'storeName': 'PETKIT Indonesia',
        'storeLogoPath': 'assets/images/icons/petkit.png',
        'isFavorite': true,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Extract category name from route arguments
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String categoryName = args['category'];

    // Get products for this category
    final List<Map<String, dynamic>> products = _categoryProducts[categoryName] ?? [];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
        categoryName,
        style: const TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        ),
        ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black),
              onPressed: () {
                // Handle filter action
    },
    ),
            IconButton(
              icon: const Icon(Icons.sort, color: Colors.black),
              onPressed: () {
    // Handle sort action
    },
    ),
    ],
    ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Showing all ${products.length} products in ${categoryName}',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),

            // Products grid
            Expanded(
              child: products.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icons/empty_box.png',
                      width: 100,
                      height: 100,
                      color: Colors.grey[400],
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.inventory_2_outlined,
                          size: 100,
                          color: Colors.grey[400],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No products found in this category',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
                  : GridView.builder(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
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
                      setState(() {
                        product['isFavorite'] = !product['isFavorite'];
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}