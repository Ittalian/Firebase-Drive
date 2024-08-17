import 'package:firebase_drive/models/picture_category.dart';
import 'package:firebase_drive/models/used_app.dart';
import 'package:firebase_drive/utils/dialog/add_firebase_dialog.dart';
import 'package:firebase_drive/utils/message/save_message/save_message.dart';
import 'package:firebase_drive/utils/validator/firebase/category_validator.dart';
import 'package:firebase_drive/view_models/category_view_model.dart';
import 'package:firebase_drive/view_models/used_app_view_model.dart';
import 'package:firebase_drive/widgets/textform_field/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants/firebase/firebase_page.dart'
    as firebase_constants;
import '../../../utils/constants/add_select/add/add_page.dart' as add_constants;

class AddPage extends StatelessWidget {
  final bool isCategory;
  final String categoryImage;
  final String usedAppImage;
  const AddPage({super.key, required this.isCategory, required this.categoryImage, required this.usedAppImage});


  @override
  Widget build(BuildContext context) {
    TextEditingController categoryController = TextEditingController();
    TextEditingController usedAppController = TextEditingController();
    final usedAppViewModel = context.watch<UsedAppViewModel>();
    final categoryViewModel = context.watch<CategoryViewModel>();
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: isCategory
                    ? AssetImage(categoryImage)
                    : AssetImage(usedAppImage),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: Form(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            isCategory
                ? Flexible(
                    child: Container(
                        height: 70,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        margin: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: CustomTextformfield(
                            controller: categoryController,
                            labelText: add_constants.categoryText,
                            validator: (value) =>
                                CategoryValidator(value: value).validate())))
                : Flexible(
                    child: Container(
                        height: 70,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        margin: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: CustomTextformfield(
                            controller: usedAppController,
                            labelText: add_constants.usedAppText,
                            validator: (value) =>
                                CategoryValidator(value: value).validate()))),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Builder(builder: (BuildContext context) {
              return ElevatedButton.icon(
                  onPressed: () {
                    if (Form.of(context).validate()) {
                      AddFirebaseDialog.show(
                          context, firebase_constants.saveConfirmText, () {
                        if (isCategory) {
                          PictureCategory category =
                              PictureCategory(value: categoryController.text);
                          categoryViewModel.addCategory(category);
                        } else {
                          UsedApp usedApp =
                              UsedApp(name: usedAppController.text);
                          usedAppViewModel.addUsedApp(usedApp);
                        }
                        const Savemessage(firebase_constants.saveMessage)
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
          ])),
        ));
  }
}
