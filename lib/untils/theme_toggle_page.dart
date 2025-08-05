import 'package:flutter/material.dart';

class ThemeTogglePage extends StatelessWidget {
  final VoidCallback toggleTheme;

  const ThemeTogglePage({required this.toggleTheme, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Toggle Theme',
          style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle?.color),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6, color: Theme.of(context).iconTheme.color),
            onPressed: toggleTheme,
          )
        ],
      ),
      body: Center(
        child: Text(
          'Press the icon above to switch between light and dark modes.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
      ),
    );
  }
}