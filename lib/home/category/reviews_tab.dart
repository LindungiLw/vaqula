import 'package:flutter/material.dart';
import 'add_review_page.dart';
 // Import the add review page

class ReviewsTab extends StatelessWidget {
  final String bookTitle;

  const ReviewsTab({
    Key? key,
    required this.bookTitle,
  }) : super(key: key);

  // Example review data
  final List<Map<String, dynamic>> _reviews = const [
    {
      'user': 'Dale Thiefl',
      'time': '11 Months Ago',
      'rating': 4,
      'comment': 'There Are Many Variations Of Passages Of Lorem Ipsum Available Unusu, Or Randomised Words Which Don\'t Look Even Slightly Believable.',
    },
    {
      'user': 'Jane Doe',
      'time': '2 Months Ago',
      'rating': 5,
      'comment': 'Amazing book! Highly recommend to everyone.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search/Filter Row
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search in Reviews',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.grey),
                  onPressed: () {
                    // Handle filter reviews
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddReviewPage(bookTitle: bookTitle)),
                );
              },
              icon: Icon(Icons.add, color: Colors.brown[700]),
              label: Text(
                'Add Review',
                style: TextStyle(color: Colors.brown[700], fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: _reviews.length,
              itemBuilder: (context, index) {
                final review = _reviews[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.brown,
                              radius: 20,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review['user'],
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text(
                                  review['time'],
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: List.generate(5, (starIndex) {
                                return Icon(
                                  starIndex < review['rating'] ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 18,
                                );
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          review['comment'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}