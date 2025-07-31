import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import GoogleFonts

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
                  'assets/cover/welcoming_cover_app.jpg',
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
                        hintStyle: GoogleFonts.inter(color: Colors.grey[400]), // Applied Google Font
                        labelStyle: GoogleFonts.poppins(color: Colors.black), // Applied Google Font
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
                        labelStyle: GoogleFonts.poppins(color: Colors.black), // Applied Google Font
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
                          style: GoogleFonts.inter(color: Colors.grey[700]), // Applied Google Font
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
                        style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600), // Applied Google Font
                      ),
                    ),

                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('Or Log In With', style: GoogleFonts.inter(color: Colors.black87)), // Applied Google Font
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/cover/google_icon.png', height: 30),
                        SizedBox(width: 24),
                        Image.asset('assets/cover/google_icon.png', height: 30), // <<< GANTI DENGAN PATH ASLI
                        SizedBox(width: 24),
                        Image.asset('assets/cover/google_icon.png', height: 30), // <<< GANTI DENGAN PATH ASLI
                      ],
                    ),

                    SizedBox(height: 20),

                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't Have Any Account? ",
                          style: GoogleFonts.inter(color: Colors.black), // Applied Google Font
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: GoogleFonts.inter( // Applied Google Font
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
