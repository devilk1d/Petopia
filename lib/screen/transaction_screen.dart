import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabTitles = ['Semua', 'Berlangsung', 'Berhasil', 'Gagal'];
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _transactions = [
    {
      'storeName': 'Cilok Pet Store',
      'storeIconPath': 'assets/images/icons/cilok.png',
      'invoiceNumber': 'INV #1029938',
      'productName': 'Royal Canin Sensible Adult Dry Cat Food',
      'quantity': '1 barang',
      'price': 'Rp350.128',
      'date': '17 Maret 2024',
      'status': 'Sedang Dikirim',
      'productImagePath': 'assets/images/products/royal_canin.png',
    },
    {
      'storeName': 'Pet-ority',
      'storeIconPath': 'assets/images/icons/pet-ority.png',
      'invoiceNumber': 'INV #1029129',
      'productName': 'Ceramic Pet Bowl Tempat Makan Keramik - Rendah, Hitam',
      'quantity': '2 barang',
      'price': 'Rp250.200',
      'date': '15 Maret 2024',
      'status': 'Diterima',
      'productImagePath': 'assets/images/products/ceramic.png',
    },
    {
      'storeName': 'PETKIT Indonesia',
      'storeIconPath': 'assets/images/icons/petkit.png',
      'invoiceNumber': 'INV #9392973',
      'productName': 'PETKIT YumShare Gemini Dual-hopper with Camera',
      'quantity': '1 barang',
      'price': 'Rp2.580.000',
      'date': '10 Maret 2024',
      'status': 'Dalam Proses',
      'productImagePath': 'assets/images/products/petkit_feeder.png',
    },
  ];

  // Method to filter transactions based on selected tab
  List<Map<String, dynamic>> get _filteredTransactions {
    switch (_selectedTabIndex) {
      case 1: // Berlangsung
        return _transactions.where((tx) =>
        tx['status'] == 'Dalam Proses' || tx['status'] == 'Sedang Dikirim').toList();
      case 2: // Berhasil
        return _transactions.where((tx) => tx['status'] == 'Diterima').toList();
      case 3: // Gagal
        return _transactions.where((tx) =>
        tx['status'] == 'Gagal' || tx['status'] == 'Dibatalkan').toList();
      case 0: // Semua
      default:
        return _transactions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeader(),

            // Search and Tab Bar
            _buildSearchAndTabs(),

            // Transaction List
            Expanded(
              child: _filteredTransactions.isEmpty
                  ? _buildEmptyState()
                  : _buildTransactionList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: const Text(
        'Riwayat Transaksi',
        style: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildSearchAndTabs() {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari transaksi...',
                hintStyle: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),

        // Tab Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _tabTitles.length,
            itemBuilder: (context, index) => _buildTabItem(index),
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Text(
              _tabTitles[index],
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primaryColor : Colors.grey,
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 6),
                width: 40,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      itemCount: _filteredTransactions.length, // Use filtered transactions
      itemBuilder: (context, index) {
        final transaction = _filteredTransactions[index]; // Use filtered transactions
        return _buildTransactionCard(transaction);
      },
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/order-detail'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
            // Store and invoice info
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Store icon using custom image for each store
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          transaction['storeIconPath'],
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to generic store icon if image fails to load
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
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        transaction['storeName'],
                        style: const TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  _buildStatusTag(transaction['status']),
                ],
              ),
            ),

            // Product details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      transaction['productImagePath'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Product info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction['productName'],
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          transaction['quantity'],
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          transaction['price'],
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF108F6A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Date and invoice
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        transaction['date'],
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    transaction['invoiceNumber'],
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
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

  Widget _buildStatusTag(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'Sedang Dikirim':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade700;
        break;
      case 'Diterima':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
        break;
      case 'Dalam Proses':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade700;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
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
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada transaksi',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Transaksi Anda akan muncul di sini',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}