import 'package:firebase_drive/view_models/category_view_model.dart';
import 'package:firebase_drive/view_models/used_app_view_model.dart';
import 'package:firebase_drive/widgets/drop_down/category_drop_down_list.dart';
import 'package:firebase_drive/widgets/drop_down/used_app_drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebasePage extends StatelessWidget {
  final bool isFromDrive;
  const FirebasePage({super.key, required this.isFromDrive});

  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey();
    // final pictureViewModel = context.watch<PictureViewModel>();
    String usedAppText = '使用アプリ';
    String categoryText = 'カテゴリ';
    final usedAppViewModel = context.watch<UsedAppViewModel>();
    final categoryViewModel = context.watch<CategoryViewModel>();
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/firebase_background.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Padding(padding: EdgeInsets.only(top: 150)),
            Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                color: Colors.white,
                alignment: Alignment.center,
                child: Row(children: [
                  Text(
                    usedAppText,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  UsedAppDropDownList(menuList: usedAppViewModel.usedApps)
                ])),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                color: Colors.white,
                alignment: Alignment.center,
                child: Row(children: [
                  Text(
                    categoryText,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  CategoryDropDownList(menuList: categoryViewModel.categories)
                ]))
          ])),
    );
  }
}
