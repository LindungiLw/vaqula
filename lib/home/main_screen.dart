import 'package:flutter/material.dart';
import 'package:voqula/home/search/notification_page.dart';
import 'package:voqula/home/profil/profile_page.dart';
import 'package:voqula/home/category/category_page.dart';
import 'package:voqula/home/home/home.dart';
import 'package:voqula/home/search/search_page.dart'; // Import SearchPage untuk navigasi

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Daftar widget yang diperbarui untuk BottomNavigationBar (hanya 3 tab)
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CategoryPage(),
    ProfilePage(), // ProfilePage sekarang di indeks 2
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? currentAppBar;
    if (_selectedIndex == 0) { // AppBar untuk HomePage
      currentAppBar = PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Deal',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.sort, color: Theme.of(context).iconTheme.color),
                            onPressed: () {
                              print('Sort tapped!');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.notifications_none, color: Theme.of(context).iconTheme.color),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NotificationPage()),
                              );
                            },
                          ),
                          // Tidak perlu ikon pencarian terpisah di sini,
                          // karena TextField di bawah akan menangani navigasi ke SearchPage
                        ],
                      ),
                    ],
                  ),

                  // GestureDetector agar TextField dapat diketuk untuk membuka SearchPage
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SearchPage()),
                      );
                    },
                    child: AbsorbPointer( // Mencegah TextField langsung diedit di sini
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search Here',
                            hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6)),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color?.withOpacity(0.6)),
                            suffixIcon: Icon(Icons.camera_alt, color: Theme.of(context).iconTheme.color?.withOpacity(0.6)),
                          ),
                          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: currentAppBar,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Category',
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
