import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createOrUpdateUser(User user) async {
    final userRef = _db.collection('users').doc(user.uid);
    final snapshot = await userRef.get();

    if (!snapshot.exists) {
      await userRef.set({
        'displayName': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<DocumentSnapshot> getUserData(String uid) {
    return _db.collection('users').doc(uid).get();
  }

  Future<void> updateUserData(String uid, Map<String, dynamic> data) {
    return _db.collection('users').doc(uid).update(data);
  }

  Future<void> addReview(String bookTitle, double rating, String comment) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _db.collection('reviews').add({
        'bookTitle': bookTitle,
        'userId': user.uid,
        'userName': user.displayName ?? 'Anonymous',
        'userPhoto': user.photoURL ?? '',
        'rating': rating,
        'comment': comment,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      throw Exception('User not logged in');
    }
  }

  Stream<QuerySnapshot> getReviews(String bookTitle) {
    return _db
        .collection('reviews')
        .where('bookTitle', isEqualTo: bookTitle)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> addBook({
    required String title,
    required String author,
    required String imageUrl,
    required String category,
  }) async {
    await _db.collection('books').add({
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'category': category,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getBooksStream() {
    return _db.collection('books').orderBy('createdAt', descending: true).snapshots();
  }
}