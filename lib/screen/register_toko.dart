import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterTokoScreen extends StatefulWidget {
  const RegisterTokoScreen({Key? key}) : super(key: key);

  @override
  State<RegisterTokoScreen> createState() => _RegisterTokoScreenState();
}

class _RegisterTokoScreenState extends State<RegisterTokoScreen> {
  final _formFields = <String, TextEditingController>{
    'Nama Toko': TextEditingController(),
    'Email': TextEditingController(),
    'Password': TextEditingController(),
    'No. HP': TextEditingController(),
    'Alamat Toko': TextEditingController(),
  };

  final Map<String, TextInputType> _keyboardTypes = {
    'Email': TextInputType.emailAddress,
    'No. HP': TextInputType.phone,
    'Alamat Toko': TextInputType.streetAddress,
  };

  final Map<String, IconData> _fieldIcons = {
    'Nama Toko': Icons.store,
    'Email': Icons.email,
    'Password': Icons.lock,
    'No. HP': Icons.phone,
    'Alamat Toko': Icons.location_on,
  };

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  void dispose() {
    _formFields.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Widget _buildTextField(String label, {int? maxLines}) {
    final bool isPassword = label == 'Password';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: _formFields[label],
        obscureText: isPassword ? _obscurePassword : false,
        keyboardType: _keyboardTypes[label] ?? TextInputType.text,
        maxLines: isPassword ? 1 : maxLines,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.grey[100],
          hintText: label,
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            color: Colors.grey[600],
          ),
          prefixIcon: Icon(
              _fieldIcons[label],
              size: 18,
              color: const Color(0xFFBF0055)
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              size: 18,
              color: Colors.grey[600],
            ),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  void _showRegistrationSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success icon
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFBF0055).withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFFBF0055),
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),
                // Success message
                const Text(
                  'Pendaftaran Berhasil!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Toko Anda telah berhasil didaftarkan. Silahkan tunggu verifikasi dari tim kami.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                // OK button
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pop(); // Go back to previous screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBF0055),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFBF0055),
                        size: 20
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Header with icon and title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFBF0055).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.store,
                        size: 30,
                        color: Color(0xFFBF0055),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Daftarkan Toko',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            'Isi data toko Anda di bawah',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Expanded scrollable area for form
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 2,
                      shadowColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildTextField('Nama Toko'),
                            _buildTextField('Email'),
                            _buildTextField('Password'),
                            _buildTextField('No. HP'),
                            _buildTextField('Alamat Toko', maxLines: 2),

                            // Map section
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Lokasi Toko',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 180,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey.shade200),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      children: [
                                        // Map image
                                        Image.asset(
                                          'assets/images/map.png',
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.map,
                                                  size: 50,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        // Marker overlay
                                        Center(
                                          child: Icon(
                                            Icons.location_on,
                                            color: const Color(0xFFBF0055),
                                            size: 40,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black.withOpacity(0.3),
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Map controls
                                        Positioned(
                                          right: 8,
                                          bottom: 8,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 36,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.2),
                                                      blurRadius: 4,
                                                      offset: const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 24,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                width: 36,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.2),
                                                      blurRadius: 4,
                                                      offset: const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 24,
                                                  color: Colors.black87,
                                                ),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom Buttons Section
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Show registration success dialog
                        _showRegistrationSuccessDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBF0055),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Daftarkan Toko',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
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
    );
  }
}