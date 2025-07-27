import 'package:flutter/material.dart';

class ChaptersTab extends StatelessWidget {
  const ChaptersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chapters = [
      {'title': 'Chapter 1: Section 1 - Introduction', 'duration': '15 Min'},
      {'title': 'Chapter 2: The Power', 'duration': '10 Min'},
      {'title': 'Chapter 3: The Target', 'duration': '12 Min'},
      {'title': 'Chapter 4: The End', 'duration': '18 Min'},
      {'title': 'Chapter 5: Final Thoughts', 'duration': '10 Min'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: chapters.length,
      itemBuilder: (context, index) {
        final chapter = chapters[index];
        return Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(Icons.play_circle_filled, color: Colors.brown[700], size: 30),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chapter(${index + 1})',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                      Text(
                        chapter['title']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  chapter['duration']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).iconTheme.color, size: 18),
                  onPressed: () {
                    print('Play chapter ${chapter['title']}');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}