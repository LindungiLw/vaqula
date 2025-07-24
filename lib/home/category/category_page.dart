import 'package:flutter/material.dart';
import 'book_detail_page.dart'; // Make sure this path is correct

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // Example categories
  final List<String> _categories = [
    'New', 'Fantasy', 'Fiction', 'Horror', 'Romance', 'Sci-Fi', 'Thriller'
  ];

  // Example book data (you would replace this with real data models)
  final List<Map<String, String>> _newBookList = [
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg',
      'title': 'The Silent Patient',
      'author': 'Alex Michaelides',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
      'title': 'We Were Liars',
      'author': 'E. Lockhart',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg',
      'title': 'The Midnights',
      'author': 'Author Name',
    },
  ];

  final List<Map<String, String>> _mostPopularList = [
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
      'title': 'You Be Home',
      'author': 'Author Name',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg',
      'title': 'Wilder Girls',
      'author': 'Author Name',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
      'title': 'This Were',
      'author': 'Author Name',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen (Home)
          },
        ),
        title: const Text(
          'Category',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Here',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Category Chips
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(
                        label: Text(_categories[index]),
                        backgroundColor: index == 0 ? Colors.brown[700] : Colors.grey[200], // Highlight 'New'
                        labelStyle: TextStyle(
                          color: index == 0 ? Colors.white : Colors.black,
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
              _buildSectionHeader('New Book List'),
              const SizedBox(height: 15),
              _buildNewBookList(),
              const SizedBox(height: 20),
              _buildSectionHeader('Most Popular'),
              const SizedBox(height: 15),
              _buildMostPopularList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {
            print('More $title tapped!');
          },
          child: const Row(
            children: [
              Text(
                'More',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewBookList() {
    return SizedBox(
      height: 200, // Adjusted height for these items
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _newBookList.length,
        itemBuilder: (context, index) {
          final book = _newBookList[index];
          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                // Navigate to Book Detail Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookDetailPage(
                      bookTitle: 'The Whispers', // Hardcoded for this example
                      authorName: 'Greg Howard', // Hardcoded for this example
                      imageUrl: 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg', // Hardcoded for this example
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: 120, // Width for each item
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      book['author']!,
                      style: const TextStyle(
                        color: Colors.grey,
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

  Widget _buildMostPopularList() {
    return SizedBox(
      height: 200, // Adjusted height for these items
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _mostPopularList.length,
        itemBuilder: (context, index) {
          final book = _mostPopularList[index];
          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                // Navigate to Book Detail Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookDetailPage(
                      bookTitle: 'The Whispers', // Hardcoded for this example
                      authorName: 'Greg Howard', // Hardcoded for this example
                      imageUrl: 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg', // Hardcoded for this example
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      book['author']!,
                      style: const TextStyle(
                        color: Colors.grey,
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