import 'package:firebase_drive/models/picture_category.dart';
import 'package:firebase_drive/utils/validator/simple_validator.dart';
import 'package:flutter/material.dart';
import 'drop_down_item.dart';
import '../../utils/constants/widget/category_drop_down_list.dart' as category_drop_down_constants;

class CategoryDropDownList extends StatefulWidget {
  final List<PictureCategory> menuList;
  final Function(String?) notifyParent;
  const CategoryDropDownList(
      {super.key, required this.menuList, required this.notifyParent});

  @override
  State<CategoryDropDownList> createState() => _CategoryDropDownListState();
}

class _CategoryDropDownListState extends State<CategoryDropDownList> {
  String? name;
  String? value;

  @override
  void initState() {
    super.initState();
    if (widget.menuList.isNotEmpty) name;
  }

  void setName(String? value) {
    setState(() {
      name = value;
    });
  }

  void setValue(String? newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: const InputDecoration(
          border: InputBorder.none,
          labelText: category_drop_down_constants.labelText,
          labelStyle: TextStyle(fontSize: 20)),
      items: [
        for (var menu in widget.menuList)
          DropdownMenuItem<String>(
              value: menu.categoryId,
              child: DropdownItem(value: menu.value, fontSize: 14))
      ],
      onChanged: (String? value) {
        setState(() {
          setName(value);
        });
        widget.notifyParent(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => SimpleValidator(value: value).validate(),
    );
  }
}
