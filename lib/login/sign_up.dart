import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../services/auth_services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // Hapus inisialisasi langsung FirebaseAuth dan GoogleSignIn di sini
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  late final AuthService _authService; // Deklarasikan AuthService

  @override
  void initState() {
    super.initState();
    // Inisialisasi AuthService, lewati callback SnackBar
    _authService = AuthService(_showSnackBar);
    // Hapus _initializeFirebase() di sini, karena sebaiknya di main.dart
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  Future<void> _signUpWithEmailPassword() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar('Password dan Konfirmasi Password tidak cocok.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Panggil metode dari AuthService
    final user = await _authService.signUpWithEmailPassword(
      email: _emailController.text,
      password: _passwordController.text,
      displayName: _nameController.text,
    );

    if (user != null) {
      // Navigasi setelah pendaftaran berhasil
      Navigator.pushReplacementNamed(context, '/main_screen');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    // Panggil metode dari AuthService
    final user = await _authService.signInWithGoogle();

    if (user != null) {
      // Navigasi setelah login Google berhasil
      Navigator.pushReplacementNamed(context, '/main_screen');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color(0xFFA05E1A);

    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        // Use Stack to layer the image and the form content
        child: Stack(
          children: [
            // Background image (fills the top portion)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.asset(
                  'assets/cover/welcoming_cover_app.jpg',
                  height: 230,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 230,
                    width: double.infinity,
                    color: Colors.grey,
                    child: const Icon(Icons.error_outline, color: Colors.white, size: 50),
                  ),
                ),
              ),
            ),

            // Form content (positioned to overlap the image)
            Positioned.fill( // Fills the available space, allowing scrolling
              top: 230 - 25, // Image height (230) - overlap amount (25)
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                  // Removed 'margin' property here, it's now handled by Positioned.fill's 'top'
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          'Buat Akun Baru',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      _buildTextField(
                        controller: _nameController,
                        labelText: 'Nama Lengkap',
                        icon: Icons.person_outline,
                        context: context,
                      ),
                      const SizedBox(height: 16),

                      _buildTextField(
                        controller: _emailController,
                        labelText: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        context: context,
                      ),
                      const SizedBox(height: 16),

                      _buildPasswordTextField(
                        controller: _passwordController,
                        labelText: 'Password',
                        obscureText: _obscurePassword,
                        onToggleVisibility: _togglePasswordVisibility,
                        context: context,
                      ),
                      const SizedBox(height: 16),

                      _buildPasswordTextField(
                        controller: _confirmPasswordController,
                        labelText: 'Konfirmasi Password',
                        obscureText: _obscureConfirmPassword,
                        onToggleVisibility: _toggleConfirmPasswordVisibility,
                        context: context,
                      ),
                      const SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: _isLoading ? null : _signUpWithEmailPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 4,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Expanded(child: Divider(color: Colors.black38)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Atau daftar dengan',
                              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                            ),
                          ),
                          const Expanded(child: Divider(color: Colors.black38)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialIcon(
                            context,
                            'assets/icons/google_icon.png',
                            40,
                            _isLoading ? () {} : _signInWithGoogle,
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Sudah punya akun? ",
                            style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                            children: [
                              TextSpan(
                                text: 'Masuk',
                                style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (!_isLoading) {
                                      Navigator.pushReplacementNamed(context, '/login');
                                    }
                                  },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required BuildContext context,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey.shade600),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: const TextStyle(color: Colors.black87),
      ),
      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
    );
  }

  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required String labelText,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required BuildContext context,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade600),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey.shade600,
          ),
          onPressed: onToggleVisibility,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: const TextStyle(color: Colors.black87),
      ),
      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
    );
  }

  Widget _buildSocialIcon(BuildContext context, String assetPath, double size, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
        ),
        child: Image.asset(
          assetPath,
          height: size,
          width: size,
          errorBuilder: (context, error, stackTrace) => Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              border: Border.all(color: Colors.red),
            ),
            child: Icon(Icons.broken_image, color: Colors.red, size: size * 0.7),
          ),
        ),
      ),
    );
  }
}
