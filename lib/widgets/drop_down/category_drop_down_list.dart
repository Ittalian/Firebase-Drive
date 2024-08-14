import 'package:firebase_drive/models/picture_category.dart';
import 'package:flutter/material.dart';
import 'drop_down_item.dart';

class CategoryDropDownList extends StatefulWidget {
  final List<PictureCategory> menuList;
  final Function(String?) notifyParent;
  const CategoryDropDownList({super.key, required this.menuList, required this.notifyParent});

  @override
  State<CategoryDropDownList> createState() => _CategoryDropDownListState();
}

class _CategoryDropDownListState extends State<CategoryDropDownList> {
  String? name;

  @override
  void initState() {
    super.initState();
    if (widget.menuList.isNotEmpty) {
      name = widget.menuList.first.name;
    }
  }

  void setName(String? value) {
    setState(() {
      name = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: name,
      items: [
        for (var menu in widget.menuList)
          DropdownMenuItem<String>(
              value: menu.categoryId,
              child: DropdownItem(name: menu.name, fontSize: 14))
      ],
      onChanged: (String? value) {
        setState(() {
          setName(value);
        });
        widget.notifyParent(value);
      },
    );
  }
}
