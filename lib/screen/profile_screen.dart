import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with profile title and logout button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profile',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/onboarding');
                          },
                          child: const Icon(
                            Icons.logout_rounded,
                            color: Color(0xFFBF0055),
                            size: 24,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // User Profiles Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section title
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFBF0055).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              color: Color(0xFFBF0055),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'User Profiles',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // User profile cards in horizontal scroll
                      SizedBox(
                        height: 165,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildProfileCard(
                              'assets/images/profile/asang.jpg',
                              'Asan',
                              isLoggedIn: true,
                              onTap: () {
                                Navigator.pushNamed(context, '/user-profile');
                              },
                            ),
                            _buildProfileCard(
                              'assets/images/profile/ibnu.jpg',
                              'Abim',
                              isLoggedIn: false,
                              onTap: () {
                                Navigator.pushNamed(context, '/user-profile');
                              },
                            ),
                            _buildProfileCard(
                              'assets/images/profile/aufa.jpg',
                              'Aufa',
                              isLoggedIn: false,
                              onTap: () {
                                Navigator.pushNamed(context, '/user-profile');
                              },
                            ),
                            _buildAddProfileCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Store Profiles Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section title
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF15326A).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.store_rounded,
                              color: Color(0xFF15326A),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Store Profiles',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Store profile cards in horizontal scroll
                      SizedBox(
                        height: 165,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildStoreCard(
                              'assets/images/profile/forza.jpg',
                              'Forza Inc.',
                              onTap: () {
                                Navigator.pushNamed(context, '/store-profile');
                              },
                            ),
                            _buildAddStoreCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // About Us Section (from your original code, unchanged)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.groups_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'About Us',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SF Pro Display',
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Kami adalah para sigma male, skibidi, rizz, +100000 aura',
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),

                      _buildAboutMember(
                        'assets/images/aufa.png',
                        '2307413014',
                        'Aufa Kautsar\nAhmad',
                        'TI 4 MSU',
                        context,
                        imageWidth: 140,
                        imageHeight: 165,
                      ),
                      const SizedBox(height: 16),
                      _buildAboutMember(
                        'assets/images/cilok.png',
                        '2307413003',
                        'Rizqi Asan\nMasika',
                        'TI 4 MSU',
                        context,
                        imageWidth: 140,
                        imageHeight: 165,
                      ),
                      const SizedBox(height: 16),
                      _buildAboutMember(
                        'assets/images/ibnu.png',
                        '2307413019',
                        'Ibnu Dwito\nAbimanyu',
                        'TI 4 MSU',
                        context,
                        imageWidth: 160,
                        imageHeight: 165,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40), // Space for bottom nav bar
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(String imageUrl, String name,
      {bool isLoggedIn = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: isLoggedIn
              ? Border.all(color: const Color(0xFFBF0055), width: 2)
              : Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile avatar with active indicator
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isLoggedIn ? const Color(0xFFBF0055) : Colors.grey.shade200,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isLoggedIn)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFFBF0055),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Name
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Active status
            if (isLoggedIn)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFBF0055).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFBF0055),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddProfileCard() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/login');
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Color(0xFFBF0055),
                size: 40,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Add Profile',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreCard(String imageUrl, String name, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Store logo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF15326A).withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Store name
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Store badge
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF15326A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Store',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF15326A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddStoreCard() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/register-toko');
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_business_rounded,
                color: Color(0xFF15326A),
                size: 36,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Add Store',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  // Keeping your original method for the About Us section
  Widget _buildAboutMember(
      String imageUrl,
      String id,
      String name,
      String className,
      BuildContext context, {
        double imageWidth = 140,
        double imageHeight = 190,
      }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(248, 248, 248, 1),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background container (data)
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(right: 0),
            padding: const EdgeInsets.only(
              left: 20,
              right: 140, // Ruang untuk gambar
              top: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    id,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontFamily: 'SF Pro Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'SF Pro Display',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    className,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: 'SF Pro Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Floating image (di kanan)
          Positioned(
            right: 10,
            top: -10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imageUrl,
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}