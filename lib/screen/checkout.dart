import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/order_item.dart';
import '../widgets/payment_method.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedPaymentMethod = 0;

  // Payment method data
  final List<Map<String, dynamic>> _paymentMethods = [
    {'logo': 'assets/images/icons/bca.png', 'name': 'BCA Virtual Account'},
    {'logo': 'assets/images/icons/mandiri.png', 'name': 'Mandiri Virtual Account'},
    {'logo': 'assets/images/icons/bri.png', 'name': 'BRI Virtual Account'},
    {'logo': 'assets/images/icons/alfa.png', 'name': 'Alfamart / Alfamidi / Lawson / Dan+Dan'},
  ];

  // Order items data
  final List<Map<String, dynamic>> _orderItems = [
    {
      'storeName': 'Cilok Pet Store',
      'productImage': 'assets/images/products/royal_canin.png',
      'productName': 'Royal Canin Sensible Adult Dry Cat Food',
      'variant': '',
      'price': 'Rp350.128',
      'quantity': 1,
    },
    {
      'storeName': 'Pet-ority',
      'productImage': 'assets/images/bowl.jpg',
      'productName': 'Ceramic Pet Bowl Tempat Makan Keramik - Rendah, Hitam',
      'variant': 'Rendah - Hijau',
      'price': 'Rp250.200',
      'quantity': 2,
    },
    {
      'storeName': 'PETKIT Indonesia',
      'productImage': 'assets/images/products/petkit_feeder.png',
      'productName': 'PETKIT YumShare Gemini Dual-hopper with Camera Smart Pet Feeder - Feeder',
      'variant': 'Feeder',
      'price': 'Rp2.580.000',
      'quantity': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primaryColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shipping Address Card
                    _buildShippingAddressCard(),

                    // Order Items Section
                    _buildOrderItemsSection(),

                    // Payment Methods Section
                    _buildPaymentMethodsSection(),

                    // Order Summary Section
                    _buildOrderSummarySection(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // Fixed payment button at bottom
          _buildPaymentButton(),
        ],
      ),
    );
  }

  Widget _buildShippingAddressCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Alamat pengiriman',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro Display',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/address-list');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                  ),
                  child: const Text('Ubah'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primaryColor, size: 20),
                SizedBox(width: 8),
                Text(
                  'Rumah - Abim',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SF Pro Display',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/map.png',
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemsSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pesanan Anda',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'SF Pro Display',
              ),
            ),
            const SizedBox(height: 16),

            // Order items list
            ..._orderItems.map((item) => Column(
              children: [
                OrderItemWidget(
                  storeName: item['storeName'],
                  productImages: [item['productImage']],
                  productName: item['productName'],
                  productVariant: item['variant'],
                  price: item['price'],
                  quantity: item['quantity'],
                  isSmallScreen: true,
                  onAddNote: () {},
                ),
                if (item != _orderItems.last)
                  const Divider(height: 24, thickness: 1),
              ],
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro Display',
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade600,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                  ),
                  child: const Text('Lihat Semua'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Payment methods list
            ..._paymentMethods.asMap().entries.map((entry) {
              final index = entry.key;
              final method = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: PaymentMethodWidget(
                  logoUrl: method['logo'],
                  name: method['name'],
                  isSelected: selectedPaymentMethod == index,
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = index;
                    });
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummarySection() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan belanja',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'SF Pro Display',
              ),
            ),
            const SizedBox(height: 12),

            // Summary rows
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Harga (4 Barang)',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7B7B7B),
                    fontFamily: 'SF Pro Display',
                  ),
                ),
                Text(
                  'Rp3.180.328',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7B7B7B),
                    fontFamily: 'SF Pro Display',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Ongkos Kirim',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7B7B7B),
                    fontFamily: 'SF Pro Display',
                  ),
                ),
                Text(
                  'Rp23.000',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7B7B7B),
                    fontFamily: 'SF Pro Display',
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Pembayaran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro Display',
                  ),
                ),
                Text(
                  'Rp3.203.328',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SF Pro Display',
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/payment');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.payment_rounded, size: 24),
              const SizedBox(width: 12),
              const Text(
                'Bayar Sekarang',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SF Pro Display',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}