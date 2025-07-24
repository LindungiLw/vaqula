// lib/home/main_home.dart (Pastikan TIDAK ADA bottomNavigationBar di sini)
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold ini hanya untuk AppBar dan Body
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
                        onPressed: () {},
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
      // >>> TIDAK ADA bottomNavigationBar DI SINI! <<<
    );
  }

  // Your helper methods like _buildSectionHeader, _buildBookList, _buildMostPopularList
  // and StatelessWidget _BookItem, _MostPopularItem should be defined here,
  // passing context and using Theme.of(context) for colors as I showed previously.
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
            imageUrl: 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg',
            title: 'The Book Thief',
            author: 'Corinne Sweet',
            price: '\$56.00',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            secondaryTextColor: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
          ),
          _BookItem(
            imageUrl: 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
            title: 'the whispers',
            author: 'Greg Howard',
            price: '\$33',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            secondaryTextColor: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
          ),
          _BookItem(
            imageUrl: 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
            title: 'Weird Girl',
            author: 'Corinne Sweet',
            price: '\$44.00',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            secondaryTextColor: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
          ),
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
            imageUrl: 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
            title: 'Mindfulness Journal',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
          ),
          _MostPopularItem(
            imageUrl: 'https://cdn.pixabay.com/photo/2016/11/19/00/30/book-1837012_1280.jpg',
            title: 'Star Girl',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
          ),
          _MostPopularItem(
            imageUrl: 'https://cdn.pixabay.com/photo/2016/11/29/05/09/book-1867160_1280.jpg',
            title: 'Book Ma...',
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
          ),
        ],
      ),
    );
  }
}

class _BookItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String price;
  final Color textColor;
  final Color secondaryTextColor;

  const _BookItem({
    required this.imageUrl,
    required this.title,
    required this.author,
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
            author,
            style: TextStyle(
              color: secondaryTextColor,
              fontSize: 14,
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

class _MostPopularItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Color textColor;

  const _MostPopularItem({
    required this.imageUrl,
    required this.title,
    required this.textColor,
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
    );
  }
}