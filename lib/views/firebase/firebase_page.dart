import 'package:firebase_drive/models/picture.dart';
import 'package:firebase_drive/view_models/category_view_model.dart';
import 'package:firebase_drive/view_models/picture_view_model.dart';
import 'package:firebase_drive/view_models/used_app_view_model.dart';
import 'package:firebase_drive/widgets/drop_down/category_drop_down_list.dart';
import 'package:firebase_drive/widgets/drop_down/used_app_drop_down_list.dart';
import 'package:firebase_drive/widgets/textform_field/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebasePage extends StatelessWidget {
  final bool isFromDrive;
  FirebasePage({super.key, required this.isFromDrive});

  final TextEditingController driveIdController = TextEditingController();
  final TextEditingController usedAppIdController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();

  void setUsedApp(String? value) {
    usedAppIdController.text = value!;
  }

  void setCategory(String? value) {
    categoryIdController.text = value!;
  }

  @override
  Widget build(BuildContext context) {
    String usedAppText = '使用アプリ';
    String categoryText = 'カテゴリ';
    String saveText = '保存';
    final pictureViewModel = context.watch<PictureViewModel>();
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
            Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                margin: const EdgeInsets.fromLTRB(35, 180, 35, 0),
                alignment: Alignment.center,
                color: Colors.white,
                child: CustomTextformfield(
                  controller: driveIdController,
                  labelText: "Google Drive ID",
                  onChanged: (value) {
                    driveIdController.text = value;
                  },
                )),
            Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.fromLTRB(35, 20, 35, 0),
                color: Colors.white,
                alignment: Alignment.center,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        usedAppText,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      UsedAppDropDownList(
                          menuList: usedAppViewModel.usedApps,
                          notifyParent: setUsedApp)
                    ])),
            Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                color: Colors.white,
                alignment: Alignment.center,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        categoryText,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      CategoryDropDownList(
                          menuList: categoryViewModel.categories,
                          notifyParent: setCategory)
                    ])),
            ElevatedButton.icon(
                onPressed: () {
                  Picture picture = Picture(
                      driveId: driveIdController.text,
                      categoryId: categoryIdController.text,
                      usedAppId: usedAppIdController.text,
                      favorite: true);
                  pictureViewModel.addPicture(picture);
                },
                icon: const Icon(Icons.save),
                label: Text(
                  saveText,
                  style: const TextStyle(fontSize: 20),
                ))
          ])),
    );
  }
}
