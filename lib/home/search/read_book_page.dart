import 'package:flutter/material.dart';

class ReadBookPage extends StatefulWidget {
  final String bookTitle;
  final String imageUrl;

  const ReadBookPage({
    Key? key,
    required this.bookTitle,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<ReadBookPage> createState() => _ReadBookPageState();
}

class _ReadBookPageState extends State<ReadBookPage> {
  double _fontSize = 16.0;
  bool _isDarkModeReading = false;
  int _currentPage = 1;
  final int _totalPages = 35;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.bookTitle,
          style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle?.color),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isDarkModeReading ? Icons.dark_mode : Icons.light_mode, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              setState(() {
                _isDarkModeReading = !_isDarkModeReading;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              print('Bookmark tapped!');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(_isDarkModeReading ? 0.7 : 0.0), // Overlay for dark mode
              colorBlendMode: BlendMode.darken,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300]),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: _isDarkModeReading ? Colors.black.withOpacity(0.8) : Colors.white.withOpacity(0.8),
            ),
          ),
          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Whispers',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _isDarkModeReading ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.\n\nThe standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.\n\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\n\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\n\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\n\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
                  style: TextStyle(
                    fontSize: _fontSize,
                    height: 1.5,
                    color: _isDarkModeReading ? Colors.white70 : Colors.black87,
                  ),
                ),
                const SizedBox(height: 100), // Space for controls at the bottom
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: _isDarkModeReading ? Colors.grey[900]?.withOpacity(0.9) : Colors.white.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Font Size',
                        style: TextStyle(color: _isDarkModeReading ? Colors.white : Colors.black),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline, color: _isDarkModeReading ? Colors.white : Colors.black),
                            onPressed: () {
                              setState(() {
                                if (_fontSize > 12) _fontSize--;
                              });
                            },
                          ),
                          Text(
                            _fontSize.toInt().toString(),
                            style: TextStyle(color: _isDarkModeReading ? Colors.white : Colors.black),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline, color: _isDarkModeReading ? Colors.white : Colors.black),
                            onPressed: () {
                              setState(() {
                                if (_fontSize < 24) _fontSize++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Slider(
                    value: _fontSize,
                    min: 12,
                    max: 24,
                    divisions: 12,
                    activeColor: Color(0xFFb8792b),
                    inactiveColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chapter(${_currentPage})',
                        style: TextStyle(color: _isDarkModeReading ? Colors.white : Colors.black),
                      ),
                      Text(
                        '$_currentPage / $_totalPages',
                        style: TextStyle(color: _isDarkModeReading ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}