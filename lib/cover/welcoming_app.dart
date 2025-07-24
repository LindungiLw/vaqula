import 'package:flutter/material.dart';

class WelcomingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/cover/welcoming_cover_app.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay to improve text readability
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Quote
                  Text(
                    'Reading Is A Conversation\nAll Books Talk , But A Good\nBook Listens As Well',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 80),

                  // Start Reading Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup'); // ganti '/home' dengan rute tujuanmu
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFb8792b), // Warna seperti di gambar
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                    ),
                    child: Text(
                      'start reading',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
