import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voqula/services/database_service.dart';

class UserProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  Map<String, dynamic>? _userData;
  bool _isLoading = false;

  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;

  Future<void> fetchUserData(String uid) async {
    _isLoading = true;
    notifyListeners();

    try {
      DocumentSnapshot doc = await _dbService.getUserData(uid);
      _userData = doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print(e);
      _userData = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearUserData() {
    _userData = null;
    notifyListeners();
  }
}