// lib/main_screen.dart (create this new file)
import 'package:flutter/material.dart';
import 'package:voqula/home/category/category_page.dart';

import 'main_home.dart'; // Import your category page

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Index for the selected tab

  // List of widgets corresponding to each tab
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CategoryPage(),
    Center(child: Text('Search Content', style: TextStyle(fontSize: 24))), // Placeholder for Search
    Center(child: Text('Profile Content', style: TextStyle(fontSize: 24))), // Placeholder for Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex), // Display the selected page content
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown[700], // Adjust color to match your app's theme
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined), // Represents Category/Library
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}