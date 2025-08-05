import 'package:flutter/material.dart';

class AboutBookTab extends StatelessWidget {
  const AboutBookTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionHeader(context, 'You May Like This'),
          const SizedBox(height: 15),
          _buildYouMayLikeList(context),
        ],
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

  Widget _buildYouMayLikeList(BuildContext context) {
    final List<Map<String, String>> youMayLikeBooks = [
      {
        'imageUrl': 'assets/books/popular_books/the_loneliest.jpg',
        'title': 'The Loneliest Girl in the Universe',
        'price': '75.000',
      },
      {
        'imageUrl': 'assets/books/popular_books/the_kingdom.jpg',
        'title': 'The Bridge Kingdom',
        'price': '120.000',
      },
      {
        'imageUrl': 'assets/books/popular_books/flutter_books.jpg',
        'title': 'The Story of Four Sisters and an Incredible Journey',
        'price': '300.000',
      },
    ];

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: youMayLikeBooks.length,
        itemBuilder: (context, index) {
          final book = youMayLikeBooks[index];
          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: _RecommendationItem(
              imageUrl: book['imageUrl']!,
              title: book['title']!,
              price: book['price']!,
              textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
              secondaryTextColor: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
            ),
          );
        },
      ),
    );
  }
}

class _RecommendationItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final Color textColor;
  final Color secondaryTextColor;

  const _RecommendationItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.textColor,
    required this.secondaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              height: 180,
              width: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                width: 150,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            price,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}