import 'package:flutter/material.dart';
import '../screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // Prevent resizing when keyboard appears
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button with reduced padding
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                      ),
                    ),
                  ),

                  // Monkey Image - reduced size and padding
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 8),
                    child: Image.asset(
                      'assets/images/icons/monyet.png',
                      width: 120, // Reduced size
                      height: 120, // Reduced size
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Register Text with reduced size and padding
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Hello! Register to get\nstarted',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24, // Reduced font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Form fields container with reduced spacing
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Nama Field
                          TextField(
                            controller: _namaController,
                            keyboardType: TextInputType.name,
                            decoration: _buildInputDecoration('Nama'),
                            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          ),

                          // Username Field
                          TextField(
                            controller: _usernameController,
                            keyboardType: TextInputType.text,
                            decoration: _buildInputDecoration('Username'),
                            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          ),

                          // Email Field
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _buildInputDecoration('Email'),
                            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          ),

                          // Password Field
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFEEEEEE),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          ),

                          // No. HP Field
                          TextField(
                            controller: _noHpController,
                            keyboardType: TextInputType.phone,
                            decoration: _buildInputDecoration('No. HP'),
                            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          ),

                          // Sign Up Button
                          SizedBox(
                            width: double.infinity,
                            height: 48, // Reduced height
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to splash screen
                                Navigator.of(context).pushReplacementNamed('/');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB60051),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16, // Reduced font size
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          // Or Sign up With
                          Row(
                            children: const [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Or Sign up With',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12, // Reduced font size
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),

                          // Social Media Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSocialButton('assets/images/icons/facebook.png'),
                              _buildSocialButton('assets/images/icons/google.png'),
                              _buildSocialButton('assets/images/icons/call.png'),
                              _buildSocialButton('assets/images/icons/apple.png'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Already have account
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13, // Reduced font size
                            color: Colors.grey[700],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text(
                            'Sign in here',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13, // Reduced font size
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB60051),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFEEEEEE),
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        color: Colors.grey[500],
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    );
  }

  Widget _buildSocialButton(String iconPath) {
    return Container(
      width: 45, // Reduced size
      height: 45, // Reduced size
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Reduced padding
        child: Image.asset(
          iconPath,
          width: 20, // Reduced size
          height: 20, // Reduced size
        ),
      ),
    );
  }
}