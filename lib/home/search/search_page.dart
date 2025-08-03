import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _currentSearchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Menambahkan listener untuk memperbarui kueri pencarian setiap kali teks berubah
    _searchController.addListener(_onSearchChanged);
  }

  // Metode ini dipanggil setiap kali teks di kolom pencarian berubah
  void _onSearchChanged() {
    setState(() {
      _currentSearchQuery = _searchController.text;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.removeListener(_onSearchChanged); // Hapus listener
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = Color(0xFFA05E1A);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            // Tombol kembali ini akan pop SearchPage dari tumpukan navigasi
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Search Books',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color?.withOpacity(0.6)),
                suffixIcon: _currentSearchQuery.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.cancel, color: Theme.of(context).iconTheme.color?.withOpacity(0.6)),
                  onPressed: () {
                    _searchController.clear(); // Hapus teks pencarian
                  },
                )
                    : Icon(Icons.camera_alt, color: Theme.of(context).iconTheme.color?.withOpacity(0.6)),
              ),
              style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              onSubmitted: (value) {
                // Ini dipanggil ketika pengguna menekan tombol 'Enter' atau 'Search' di keyboard
                print('Search submitted: $value');
                // Anda bisa menambahkan logika pencarian yang lebih kompleks di sini,
                // misalnya memicu pencarian ke API eksternal.
              },
            ),
            const SizedBox(height: 20),

            // Bagian Pencarian Populer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Searches',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('More popular searches tapped!');
                  },
                  child: Text(
                    'More >',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Menggunakan placeholder image URL untuk contoh
                  _buildPopularSearchItem(context, 'Travels', 'https://placehold.co/90x120/E0E0E0/000000?text=Travels'),
                  _buildPopularSearchItem(context, 'Bambi\'s', 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg'),
                  _buildPopularSearchItem(context, 'The Way', 'https://placehold.co/90x120/E0E0E0/000000?text=The+Way'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Bagian Pencarian Terbaru
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Searched',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.grey),
                  onPressed: () {
                    print('Clear recent searches tapped!');
                    // TODO: Implement logika untuk menghapus pencarian terbaru
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                _buildSearchTag(context, 'Novel'),
                _buildSearchTag(context, 'Fantasy'),
                _buildSearchTag(context, 'Crime'),
                _buildSearchTag(context, 'Romantic', isSelected: true),
                _buildSearchTag(context, 'Fiction'),
              ],
            ),
            const SizedBox(height: 20),

            // TabBar untuk Buku dan Penulis
            TabBar(
              controller: _tabController,
              labelColor: mainColor,
              unselectedLabelColor: Theme.of(context).textTheme.bodySmall?.color,
              indicatorColor: mainColor,
              tabs: const [
                Tab(text: 'Books'),
                Tab(text: 'Authors'),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 400, // Anda mungkin perlu menyesuaikan tinggi ini agar konten tidak terpotong
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBooksResults(context), // Hasil buku akan difilter di sini
                  _buildAuthorsResults(context), // Hasil penulis akan difilter di sini
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularSearchItem(BuildContext context, String title, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            // Menggunakan Image.network karena aset lokal tidak dapat diakses langsung oleh model
            child: Image.network(
              imageUrl,
              height: 120,
              width: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 120,
                width: 90,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTag(BuildContext context, String tag, {bool isSelected = false}) {
    final Color mainColor = Color(0xFFA05E1A);
    return ChoiceChip(
      label: Text(tag),
      selected: isSelected,
      selectedColor: mainColor.withOpacity(0.2),
      backgroundColor: Theme.of(context).chipTheme.backgroundColor,
      labelStyle: TextStyle(
        color: isSelected ? mainColor : Theme.of(context).chipTheme.labelStyle?.color,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: isSelected ? BorderSide(color: mainColor) : null,
      onSelected: (selected) {
        print('$tag ${selected ? 'selected' : 'unselected'}');
        // TODO: Implement logika untuk pemilihan tag
      },
    );
  }

  // Metode untuk membangun hasil pencarian buku
  Widget _buildBooksResults(BuildContext context) {
    // Data buku hardcoded untuk contoh
    final List<Map<String, String>> books = [
      {'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg', 'title': 'Romantic Novel 1', 'author': 'Author A'},
      {'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg', 'title': 'Love Story', 'author': 'Author B'},
      {'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg', 'title': 'Fantasy Realm', 'author': 'Author C'},
      {'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg', 'title': 'Crime Thriller', 'author': 'Author D'},
      {'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg', 'title': 'Fiction World', 'author': 'Author E'},
    ];

    // Jika kueri pencarian kosong, tampilkan pesan awal
    if (_currentSearchQuery.isEmpty) {
      return Center(
        child: Text(
          'Mulai ketik untuk mencari buku...',
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
      );
    }

    // Filter buku berdasarkan kueri pencarian
    final filteredBooks = books.where((book) =>
    book['title']!.toLowerCase().contains(_currentSearchQuery.toLowerCase()) ||
        book['author']!.toLowerCase().contains(_currentSearchQuery.toLowerCase())).toList();

    // Jika tidak ada buku yang cocok, tampilkan pesan
    if (filteredBooks.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada buku ditemukan untuk "$_currentSearchQuery".',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
      );
    }

    // Tampilkan daftar buku yang difilter
    return ListView.builder(
      itemCount: filteredBooks.length,
      itemBuilder: (context, index) {
        final book = filteredBooks[index];
        return Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.network(
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
              print('Tapped on book: ${book['title']}');
              // TODO: Navigasi ke halaman detail buku
            },
          ),
        );
      },
    );
  }

  // Metode untuk membangun hasil pencarian penulis
  Widget _buildAuthorsResults(BuildContext context) {
    // Data penulis hardcoded untuk contoh
    final List<Map<String, dynamic>> authors = [
      {'imageUrl': 'https://placehold.co/50x50/E0E0E0/000000?text=Author1', 'name': 'Majji Rallf', 'books': 10, 'followers': 6.3, 'isFollowing': false, 'genre': 'romantic'},
      {'imageUrl': 'https://placehold.co/50x50/E0E0E0/000000?text=Author2', 'name': 'Marvin Edward', 'books': 15, 'followers': 8.3, 'isFollowing': false, 'genre': 'fiction'},
      {'imageUrl': 'https://placehold.co/50x50/E0E0E0/000000?text=Author3', 'name': 'Anne Blac', 'books': 8, 'followers': 4.0, 'isFollowing': true, 'genre': 'romantic'},
      {'imageUrl': 'https://placehold.co/50x50/E0E0E0/000000?text=Author4', 'name': 'Guy Ranvil', 'books': 12, 'followers': 5.0, 'isFollowing': true, 'genre': 'romantic crime'},
      {'imageUrl': 'https://placehold.co/50x50/E0E0E0/000000?text=Author5', 'name': 'Elena Mask', 'books': 7, 'followers': 3.5, 'isFollowing': false, 'genre': 'romantic fiction'},
      {'imageUrl': 'https://placehold.co/50x50/E0E0E0/000000?text=Author6', 'name': 'Brolklin Tarekk', 'books': 20, 'followers': 10.0, 'isFollowing': true, 'genre': 'romantic novel'},
      {'imageUrl': 'https://placehold.co/50x50/E0E0E0/000000?text=Author7', 'name': 'Annete Annte', 'books': 11, 'followers': 4.2, 'isFollowing': false, 'genre': 'romantic'},
      {'imageUrl': 'https://placehold.co/50x50/E0E0E0/000000?text=Author8', 'name': 'Rafy Simmonos', 'books': 9, 'followers': 3.8, 'isFollowing': true, 'genre': 'fantasy'},
    ];

    // Jika kueri pencarian kosong, tampilkan pesan awal
    if (_currentSearchQuery.isEmpty) {
      return Center(
        child: Text(
          'Mulai ketik untuk mencari penulis...',
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
      );
    }

    // Filter penulis berdasarkan kueri pencarian
    final filteredAuthors = authors.where((author) =>
    author['name'].toLowerCase().contains(_currentSearchQuery.toLowerCase()) ||
        author['genre'].toLowerCase().contains(_currentSearchQuery.toLowerCase())).toList();

    // Jika tidak ada penulis yang cocok, tampilkan pesan
    if (filteredAuthors.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada penulis ditemukan untuk "$_currentSearchQuery".',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
      );
    }

    // Tampilkan daftar penulis yang difilter
    return ListView.builder(
      itemCount: filteredAuthors.length,
      itemBuilder: (context, index) {
        final author = filteredAuthors[index];
        return Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(author['imageUrl']!),
              onBackgroundImageError: (exception, stackTrace) => const Icon(Icons.person, color: Colors.grey),
            ),
            title: Text(
              author['name']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${author['genre']}',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${author['books']} books | ${author['followers']}k followers',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                print('${author['name']} follow/unfollow tapped!');
                // TODO: Implement logika follow/unfollow
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: author['isFollowing'] ? Colors.grey : Color(0xFFA05E1A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              ),
              child: Text(author['isFollowing'] ? 'Following' : 'Follow'),
            ),
            onTap: () {
              print('Tapped on author: ${author['name']}');
              // TODO: Navigasi ke halaman detail penulis
            },
          ),
        );
      },
    );
  }
}
