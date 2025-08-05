import 'package:flutter/material.dart';
import 'package:voqula/home/category/book_detail_page.dart';
import 'package:voqula/home/home/view_all_books_page.dart';
import 'package:voqula/home/search/author_detail_page.dart';
import 'book_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> _bestSellingBooks = bestSellingBooks;
  final List<Map<String, String>> _mostPopularBooks = mostPopularBooks;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildSectionHeader(context, 'Best Selling Books'),
                            const SizedBox(height: 15),
                            _buildBookList(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            _buildSectionHeader(context, 'Most Popular'),
                            const SizedBox(height: 15),
                            _buildMostPopularList(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSectionHeader(context, 'Best Selling Books'),
                  const SizedBox(height: 15),
                  _buildBookList(context),
                  const SizedBox(height: 20),
                  _buildSectionHeader(context, 'Most Popular'),
                  const SizedBox(height: 15),
                  _buildMostPopularList(context),
                ],
              ),
            ),
          );
        }
      },
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
            if (title == 'Best Selling Books') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewAllBooksPage(
                    title: 'Best Selling Books',
                    books: _bestSellingBooks,
                  ),
                ),
              );
            } else if (title == 'Most Popular') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewAllBooksPage(
                    title: 'Most Popular Books',
                    books: _mostPopularBooks,
                  ),
                ),
              );
            }
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

  Widget _buildBookList(BuildContext context) {
    return SizedBox(
      height: 250,
      child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth / 2.5).clamp(120.0, 180.0);
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _bestSellingBooks.length,
              itemBuilder: (context, index) {
                final book = _bestSellingBooks[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SizedBox(
                    width: itemWidth,
                    child: _BookItem(
                      imageUrl: book['imageUrl']!,
                      title: book['title']!,
                      author: book['author']!,
                      authorImageUrl: book['authorImageUrl'] ?? 'assets/authors/author_placeholder.jpg',
                      price: book['price'] ?? 'N/A',
                      textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                      secondaryTextColor: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
                      onTap: () {
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
                      },
                      onAuthorTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthorDetailPage(
                              authorName: book['author']!,
                              imageUrl: book['authorImageUrl'] ?? 'assets/authors/author_placeholder.jpg',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
      ),
    );
  }

  Widget _buildMostPopularList(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _mostPopularBooks.length,
        itemBuilder: (context, index) {
          final popularBook = _mostPopularBooks[index];
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: _MostPopularItem(
              imageUrl: popularBook['imageUrl']!,
              title: popularBook['title']!,
              textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(
                      bookTitle: popularBook['title']!,
                      authorName: popularBook['author'] ?? 'Various Authors',
                      imageUrl: popularBook['imageUrl']!,
                      authorImageUrl: popularBook['authorImageUrl'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _BookItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String authorImageUrl;
  final String price;
  final Color textColor;
  final Color secondaryTextColor;
  final VoidCallback onTap;
  final VoidCallback onAuthorTap;

  const _BookItem({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.authorImageUrl,
    required this.price,
    required this.textColor,
    required this.secondaryTextColor,
    required this.onTap,
    required this.onAuthorTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
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

            GestureDetector(
              onTap: onAuthorTap,
              child: Text(
                author,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
      ),
    );
  }
}

class _MostPopularItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Color textColor;
  final VoidCallback onTap;

  const _MostPopularItem({
    required this.imageUrl,
    required this.title,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageUrl,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 150,
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
          ],
        ),
      ),
    );
  }
}
