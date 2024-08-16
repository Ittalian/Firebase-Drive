import 'package:firebase_drive/views/drive/drive_page.dart';
import 'package:firebase_drive/views/firebase/firebase_page.dart';
import 'package:firebase_drive/views/home/home.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String firebasePage = '/firebase';
  static const String drivePage = '/drive';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const Home());
      case firebasePage:
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => FirebasePage(driveId: args));
      case drivePage:
        return MaterialPageRoute(builder: (_) => const DrivePage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                        child: Text(
                  '${settings.name}は存在しません',
                  style: const TextStyle(fontSize: 20),
                ))));
    }
  }
}
