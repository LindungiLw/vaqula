import 'package:flutter/material.dart';
import 'book_detail_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<String> _categories = [
    'New', 'Fantasy', 'Fiction', 'Horror', 'Romance', 'Sci-Fi', 'Thriller'
  ];

  // Data buku hardcoded
  final List<Map<String, String>> _allBookList = [
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg',
      'title': 'The Silent Patient',
      'author': 'Alex Michaelides',
      'category': 'Thriller',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
      'title': 'We Were Liars',
      'author': 'E. Lockhart',
      'category': 'Fiction',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg',
      'title': 'The Midnights',
      'author': 'Author Name',
      'category': 'Fantasy',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
      'title': 'You Be Home',
      'author': 'Author Name',
      'category': 'Romance',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg',
      'title': 'Wilder Girls',
      'author': 'Author Name',
      'category': 'Horror',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
      'title': 'This Were',
      'author': 'Author Name',
      'category': 'Sci-Fi',
    },
    // Tambahkan lebih banyak buku di sini jika diperlukan untuk pengujian pencarian
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg',
      'title': 'Mystic Forest',
      'author': 'Jane Doe',
      'category': 'Fantasy',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
      'title': 'The Last Stand',
      'author': 'John Smith',
      'category': 'Sci-Fi',
    },
  ];

  // List yang akan ditampilkan setelah difilter
  List<Map<String, String>> _filteredNewBookList = [];
  List<Map<String, String>> _filteredMostPopularList = [];

  final TextEditingController _searchController = TextEditingController();
  String _currentSearchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _filterBooks(); // Inisialisasi daftar buku saat pertama kali dimuat
  }

  // Metode untuk memperbarui kueri pencarian dan memfilter buku
  void _onSearchChanged() {
    setState(() {
      _currentSearchQuery = _searchController.text;
      _filterBooks(); // Panggil filter setiap kali kueri berubah
    });
  }

  // Metode untuk memfilter daftar buku
  void _filterBooks() {
    if (_currentSearchQuery.isEmpty) {
      // Jika kueri kosong, tampilkan semua buku (atau subset yang relevan)
      _filteredNewBookList = _allBookList.where((book) => book['category'] == 'Thriller' || book['category'] == 'Fiction' || book['category'] == 'Fantasy').take(3).toList();
      _filteredMostPopularList = _allBookList.where((book) => book['category'] == 'Romance' || book['category'] == 'Horror' || book['category'] == 'Sci-Fi').take(3).toList();
    } else {
      // Filter berdasarkan kueri pencarian di judul atau penulis
      final query = _currentSearchQuery.toLowerCase();
      _filteredNewBookList = _allBookList.where((book) =>
      book['title']!.toLowerCase().contains(query) ||
          book['author']!.toLowerCase().contains(query) ||
          book['category']!.toLowerCase().contains(query) // Bisa juga mencari berdasarkan kategori
      ).toList();
      // Untuk Most Popular, kita bisa menggunakan hasil filter yang sama atau logika berbeda
      _filteredMostPopularList = _filteredNewBookList; // Untuk demo, gunakan hasil yang sama
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Category',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Here',
                  hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color?.withOpacity(0.6)),
                  suffixIcon: _currentSearchQuery.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.cancel, color: Theme.of(context).iconTheme.color?.withOpacity(0.6)),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                      : null,
                ),
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                onSubmitted: (value) {
                  print('Search submitted: $value');
                },
              ),
              const SizedBox(height: 20),

              // Daftar Kategori (Chips)
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    // Logika pemilihan chip bisa ditambahkan di sini jika diperlukan
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(
                        label: Text(_categories[index]),
                        backgroundColor: index == 0 ? Theme.of(context).chipTheme.selectedColor : Theme.of(context).chipTheme.backgroundColor,
                        labelStyle: TextStyle(
                          color: index == 0 ? (Theme.of(context).chipTheme.selectedColor?.computeLuminance() ?? 0) > 0.5 ? Colors.black : Colors.white : Theme.of(context).chipTheme.labelStyle?.color,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Bagian "New Book List"
              _buildSectionHeader(context, 'New Book List'),
              const SizedBox(height: 15),
              _buildBookList(context, _filteredNewBookList, 'new_books'), // Menggunakan daftar yang difilter

              const SizedBox(height: 20),

              // Bagian "Most Popular"
              _buildSectionHeader(context, 'Most Popular'),
              const SizedBox(height: 15),
              _buildBookList(context, _filteredMostPopularList, 'most_popular'), // Menggunakan daftar yang difilter
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        TextButton(
          onPressed: () {
            print('More $title tapped!');
            // TODO: Tambahkan navigasi ke halaman "More" jika ada
          },
          child: Row(
            children: [
              Text(
                'More',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).textTheme.bodySmall?.color,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Metode umum untuk membangun daftar buku (digunakan untuk New dan Most Popular)
  Widget _buildBookList(BuildContext context, List<Map<String, String>> bookList, String listType) {
    if (_currentSearchQuery.isNotEmpty && bookList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            'Tidak ada buku ditemukan untuk "$_currentSearchQuery" di kategori ini.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
          ),
        ),
      );
    } else if (bookList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            'Tidak ada buku di daftar ini.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
          ),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bookList.length,
        itemBuilder: (context, index) {
          final book = bookList[index];
          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(
                      bookTitle: book['title']!,
                      authorName: book['author']!,
                      imageUrl: book['imageUrl']!,
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        book['imageUrl']!,
                        height: 150,
                        width: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 150,
                          width: 120,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book['title']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      book['author']!,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
