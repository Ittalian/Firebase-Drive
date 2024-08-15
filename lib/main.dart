import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_drive/firebase_options.dart';
import 'package:firebase_drive/repositories/category_repository.dart';
import 'package:firebase_drive/repositories/picture_repository.dart';
import 'package:firebase_drive/repositories/used_app_repository.dart';
import 'package:firebase_drive/routes.dart';
import 'package:firebase_drive/services/firestore_service.dart';
import 'package:firebase_drive/view_models/category_view_model.dart';
import 'package:firebase_drive/view_models/picture_view_model.dart';
import 'package:firebase_drive/view_models/used_app_view_model.dart';
import 'package:firebase_drive/widgets/checkbox/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) =>
                  PictureViewModel(PictureRepository(FirestoreService()))),
          ChangeNotifierProvider(
              create: (_) =>
                  UsedAppViewModel(UsedAppRepository(FirestoreService()))),
          ChangeNotifierProvider(
              create: (_) =>
                  CategoryViewModel(CategoryRepository(FirestoreService()))),
          ChangeNotifierProvider(create: (_) => CustomCheckbox()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRoutes.generateRoute,
        ));
  }
}
