import 'package:flutter/material.dart';
import 'package:voqula/home/search/author_detail_page.dart';
import 'category/book_detail_page.dart'; // Import

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
                      IconButton(
                        icon: Icon(Icons.sort, color: Theme.of(context).iconTheme.color),
                        onPressed: () {
                          // Handle sort/filter action
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
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
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
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

  Widget _buildBookList(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _BookItem(
            imageUrl: 'assets/images/the_book_thief.jpg', // <<< Ganti dengan path asli
            title: 'The Book Thief',
            author: 'Corinne Sweet',
            authorImageUrl: 'https://via.placeholder.com/150', // Dummy author image
            price: '\$56.00',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            secondaryTextColor: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(
                    bookTitle: 'The Book Thief',
                    authorName: 'Corinne Sweet',
                    imageUrl: 'assets/images/the_book_thief.jpg',
                  ),
                ),
              );
            },
            onAuthorTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthorDetailPage(
                    authorName: 'Corinne Sweet',
                    imageUrl: 'https://via.placeholder.com/150', // Dummy author image
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 15),
          _BookItem(
            imageUrl: 'assets/images/the_whispers.jpg', // <<< Ganti dengan path asli
            title: 'The Whispers',
            author: 'Greg Howard',
            authorImageUrl: 'https://via.placeholder.com/150', // Dummy author image
            price: '\$33',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            secondaryTextColor: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(
                    bookTitle: 'The Whispers',
                    authorName: 'Greg Howard',
                    imageUrl: 'assets/images/the_whispers.jpg',
                  ),
                ),
              );
            },
            onAuthorTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthorDetailPage(
                    authorName: 'Greg Howard',
                    imageUrl: 'https://via.placeholder.com/150', // Dummy author image
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 15),
          _BookItem(
            imageUrl: 'assets/images/weird_girl.jpg', // <<< Ganti dengan path asli
            title: 'Weird Girl',
            author: 'Corinne Sweet',
            authorImageUrl: 'https://via.placeholder.com/150', // Dummy author image
            price: '\$44.00',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            secondaryTextColor: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(
                    bookTitle: 'Weird Girl',
                    authorName: 'Corinne Sweet',
                    imageUrl: 'assets/images/weird_girl.jpg',
                  ),
                ),
              );
            },
            onAuthorTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthorDetailPage(
                    authorName: 'Corinne Sweet',
                    imageUrl: 'https://via.placeholder.com/150', // Dummy author image
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget _buildMostPopularList(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _MostPopularItem(
            imageUrl: 'assets/images/mindfulness_journal.jpg', // <<< Ganti dengan path asli
            title: 'Mindfulness Journal',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(
                    bookTitle: 'Mindfulness Journal',
                    authorName: 'Various Authors', // Dummy author
                    imageUrl: 'assets/images/mindfulness_journal.jpg',
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 15),
          _MostPopularItem(
            imageUrl: 'assets/images/star_girl.jpg', // <<< Ganti dengan path asli
            title: 'Star Girl',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(
                    bookTitle: 'Star Girl',
                    authorName: 'Various Authors', // Dummy author
                    imageUrl: 'assets/images/star_girl.jpg',
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 15),
          _MostPopularItem(
            imageUrl: 'assets/images/book_ma.jpg', // <<< Ganti dengan path asli
            title: 'Book Ma...',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(
                    bookTitle: 'Book Ma...',
                    authorName: 'Various Authors', // Dummy author
                    imageUrl: 'assets/images/book_ma.jpg',
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }
}

class _BookItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String authorImageUrl; // Tambahkan ini
  final String price;
  final Color textColor;
  final Color secondaryTextColor;
  final VoidCallback onTap;
  final VoidCallback onAuthorTap; // Tambahkan ini

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
              child: Image.asset( // Menggunakan Image.asset karena path lokal
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
            GestureDetector( // Wrap author name in GestureDetector
              onTap: onAuthorTap,
              child: Text(
                author,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14,
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
              child: Image.asset( // Menggunakan Image.asset
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