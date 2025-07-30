import 'package:flutter/material.dart';
import 'package:voqula/cover/app_cover.dart';
import 'package:voqula/cover/welcoming_app.dart';
import 'package:voqula/home/main_screen.dart';
import 'package:voqula/login/login_pages.dart';
import 'package:voqula/login/sign_up.dart';
import 'home/category/category_page.dart';
import 'home/home/home.dart';
import 'home/search/notification_page.dart';
import 'home/profil/profile_page.dart';
import 'home/search/search_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/cover': (BuildContext context) => AppCover(),
  '/welcoming_cover': (BuildContext context) => WelcomingApp(),
  '/signup': (BuildContext context) => SignupScreen(),
  '/login': (BuildContext context) => LoginPage(),
  '/main_screen': (BuildContext context) => MainScreen(),
  '/home_tab': (BuildContext context) => HomePage(),
  '/category_tab': (BuildContext context) => CategoryPage(),
  '/search_tab': (BuildContext context) => SearchPage(),
  '/profile_tab': (BuildContext context) => ProfilePage(),
  '/notifications': (BuildContext context) => NotificationPage(),
};