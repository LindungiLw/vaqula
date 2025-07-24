import 'package:flutter/material.dart';

class ChaptersTab extends StatelessWidget {
  const ChaptersTab({Key? key}) : super(key: key);

  // Example chapter data
  final List<Map<String, dynamic>> _chapters = const [
    {'title': 'Chapter(1)', 'subtitle': 'Section 1- Introduction', 'duration': '15 Min'},
    {'title': 'Chapter 2', 'subtitle': 'The Power', 'duration': '10 Min'},
    {'title': 'Chapter 3', 'subtitle': 'The Target', 'duration': '12 Min'},
    {'title': 'The End', 'subtitle': 'Conclusion', 'duration': '8 Min'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: _chapters.map((chapter) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey[300]!), // Add border
              ),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.brown[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      chapter['title'].toString().split(' ').first.replaceAll('Chapter(', ''), // Extract number
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.brown[700],
                      ),
                    ),
                  ),
                ),
                title: Text(
                  chapter['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(chapter['subtitle']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      chapter['duration'],
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Icon(Icons.play_circle_fill, color: Colors.grey),
                  ],
                ),
                onTap: () {
                  // Handle chapter tap (e.g., open chapter content)
                  print('Tapped ${chapter['title']}');
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}