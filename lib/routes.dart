import 'dart:math';
import 'package:firebase_drive/views/drive/drive_page.dart';
import 'package:firebase_drive/views/firebase/add/add_page.dart';
import 'package:firebase_drive/views/firebase/add_select_page.dart';
import 'package:firebase_drive/views/firebase/firebase_page.dart';
import 'package:firebase_drive/views/home/home.dart';
import 'package:flutter/material.dart';
import 'utils/constants/home/image_list.dart' as home_image_list;
import './utils/constants/firebase/firebase_image_list.dart'
    as firebase_image_list;
import './utils/constants/drive/drive_image_list.dart' as drive_image_list;
import './utils/constants/add_select/add_select_image_list.dart'
    as add_select_image_list;
import './utils/constants/add_select/add/add_image_list.dart' as add_image_list;

class AppRoutes {
  static const String home = '/';
  static const String firebasePage = '/firebase';
  static const String drivePage = '/drive';
  static const String addSelectPage = '/add_select';
  static const String addPage = '/add';

  static String getImagePath(List<String> imageList) {
    final random = Random();
    int randomIndex = random.nextInt(imageList.length);
    return imageList[randomIndex];
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        final String image = getImagePath(home_image_list.imageList);
        return MaterialPageRoute(builder: (_) => Home(image: image));
      case firebasePage:
        final String driveImage =
            getImagePath(firebase_image_list.fromDriveImageList);
        final String firebaseImage =
            getImagePath(firebase_image_list.fromFirebaseImageList);
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => FirebasePage(
                fromDriveImage: driveImage,
                fromFirebaseImage: firebaseImage,
                driveId: args));
      case drivePage:
        final String image = getImagePath(drive_image_list.driveImageList);
        return MaterialPageRoute(builder: (_) => DrivePage(image: image));
      case addSelectPage:
        final String image =
            getImagePath(add_select_image_list.addSelectImageList);
        return MaterialPageRoute(builder: (_) => AddSelectPage(image: image));
      case addPage:
        final args = settings.arguments as bool;
        final String categoryImage =
            getImagePath(add_image_list.addCategoryImageList);
        final String usedAppImage =
            getImagePath(add_image_list.addUsedAppImageList);
        return MaterialPageRoute(
            builder: (_) => AddPage(
                isCategory: args,
                categoryImage: categoryImage,
                usedAppImage: usedAppImage));
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
