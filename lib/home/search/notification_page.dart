import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

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
          'Notification',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              print('Mark all as read tapped!');
              // Implementasi logika mark all as read
            },
            child: Text(
              'mark all as read',
              style: TextStyle(
                color: Color(0xFFA05E1A),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 10),
              _buildNotificationItem(
                context,
                icon: Icons.book_online,
                title: 'new book available',
                time: '2m',
                isNew: true,
                description: 'simply dummy text of the printing and typesetting industry.',
              ),
              _buildNotificationItem(
                context,
                icon: Icons.book_online,
                title: 'continue reading books',
                time: '9h',
                description: 'simply dummy text of the printing and typesetting industry.',
              ),
              _buildNotificationItem(
                context,
                icon: Icons.book_online,
                title: 'new book purchased',
                time: '12h',
                description: 'simply dummy text of the printing and typesetting industry.',
              ),
              const SizedBox(height: 20),
              Text(
                'Yesterday',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 10),
              _buildNotificationItem(
                context,
                icon: Icons.discount,
                title: '20% off on travels book',
                time: '1d',
                description: 'simply dummy text of the printing and typesetting industry.',
              ),
              _buildNotificationItem(
                context,
                icon: Icons.book_online,
                title: 'continue reading books',
                time: '2d',
                description: 'simply dummy text of the printing and typesetting industry.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String time,
        bool isNew = false,
        required String description,
      }) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Color(0xFFA05E1A), size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
            if (isNew)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'New',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}