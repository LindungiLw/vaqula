import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voqula/home/home/view_all_books_page.dart';
import 'package:voqula/services/database_service.dart';
import './book_data.dart';
import 'add_book_page.dart';
import 'book_detail_page.dart';
import 'book_data/horror_books.dart';
import 'book_data/fantasy_books.dart';
import 'book_data/fiction_books.dart';
import 'book_data/new_books.dart';
import 'book_data/romance_books.dart';
import 'book_data/sci_fi_books.dart';
import 'book_data/thriller_books.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final DatabaseService _dbService = DatabaseService();
  final List<String> _categories = categoriesList;
  final TextEditingController _searchController = TextEditingController();

  String _currentSearchQuery = '';
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _currentSearchQuery = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _combineBooks(List<QueryDocumentSnapshot> firebaseDocs) {
    List<Map<String, String>> combinedList = [];

    for (var doc in firebaseDocs) {
      var data = doc.data() as Map<String, dynamic>;
      combinedList.add({
        'title': data['title'] ?? 'No Title',
        'author': data['author'] ?? 'Unknown',
        'imageUrl': data['imageUrl'] ?? '',
        'category': data['category'] ?? 'New',
        'authorImageUrl': 'assets/authors/author_placeholder.jpg',
      });
    }

    combinedList.addAll(newBooksData);
    combinedList.addAll(fantasyBooksData);
    combinedList.addAll(fictionBooksData);
    combinedList.addAll(horrorBooksData);
    combinedList.addAll(romanceBooksData);
    combinedList.addAll(sciFiBooksData);
    combinedList.addAll(thrillerBooksData);

    return combinedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Category',
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _dbService.getBooksStream(),
        builder: (context, snapshot) {

          final firebaseDocs = snapshot.hasData ? snapshot.data!.docs : <QueryDocumentSnapshot>[];
          final allBooks = _combineBooks(firebaseDocs);

          List<Map<String, String>> filteredBooks = List.from(allBooks);

          if (_selectedCategoryIndex > 0) {
            final selectedCategory = _categories[_selectedCategoryIndex];
            filteredBooks = filteredBooks.where((book) =>
            book['category']!.toLowerCase() == selectedCategory.toLowerCase()
            ).toList();
          }

          if (_currentSearchQuery.isNotEmpty) {
            final query = _currentSearchQuery.toLowerCase();
            filteredBooks = filteredBooks.where((book) =>
            book['title']!.toLowerCase().contains(query) ||
                book['author']!.toLowerCase().contains(query)
            ).toList();
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Here',
                        hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color?.withOpacity(0.6)),
                        suffixIcon: _currentSearchQuery.isNotEmpty
                            ? IconButton(
                          icon: Icon(Icons.cancel, color: Theme.of(context).iconTheme.color),
                          onPressed: () => _searchController.clear(),
                        )
                            : null,
                      ),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedCategoryIndex == index;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(_categories[index]),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (selected) setState(() => _selectedCategoryIndex = index);
                              },
                              selectedColor: Theme.of(context).chipTheme.selectedColor,
                              backgroundColor: Theme.of(context).chipTheme.backgroundColor,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Theme.of(context).chipTheme.labelStyle?.color,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      if (_selectedCategoryIndex == 0 && _currentSearchQuery.isEmpty) ...[
                        _buildSection(context, 'New Book List', allBooks.where((b) => ['New','Thriller','Fiction','Fantasy'].contains(b['category'])).toList()),
                        const SizedBox(height: 20),
                        _buildSection(context, 'Most Popular', allBooks.where((b) => ['Romance','Horror','Sci-Fi'].contains(b['category'])).toList()),
                      ]
                      else ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Results (${filteredBooks.length})',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
                            ),
                          ),
                        ),
                        _buildVerticalBookList(context, filteredBooks),
                      ]
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookPage()),
          );
        },
        backgroundColor: const Color(0xFFb8792b),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Map<String, String>> books) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllBooksPage(title: title, books: books))),
              child: const Text('More'),
            ),
          ],
        ),
        _buildHorizontalBookList(context, books.take(5).toList()),
      ],
    );
  }

  Widget _buildHorizontalBookList(BuildContext context, List<Map<String, String>> books) {
    if (books.isEmpty) return const SizedBox(height: 50, child: Center(child: Text("No books available")));

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () => _navigateToDetail(book),
              child: SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: _buildBookImage(book['imageUrl']!),
                    ),
                    const SizedBox(height: 8),
                    Text(book['title']!, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).textTheme.bodyLarge?.color)),
                    Text(book['author']!, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 12)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalBookList(BuildContext context, List<Map<String, String>> books) {
    if (books.isEmpty) return const Padding(padding: EdgeInsets.all(20), child: Text("No books found"));

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: SizedBox(
                width: 50, height: 70,
                child: _buildBookImage(book['imageUrl']!),
              ),
            ),
            title: Text(book['title']!, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
            subtitle: Text(book['author']!, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).iconTheme.color),
            onTap: () => _navigateToDetail(book),
          ),
        );
      },
    );
  }

  Widget _buildBookImage(String url) {
    if (url.startsWith('http') || url.startsWith('https')) {
      return Image.network(
        url, height: 150, width: 120, fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(height: 150, width: 120, color: Colors.grey[300], child: const Icon(Icons.broken_image)),
      );
    } else {
      return Image.asset(
        url, height: 150, width: 120, fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(height: 150, width: 120, color: Colors.grey[300], child: const Icon(Icons.broken_image)),
      );
    }
  }

  void _navigateToDetail(Map<String, String> book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(
          bookTitle: book['title']!,
          authorName: book['author']!,
          imageUrl: book['imageUrl']!,
          authorImageUrl: book['authorImageUrl'],
        ),
      ),
    );
  }
}