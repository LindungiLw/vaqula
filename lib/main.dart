import 'package:flutter/material.dart';
import 'package:voqula/routes.dart';
import 'package:voqula/untils/theme_toggle_page.dart';
 import 'package:voqula/home/main_screen.dart';// <<< PASTIKAN INI DIIMPORT

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // 🔁 Toggle status

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Poppins'),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // Dark mode app bar
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.brown[400],
          unselectedItemColor: Colors.grey[700],
        ),
        cardColor: Colors.grey[900], // For cards like review items
        chipTheme: ChipThemeData(
          backgroundColor: Colors.brown[800],
          labelStyle: const TextStyle(color: Colors.white),
          selectedColor: Colors.brown[400],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[400],
            foregroundColor: Colors.white,
          ),
        ),
        // Add more theme adjustments for dark mode
      )
          : ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Poppins'),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
        ),
        cardColor: Colors.white,
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey[200],
          labelStyle: const TextStyle(color: Colors.black),
          selectedColor: Colors.brown[700],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[700],
            foregroundColor: Colors.white,
          ),
        ),
        // Add more theme adjustments for light mode
      ),
      routes: {
        ...appRoutes,
        '/toggle-theme': (context) => ThemeTogglePage(toggleTheme: _toggleTheme),
      },
      initialRoute: '/cover', // <<< INI YANG HARUS DIUBAH!
    );
  }
}