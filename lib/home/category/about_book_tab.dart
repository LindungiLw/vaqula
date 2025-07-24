import 'package:flutter/material.dart';

class AboutBookTab extends StatelessWidget {
  final String bookDescription;

  AboutBookTab({
    Key? key,
    required this.bookDescription,
  }) : super(key: key);

  // Example "You May Like This" books
  final List<Map<String, String>> _youMayLikeThis = [
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg',
      'title': 'The Bridge Home',
      'price': '\$80.00',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
      'title': 'Book Title 2',
      'price': '\$50.00',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg',
      'title': 'Book Title 3',
      'price': '\$60.00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0), // Adjust vertical padding to avoid double padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10), // Space from the tab bar
          Text(
            bookDescription,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('You May Like This'),
          const SizedBox(height: 15),
          _buildYouMayLikeThisList(),
          const SizedBox(height: 20),
        ],
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

  Widget _buildYouMayLikeThisList() {
    return SizedBox(
      height: 200, // Height for the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _youMayLikeThis.length,
        itemBuilder: (context, index) {
          final item = _youMayLikeThis[index];
          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: SizedBox(
              width: 120, // Width for each item
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      item['imageUrl']!,
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
                    item['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item['price']!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}