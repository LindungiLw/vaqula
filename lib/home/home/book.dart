class Book {
  final String imageUrl;
  final String title;
  final String author;
  final String? authorImageUrl;
  final String? price;

  Book({
    required this.imageUrl,
    required this.title,
    required this.author,
    this.authorImageUrl,
    this.price,
  });
}