import 'package:firebase_drive/routes.dart';
import 'package:flutter/material.dart';

class AddSelectPage extends StatelessWidget {
  final String image;
  const AddSelectPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    String addPictureText = '写真を追加';
    String addCategoryText = 'カテゴリを追加';
    String addUsedAppText = 'アプリを追加';
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.firebasePage,
                          arguments: '',
                        );
                      },
                      label: Text(addPictureText))),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.addPage,
                          arguments: true,
                        );
                      },
                      label: Text(addCategoryText))),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.addPage,
                          arguments: false,
                        );
                      },
                      label: Text(addUsedAppText))),
              const Padding(padding: EdgeInsets.only(bottom: 140)),
            ],
          ),
        ));
  }
}
