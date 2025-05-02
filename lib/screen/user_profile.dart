import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Pink container
                Container(
                  width: double.infinity,
                  color: const Color(0xFFB60051),
                  padding: const EdgeInsets.only(top: 35, bottom: 130),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Profile settings',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                ),

                // White card with user information
                Positioned(
                  top: 179,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x38FFFFFF),
                          blurRadius: 25,
                          spreadRadius: 25,
                          offset: Offset(0, 9),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User name and username
                          const Center(
                            child: Column(
                              children: [
                                Text(
                                  'Asan',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '@asanmasika',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Profile fields
                          _buildProfileSection('Nama', 'Asan'),
                          _buildProfileSection('Username', '@asanmasika'),
                          _buildProfileSection('Password', '**********'),
                          _buildProfileSection('Email', 'asanmasika@gmail.com'),
                          _buildProfileSection('No. HP', '+62 877-7120-4269'),
                          _buildProfileSection('Alamat', 'Jl. Pengadegan Selatan No.5, RT.1/RW.4, Pengadegan'),

                          // Save button
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 15),
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFFB60051),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(25),
                                onTap: () {},
                                child: const Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.save_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Simpan',
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Display',
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Floating profile picture with custom edit button
                Positioned(
                  top: 110,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/777.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/images/icons/Edit But.png',
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build profile field sections
  Widget _buildProfileSection(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 16,
              color: Color(0xFF232323),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 2),
        _buildProfileField(value),
        const SizedBox(height: 12),
      ],
    );
  }

  // ProfileField widget integrated directly
  Widget _buildProfileField(String value) {
    return Container(
      width: double.infinity,
      height: 45,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          value,
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 14,
            color: Color(0xFF6A6A6A),
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}