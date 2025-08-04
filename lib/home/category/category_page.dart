import 'package:flutter/material.dart';
import '../home/book_data.dart';
import '../home/view_all_books_page.dart';
import 'add_book_page.dart';
import 'book_data/horror_books.dart';
import 'book_data/fantasy_books.dart';
import 'book_data/fiction_books.dart';
import 'book_data/new_books.dart';
import 'book_data/romance_books.dart';
import 'book_data/sci_fi_books.dart';
import 'book_data/thriller_books.dart';
import 'book_detail_page.dart'; // Import halaman ViewAllBooksPage


class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // Daftar kategori, sekarang diambil dari file terpisah
  final List<String> _categories = categoriesList;

  // Data buku utama, akan digabungkan dari semua file kategori
  List<Map<String, String>> _allBookList = [];

  // List yang akan ditampilkan setelah difilter oleh kategori atau pencarian
  List<Map<String, String>> _filteredBooksForDisplay = [];

  final TextEditingController _searchController = TextEditingController();
  String _currentSearchQuery = '';
  int _selectedCategoryIndex = 0; // Indeks kategori yang dipilih, default ke 'All' (indeks 0)

  @override
  void initState() {
    super.initState();
    _loadAllBooks(); // Panggil metode untuk memuat dan menggabungkan semua buku
    _searchController.addListener(_onSearchChanged);
    _filterBooks(); // Inisialisasi daftar buku saat pertama kali dimuat
  }

  // Metode untuk memuat dan menggabungkan semua buku dari file-file terpisah
  void _loadAllBooks() {
    _allBookList = []; // Pastikan list kosong sebelum diisi
    _allBookList.addAll(newBooksData);
    _allBookList.addAll(fantasyBooksData);
    _allBookList.addAll(fictionBooksData);
    _allBookList.addAll(horrorBooksData);
    _allBookList.addAll(romanceBooksData);
    _allBookList.addAll(sciFiBooksData);
    _allBookList.addAll(thrillerBooksData);
    // Anda bisa menambahkan logika untuk menghapus duplikasi jika diperlukan
    // Misalnya: _allBookList = _allBookList.toSet().toList(); jika buku memiliki ID unik
  }

  // Metode untuk memperbarui kueri pencarian dan memfilter buku
  void _onSearchChanged() {
    setState(() {
      _currentSearchQuery = _searchController.text;
      _filterBooks(); // Panggil filter setiap kali kueri berubah
    });
  }

  // Metode untuk memfilter daftar buku berdasarkan kategori dan/atau kueri pencarian
  void _filterBooks() {
    List<Map<String, String>> tempBooks = List.from(_allBookList); // Mulai dengan semua buku

    // 1. Filter berdasarkan kategori yang dipilih (jika bukan 'All')
    if (_selectedCategoryIndex > 0) { // Jika bukan 'All' (indeks 0)
      final selectedCategoryName = _categories[_selectedCategoryIndex];
      tempBooks = tempBooks.where((book) =>
      book['category']!.toLowerCase() == selectedCategoryName.toLowerCase()).toList();
    }

    // 2. Filter berdasarkan kueri pencarian (selalu berlaku jika ada)
    if (_currentSearchQuery.isNotEmpty) {
      final query = _currentSearchQuery.toLowerCase();
      tempBooks = tempBooks.where((book) =>
      book['title']!.toLowerCase().contains(query) ||
          book['author']!.toLowerCase().contains(query) ||
          book['category']!.toLowerCase().contains(query) // Mencari juga di kategori
      ).toList();
    }

    setState(() {
      _filteredBooksForDisplay = tempBooks;
    });
  }

  // Callback yang akan dipanggil dari AddBookPage ketika buku baru ditambahkan
  void _onNewBookAdded(Map<String, String> newBook) {
    setState(() {
      _allBookList.add(newBook);
      _filterBooks();
    });
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
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Category',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold // Pastikan bold
          ),
        ),
        centerTitle: true, // Judul AppBar di tengah
        elevation: 0,
      ),
      body: Column( // Menggunakan Column agar bisa menggabungkan berbagai widget
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kolom Input Pencarian
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Here',
                    hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6)),
                    border: OutlineInputBorder( // Menggunakan OutlineInputBorder untuk tampilan yang lebih jelas
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none, // Hapus border default
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor, // Menggunakan warna card untuk background
                    prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color?.withOpacity(0.6)),
                    suffixIcon: _currentSearchQuery.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.cancel, color: Theme.of(context).iconTheme.color?.withOpacity(0.6)),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                        : null, // Tidak ada ikon kamera jika tidak ada kueri
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
                      final category = _categories[index];
                      final isSelected = _selectedCategoryIndex == index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip( // Menggunakan ChoiceChip untuk fungsionalitas pilihan
                          label: Text(category),
                          selected: isSelected,
                          selectedColor: Theme.of(context).chipTheme.selectedColor,
                          backgroundColor: Theme.of(context).chipTheme.backgroundColor,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? (Theme.of(context).chipTheme.selectedColor?.computeLuminance() ?? 0) > 0.5
                                ? Colors.black
                                : Colors.white
                                : Theme.of(context).chipTheme.labelStyle?.color,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedCategoryIndex = index; // Perbarui indeks kategori yang dipilih
                                _searchController.clear(); // Hapus kueri pencarian saat kategori diubah
                                _filterBooks(); // Panggil filter ulang untuk memperbarui tampilan di halaman ini
                              });
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Konten yang ditampilkan berdasarkan kategori yang dipilih atau hasil pencarian
          // Menggunakan Expanded untuk memastikan ListView mengambil sisa ruang yang tersedia
          Expanded(
            child: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini untuk konten utama
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding horizontal
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedCategoryIndex == 0 && _currentSearchQuery.isEmpty)
                  // Tampilkan daftar "New Book List" dan "Most Popular" jika 'All' dipilih dan tidak ada pencarian
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(context, 'New Book List', _allBookList.where((book) => book['category'] == 'New' || book['category'] == 'Thriller' || book['category'] == 'Fiction' || book['category'] == 'Fantasy').toList()),
                        const SizedBox(height: 15),
                        // Filter hardcoded untuk New Book List saat 'All' dipilih
                        _buildHorizontalBookList(
                            context,
                            _allBookList.where((book) => book['category'] == 'New' || book['category'] == 'Thriller' || book['category'] == 'Fiction' || book['category'] == 'Fantasy').take(3).toList(),
                            'new_books'),

                        const SizedBox(height: 20),

                        _buildSectionHeader(context, 'Most Popular', _allBookList.where((book) => book['category'] == 'Romance' || book['category'] == 'Horror' || book['category'] == 'Sci-Fi').toList()),
                        const SizedBox(height: 15),
                        // Filter hardcoded untuk Most Popular saat 'All' dipilih
                        _buildHorizontalBookList(
                            context,
                            _allBookList.where((book) => book['category'] == 'Romance' || book['category'] == 'Horror' || book['category'] == 'Sci-Fi').take(3).toList(),
                            'most_popular'),
                      ],
                    )
                  else
                  // Tampilkan daftar buku yang difilter dalam format vertikal
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'Results for "${_currentSearchQuery.isNotEmpty ? _currentSearchQuery : _categories[_selectedCategoryIndex]}"',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                        _buildVerticalBookList(context, _filteredBooksForDisplay),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Floating Action Button untuk menambah buku baru
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookPage(onBookAdded: _onNewBookAdded),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  // _buildSectionHeader sekarang menerima daftar buku untuk tombol "More"
  Widget _buildSectionHeader(BuildContext context, String title, List<Map<String, String>> allBooksInSection) {
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
            // Navigasi ke ViewAllBooksPage saat tombol "More >" ditekan
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewAllBooksPage(
                  title: title, // Gunakan judul bagian sebagai judul halaman baru
                  books: allBooksInSection, // Teruskan daftar buku lengkap untuk bagian ini
                ),
              ),
            );
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

  // Metode untuk membangun daftar buku horizontal (untuk "New Book List" dan "Most Popular")
  Widget _buildHorizontalBookList(BuildContext context, List<Map<String, String>> bookList, String listType) {
    if (bookList.isEmpty) {
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
      height: 200, // Tinggi tetap untuk daftar horizontal
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
                      authorImageUrl: book['authorImageUrl'], // Teruskan authorImageUrl
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
                      child: Image.asset( // Menggunakan Image.asset
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

  // Metode baru untuk membangun daftar buku vertikal (untuk hasil pencarian/kategori)
  Widget _buildVerticalBookList(BuildContext context, List<Map<String, String>> bookList) {
    if (bookList.isEmpty && _currentSearchQuery.isNotEmpty) {
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

    return ListView.builder(
      shrinkWrap: true, // Penting agar ListView tidak mengambil semua ruang yang tersedia
      physics: const NeverScrollableScrollPhysics(), // Nonaktifkan scroll di dalam ListView agar SingleChildScrollView dapat mengontrol
      itemCount: bookList.length,
      itemBuilder: (context, index) {
        final book = bookList[index];
        return Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.asset( // Menggunakan Image.asset
                book['imageUrl']!,
                width: 50,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 70,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            title: Text(
              book['title']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            subtitle: Text(
              book['author']!,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).iconTheme.color),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(
                    bookTitle: book['title']!,
                    authorName: book['author']!,
                    imageUrl: book['imageUrl']!,
                    authorImageUrl: book['authorImageUrl'], // Teruskan authorImageUrl
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
