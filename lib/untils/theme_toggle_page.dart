import 'package:flutter/material.dart';

class ThemeTogglePage extends StatelessWidget {
  final VoidCallback toggleTheme;

  const ThemeTogglePage({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toggle Theme'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: toggleTheme,
          )
        ],
      ),
      body: Center(
        child: Text(
          'Tekan icon di atas untuk ganti mode terang/gelap',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
