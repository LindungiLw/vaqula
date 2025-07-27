import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voqula/untils/theme_provider.dart';
import 'package:voqula/routes.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Watch the ThemeProvider to react to theme changes
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Initialise SizeConfig here as it might be needed for initial routes
    // Although, calling it in AppCover initState is also fine if only needed after splash.
    // SizeConfig().init(context); // This line is usually not needed here if called in AppCover

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voqula App',
      themeMode: themeProvider.themeMode, // Use themeMode from ThemeProvider
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFA05E1A), // Warna utama aplikasi Anda (coklat keemasan)
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Warna teks utama
          bodyMedium: TextStyle(color: Colors.black87),
          bodySmall: TextStyle(color: Colors.grey[700]), // Warna teks sekunder/hint
        ),
        cardColor: Colors.white, // Warna latar belakang Card
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFFA05E1A), // Warna icon terpilih
          unselectedItemColor: Colors.grey, // Warna icon tidak terpilih
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(color: Colors.black87),
          selectedColor: Color(0xFFA05E1A).withOpacity(0.2), // Warna saat terpilih
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFA05E1A),
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Colors.grey[700]),
          hintStyle: TextStyle(color: Colors.grey[500]),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFA05E1A), width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFFA05E1A), // Warna utama aplikasi Anda
        scaffoldBackgroundColor: Colors.grey[900], // Background gelap
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850],
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Warna teks utama
          bodyMedium: TextStyle(color: Colors.white70),
          bodySmall: TextStyle(color: Colors.grey[400]), // Warna teks sekunder/hint
        ),
        cardColor: Colors.grey[800], // Warna latar belakang Card
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[850],
          selectedItemColor: Color(0xFFA05E1A),
          unselectedItemColor: Colors.grey[600],
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey[700],
          labelStyle: TextStyle(color: Colors.white),
          selectedColor: Color(0xFFA05E1A).withOpacity(0.4), // Warna saat terpilih
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFA05E1A),
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[700],
          labelStyle: TextStyle(color: Colors.grey[400]),
          hintStyle: TextStyle(color: Colors.grey[500]),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFA05E1A), width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
        ),
      ),
      initialRoute: '/cover', // Rute awal Anda
      routes: appRoutes,
    );
  }
}