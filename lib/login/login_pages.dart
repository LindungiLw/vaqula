import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; // Hanya jika Anda menggunakan GoogleFonts secara eksplisit

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = Color(0xFFA05E1A);
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.asset(
                  'assets/images/book_top.jpg', // <<< GANTI DENGAN PATH GAMBAR ASLI ANDA
                  height: 230,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Alshaimaa12@Gmail.Com',
                        labelText: 'Email',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.visibility_off),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Handle Forgot Password
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        // Navigasi ke MainScreen setelah login
                        Navigator.pushReplacementNamed(context, '/main_screen');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        elevation: 4,
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),

                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('Or Log In With', style: TextStyle(color: Colors.black87)),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/facebook.png', height: 30), // <<< GANTI DENGAN PATH ASLI
                        SizedBox(width: 24),
                        Image.asset('assets/icons/google.png', height: 30), // <<< GANTI DENGAN PATH ASLI
                        SizedBox(width: 24),
                        Image.asset('assets/icons/twitter.png', height: 30), // <<< GANTI DENGAN PATH ASLI
                      ],
                    ),

                    SizedBox(height: 20),

                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't Have Any Account? ",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(context, '/signup');
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
}