import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // <<< Hapus atau komen baris ini
// import 'package:google_sign_in/google_sign_in.dart'; // <<< Hapus atau komen baris ini

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // <<< Hapus atau komen semua kode Firebase/GoogleSignIn di sini
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future<void> _signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //
  //     if (googleUser == null) {
  //       // The user canceled the sign-in
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Login Google dibatalkan.')),
  //         );
  //       }
  //       return;
  //     }
  //
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     // Sign in to Firebase with the Google credential
  //     final UserCredential userCredential = await _auth.signInWithCredential(credential);
  //     final User? user = userCredential.user;
  //
  //     if (user != null) {
  //       print('Signed in with Google: ${user.displayName}');
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Berhasil login dengan Google sebagai ${user.displayName}!')),
  //         );
  //         // Navigate to main screen upon successful login
  //         Navigator.pushReplacementNamed(context, '/main_screen');
  //       }
  //     } else {
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Gagal mendapatkan informasi pengguna dari Google.')),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     print('Error signing in with Google: $e');
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Gagal login dengan Google: $e')),
  //       );
  //     }
  //   }
  // }
  // <<< Akhir dari kode Firebase/GoogleSignIn yang dihapus/dikomen


  @override
  Widget build(BuildContext context) {
    final Color mainColor = Color(0xFFA05E1A); // Warna utama aplikasi Anda

    return Scaffold(
      backgroundColor: mainColor, // Background color dari Scaffold
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Bagian atas dengan gambar buku
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.asset(
                  'assets/cover/welcoming_cover_app.jpg', // <<< Pastikan path ini benar
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

              // Container utama form
              Container(
                // Menggunakan warna dari tema untuk latar belakang container form
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Field Nama Lengkap
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        labelStyle: TextStyle(color: Colors.black87),
                      ),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    SizedBox(height: 16),
                    // Field Email
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        labelStyle: TextStyle(color: Colors.black87),
                      ),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    SizedBox(height: 16),
                    // Field Password
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.visibility_off, color: Colors.grey.shade600),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        labelStyle: TextStyle(color: Colors.black87),
                      ),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    SizedBox(height: 16),
                    // Field Konfirmasi Password
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Password',
                        suffixIcon: Icon(Icons.visibility_off, color: Colors.grey.shade600),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        labelStyle: TextStyle(color: Colors.black87),
                      ),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    SizedBox(height: 24),

                    // Tombol Sign Up
                    ElevatedButton(
                      onPressed: () {
                        // Navigasi ke MainScreen setelah signup berhasil
                        Navigator.pushReplacementNamed(context, '/main_screen');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor, // Menggunakan warna utama aplikasi
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        elevation: 4,
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),

                    SizedBox(height: 16),
                    // Divider dengan teks "Atau daftar dengan"
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.black38)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Atau daftar dengan',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.black38)),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Bagian ikon media sosial
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialIcon(
                          context,
                          'assets/cover/google_icon.png', // <<< PASTIKAN PATH INI BENAR
                          30,
                              () {
                            // Ini hanya akan mencetak pesan ke konsol saat ikon Google diklik
                            print('Login with Google tapped!');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Fungsionalitas Google Login dinonaktifkan sementara.')),
                            );
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Teks "Sudah punya akun?"
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Sudah punya akun? ",
                          style: TextStyle(color: Colors.black87),
                          children: [
                            TextSpan(
                              text: 'Masuk',
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(context, '/login');
                                },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Helper method untuk ikon sosial
  Widget _buildSocialIcon(BuildContext context, String assetPath, double size, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        assetPath,
        height: size,
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red),
          ),
          child: Icon(Icons.error, color: Colors.red, size: size * 0.7),
        ),
      ),
    );
  }
}