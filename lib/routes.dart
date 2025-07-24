import 'package:flutter/material.dart';

import 'cover/app_cover.dart';
import 'cover/welcoming_app.dart';
import 'home/main_home.dart';
import 'home/main_screen.dart';
import 'home/category/category_page.dart';
import 'login/login_pages.dart';
import 'login/sign_up.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/cover' : (BuildContext context) => AppCover(),
  '/main_screen' : (BuildContext context) => MainScreen(),
  '/welcoming_cover' : (BuildContext context) => WelcomingApp(),
  '/signup' : (BuildContext context) => SignupScreen(),
  '/login' : (BuildContext context) => LoginPage(),
  '/home' : (BuildContext context) => HomePage(),
  '/category' : (BuildContext context) => CategoryPage(),
};