import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
    return null;
  }
}
