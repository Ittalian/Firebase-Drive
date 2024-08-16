import 'package:firebase_drive/models/picture.dart';
import 'package:firebase_drive/utils/dialog/add_firebase_dialog.dart';
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
import '../../utils/constants/firebase/firebase_page.dart'
    as firebase_constants;

class FirebasePage extends StatelessWidget {
  final String driveId;
  FirebasePage({super.key, required this.driveId});

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
    final pictureViewModel = context.watch<PictureViewModel>();
    final usedAppViewModel = context.watch<UsedAppViewModel>();
    final categoryViewModel = context.watch<CategoryViewModel>();
    final checkboxModel = context.watch<CustomCheckbox>();
    bool isFromDrive = false;
    if (driveId.isNotEmpty) {
      isFromDrive = true;
    }
    return PopScope(
        canPop: isFromDrive ? false : true,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: driveId.isEmpty
                      ? const AssetImage('images/firebase_background.jpg')
                      : const AssetImage('images/firebase_background2.jpg'),
                  fit: BoxFit.cover)),
          child: Scaffold(
              backgroundColor: Colors.white.withOpacity(0),
              body: Form(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                    !isFromDrive
                        ? Flexible(
                            child: Container(
                                height: 70,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                                        DriveIdValidator(value: value)
                                            .validate())))
                        : const SizedBox.shrink(),
                    Flexible(
                        child: Container(
                            height: 65,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            margin: const EdgeInsets.fromLTRB(35, 20, 35, 0),
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: UsedAppDropDownList(
                                menuList: usedAppViewModel.usedApps,
                                notifyParent: setUsedApp))),
                    Flexible(
                        child: Container(
                            height: 65,
                            padding: const EdgeInsets.only(left: 10),
                            margin: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: CategoryDropDownList(
                                menuList: categoryViewModel.categories,
                                notifyParent: setCategory))),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(firebase_constants.favoriteText,
                          style: TextStyle(fontSize: 20)),
                      Checkbox(
                          value: checkboxModel.isChecked,
                          onChanged: (value) =>
                              checkboxModel.handleCheckbox(value))
                    ]),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Builder(builder: (BuildContext context) {
                      return ElevatedButton.icon(
                          onPressed: () {
                            if (Form.of(context).validate()) {
                              AddFirebaseDialog.show(
                                  context, firebase_constants.saveConfirmText,
                                  () {
                                if (isFromDrive) {
                                  Picture picture = Picture(
                                      driveId: driveId,
                                      categoryId: categoryIdController.text,
                                      usedAppId: usedAppIdController.text,
                                      favorite: checkboxModel.isChecked);
                                  pictureViewModel.addPicture(picture);
                                } else {
                                  Picture picture = Picture(
                                      driveId: driveIdController.text,
                                      categoryId: categoryIdController.text,
                                      usedAppId: usedAppIdController.text,
                                      favorite: checkboxModel.isChecked);
                                  pictureViewModel.addPicture(picture);
                                }
                                const Savemessage(
                                        firebase_constants.saveMessage)
                                    .informAction(context);
                                Navigator.pop(context);
                              });
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text(
                            firebase_constants.saveText,
                            style: TextStyle(fontSize: 20),
                          ));
                    }),
                    const Padding(padding: EdgeInsets.only(top: 50))
                  ]))),
        ));
  }
}
