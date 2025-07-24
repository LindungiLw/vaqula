import 'package:flutter/material.dart';

import 'cover/app_cover.dart';
import 'cover/welcoming_app.dart';
import 'login/sign_up.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/cover' : (BuildContext context) => AppCover(),
  '/welcoming_cover' : (BuildContext context) => WelcomingApp(),
  '/signup' : (BuildContext context) => SignupScreen(),
};