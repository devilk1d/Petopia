import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Store selections tracking
  Map<String, bool> _storeSelections = {
    'Cilok Pet Store': true,
    'Pet-ority': false,
    'PETKIT Indonesia': true,
  };

  // Product selections tracking
  Map<String, bool> _productSelections = {
    'Royal Canin': true,
    'Ceramic Pet Bowl': false,
    'PETKIT YumShare Gemini 1': true,
    'PETKIT YumShare Gemini 2': true,
  };

  // Product quantities
  Map<String, int> _quantities = {
    'Royal Canin': 1,
    'Ceramic Pet Bowl': 2,
    'PETKIT YumShare Gemini 1': 1,
    'PETKIT YumShare Gemini 2': 1,
  };

  // Cart data structure with store icons added
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': 'Royal Canin',
      'storeName': 'Cilok Pet Store',
      'storeIcon': 'assets/images/icons/cilok.png',
      'productName': 'Royal Canin Sensible Adult Dry Cat Food',
      'price': 350128.0,
      'imagePath': 'assets/images/products/royal_canin.png',
    },
    {
      'id': 'Ceramic Pet Bowl',
      'storeName': 'Pet-ority',
      'storeIcon': 'assets/images/icons/pet-ority.png',
      'productName': 'Ceramic Pet Bowl Tempat Makan Keramik',
      'price': 250200.0,
      'imagePath': 'assets/images/products/ceramic.png',
      'variant': 'Rendah',
    },
    {
      'id': 'PETKIT YumShare Gemini 1',
      'storeName': 'PETKIT Indonesia',
      'storeIcon': 'assets/images/icons/petkit.png',
      'productName': 'PETKIT YumShare Gemini Dual-hopper with Camera',
      'price': 2580000.0,
      'imagePath': 'assets/images/products/petkit_feeder.png',
      'variant': 'Feeder',
    },
    {
      'id': 'PETKIT YumShare Gemini 2',
      'storeName': 'PETKIT Indonesia',
      'storeIcon': 'assets/images/icons/petkit.png',
      'productName': 'PETKIT YumShare Gemini Dual-hopper with Camera',
      'price': 2580000.0,
      'imagePath': 'assets/images/products/petkit_feeder.png',
      'variant': 'Feeder',
    },
  ];

  // Promo code controller
  final TextEditingController _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  // Get total price of selected items
  double get _totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      if (_productSelections[item['id']] == true) {
        total += item['price'] * _quantities[item['id']]!;
      }
    }
    return total;
  }

  // Get selected item count
  int get _selectedItemCount {
    return _productSelections.values.where((selected) => selected).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : _buildCartContent(),
    );
  }

  Widget _buildCartContent() {
    return SafeArea(
      child: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                _buildCartHeader(),
                ..._buildStoreGroups(),
              ],
            ),
          ),
          _buildCheckoutSection(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Keranjang',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          IconButton(
            onPressed: _cartItems.isEmpty
                ? null
                : () {
              _confirmDeleteAll();
            },
            icon: const Icon(Icons.delete_outline_rounded, size: 24),
            tooltip: 'Hapus semua',
          ),
        ],
      ),
    );
  }

  Widget _buildCartHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '$_selectedItemCount item',
                style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'dipilih',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () {
              setState(() {
                bool allSelected = _productSelections.values.every((v) => v);
                // Toggle selection: if all are selected, unselect all; otherwise select all
                for (var key in _productSelections.keys) {
                  _productSelections[key] = !allSelected;
                }
                for (var key in _storeSelections.keys) {
                  _storeSelections[key] = !allSelected;
                }
              });
            },
            icon: Icon(
              _productSelections.values.every((v) => v)
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              size: 18,
              color: AppColors.primaryColor,
            ),
            label: Text(
              _productSelections.values.every((v) => v)
                  ? 'Batalkan Semua'
                  : 'Pilih Semua',
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStoreGroups() {
    // Group items by store
    Map<String, List<Map<String, dynamic>>> storeGroups = {};

    for (var item in _cartItems) {
      String storeName = item['storeName'];
      if (!storeGroups.containsKey(storeName)) {
        storeGroups[storeName] = [];
      }
      storeGroups[storeName]!.add(item);
    }

    // Build each store's group
    List<Widget> storeWidgets = [];

    storeGroups.forEach((storeName, items) {
      storeWidgets.add(
        _buildStoreSection(storeName, items),
      );
    });

    return storeWidgets;
  }

  Widget _buildStoreSection(String storeName, List<Map<String, dynamic>> items) {
    // Get the store icon from the first item in the group
    String? storeIconPath = items.first['storeIcon'];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Store header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _storeSelections[storeName] ?? false,
                    activeColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        _storeSelections[storeName] = value ?? false;

                        // Update all products from this store
                        for (var item in items) {
                          _productSelections[item['id']] = value ?? false;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: storeIconPath != null
                          ? Image.asset(
                        storeIconPath,
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.store,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                          );
                        },
                      )
                          : Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.store,
                          size: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      storeName,
                      style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Divider
          Divider(color: Colors.grey.shade200, height: 1),

          // Products
          Column(
            children: items.map((item) => _buildCartItem(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _productSelections[item['id']] ?? false,
                  activeColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (bool? value) {
                    setState(() {
                      _productSelections[item['id']] = value ?? false;

                      // Check if all items from this store are selected
                      List<Map<String, dynamic>> storeItems = _cartItems
                          .where((i) => i['storeName'] == item['storeName'])
                          .toList();

                      bool allSelected = storeItems.every(
                              (i) => _productSelections[i['id']] == true);

                      _storeSelections[item['storeName']] = allSelected;
                    });
                  },
                ),
              ),

              const SizedBox(width: 12),

              // Product image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item['imagePath'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 12),

              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['productName'],
                      style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (item.containsKey('variant') && item['variant'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item['variant'],
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 8),

                    // Price
                    Text(
                      'Rp${_formatPrice(item['price'])}',
                      style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF108F6A),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Quantity selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildQuantitySelector(item['id']),

                        // Delete button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // Show confirmation dialog before removing
                              _confirmDeleteItem(item);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              size: 18,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Divider between products
        if (_cartItems.last != item)
          Divider(color: Colors.grey.shade200, height: 1, indent: 16, endIndent: 16),
      ],
    );
  }

  Widget _buildQuantitySelector(String itemId) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          // Decrease button
          GestureDetector(
            onTap: () {
              setState(() {
                if ((_quantities[itemId] ?? 1) > 1) {
                  _quantities[itemId] = (_quantities[itemId] ?? 1) - 1;
                }
              });
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: (_quantities[itemId] ?? 1) > 1
                    ? AppColors.primaryColor
                    : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),

          // Quantity display
          Container(
            width: 36,
            alignment: Alignment.center,
            child: Text(
              (_quantities[itemId] ?? 1).toString(),
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Increase button
          GestureDetector(
            onTap: () {
              setState(() {
                _quantities[itemId] = (_quantities[itemId] ?? 1) + 1;
              });
            },
            child: Container(
              width: 28,
              height: 28,
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
    );
  }

  void _confirmDeleteAll() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Hapus Semua Barang',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            'Apakah Anda yakin ingin menghapus semua barang dari keranjang?',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Batal',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _deleteAllItems();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Hapus',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteAllItems() {
    setState(() {
      _cartItems.clear();
      _productSelections.clear();
      _quantities.clear();
      _storeSelections.clear();
    });
  }

  void _confirmDeleteItem(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Hapus Barang',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus ${item['productName']} dari keranjang?',
            style: const TextStyle(
              fontFamily: 'SF Pro Display',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Batal',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _cartItems.removeWhere((i) => i['id'] == item['id']);
                  _productSelections.remove(item['id']);
                  _quantities.remove(item['id']);

                  // Update store selection if needed
                  List<Map<String, dynamic>> storeItems = _cartItems
                      .where((i) => i['storeName'] == item['storeName'])
                      .toList();

                  if (storeItems.isEmpty) {
                    _storeSelections.remove(item['storeName']);
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                'Hapus',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Promo code input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.discount_outlined,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _promoController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Kode Promo',
                      hintStyle: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    'Pakai',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Price summary and checkout button
          Row(
            children: [
              // Price info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Harga',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Rp${_formatPrice(_totalPrice)}',
                      style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // Checkout button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _selectedItemCount > 0
                      ? () => Navigator.pushNamed(context, '/checkout')
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  child: Text(
                    'Checkout ($_selectedItemCount)',
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return SafeArea(
      child: Column(
        children: [
          // App bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 23, 20, 0),
            child: Row(
              children: [
                const Text(
                  'Keranjang',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Empty state illustration
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icons/empty_cart.png',
                    width: 200,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.shopping_cart_outlined,
                        size: 120,
                        color: Colors.grey.shade300,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Keranjang Anda Kosong',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Sepertinya Anda belum menambahkan\nproduk apapun ke keranjang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Mulai Belanja',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Format price with dots as thousand separators
  String _formatPrice(double price) {
    String priceStr = price.toStringAsFixed(0);
    final result = StringBuffer();

    for (int i = 0; i < priceStr.length; i++) {
      if (i > 0 && (priceStr.length - i) % 3 == 0) {
        result.write('.');
      }
      result.write(priceStr[i]);
    }

    return result.toString();
  }
}