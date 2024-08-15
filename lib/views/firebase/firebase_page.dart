import 'package:firebase_drive/models/picture.dart';
import 'package:firebase_drive/utils/message/save_message/save_message.dart';
import 'package:firebase_drive/utils/validator/firebase/drive_id_varlidator.dart';
import 'package:firebase_drive/view_models/category_view_model.dart';
import 'package:firebase_drive/view_models/picture_view_model.dart';
import 'package:firebase_drive/view_models/used_app_view_model.dart';
import 'package:firebase_drive/widgets/checkbox/custom_checkbox.dart';
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
    String saveText = '保存';
    String saveMessage = '';
    String favoriteText = 'お気に入り';
    final pictureViewModel = context.watch<PictureViewModel>();
    final usedAppViewModel = context.watch<UsedAppViewModel>();
    final categoryViewModel = context.watch<CategoryViewModel>();
    final checkboxModel = context.watch<CustomCheckbox>();
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/firebase_background.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: Form(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Flexible(
                child: Container(
                    height: 70,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    margin: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: CustomTextformfield(
                        controller: driveIdController,
                        labelText: "Google Drive ID",
                        onChanged: (value) {
                          driveIdController.text = value;
                        },
                        validator: (value) =>
                            DriveIdValidator(value: value).validate()))),
            Flexible(
                child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: const EdgeInsets.fromLTRB(35, 20, 35, 0),
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: UsedAppDropDownList(
                        menuList: usedAppViewModel.usedApps,
                        notifyParent: setUsedApp))),
            Flexible(
                child: Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: CategoryDropDownList(
                        menuList: categoryViewModel.categories,
                        notifyParent: setCategory))),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(favoriteText, style: const TextStyle(fontSize: 20)),
              Checkbox(
                  value: checkboxModel.isChecked,
                  onChanged: (value) => checkboxModel.handleCheckbox(value))
            ]),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Builder(builder: (BuildContext context) {
              return ElevatedButton.icon(
                  onPressed: () {
                    if (Form.of(context).validate()) {
                      Picture picture = Picture(
                          driveId: driveIdController.text,
                          categoryId: categoryIdController.text,
                          usedAppId: usedAppIdController.text,
                          favorite: checkboxModel.isChecked);
                      pictureViewModel.addPicture(picture);
                      Savemessage(saveMessage).informAction(context);
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: Text(
                    saveText,
                    style: const TextStyle(fontSize: 20),
                  ));
            }),
            const Padding(padding: EdgeInsets.only(top: 50))
          ]))),
    );
  }
}
