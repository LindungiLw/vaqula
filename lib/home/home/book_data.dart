import 'package:voqula/home/home/popular_book.dart';
import 'book.dart';

class BookData {
  static final List<Book> bestSellingBooks = [
    Book(
      imageUrl: 'assets/books/the_book_thief.jpg',
      title: 'The Book Thief',
      author: 'Corinne Sweet',
      authorImageUrl: 'assets/images/corinne_sweet_author.jpg',
      price: '\$56.00',
    ),
    Book(
      imageUrl: 'assets/books/the_whispers.jpg',
      title: 'The Whispers',
      author: 'Greg Howard',
      authorImageUrl: 'assets/books/the_whispers.jpg',
      price: '\$33',
    ),
    Book(
      imageUrl: 'assets/books/weird_girl.jpg',
      title: 'Weird Girl',
      author: 'Corinne Sweet',
      authorImageUrl: 'assets/images/corinne_sweet_author.jpg',
      price: '\$44.00',
    )
  ];

  static final List<PopularBook> mostPopularBooks = [
    PopularBook(
      imageUrl: 'assets/popular/mindfulness_journal.jpg',
      title: 'Mindfulness Journal',
    ),
    PopularBook(
      imageUrl: 'assets/popular/star_girl.jpg',
      title: 'Star Girl',
    ),
    PopularBook(
      imageUrl: 'assets/popular/book_man.jpg',
      title: 'Book Man',
    ),
  ];
}