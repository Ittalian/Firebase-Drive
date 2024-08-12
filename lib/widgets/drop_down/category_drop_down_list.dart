import 'package:firebase_drive/models/picture_category.dart';
import 'package:flutter/material.dart';
import 'drop_down_item.dart';

class CategoryDropDownList extends StatefulWidget {
  final List<PictureCategory> menuList;
  const CategoryDropDownList({super.key, required this.menuList});

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
              value: menu.name, child: DropdownItem(name: menu.name))
      ],
      onChanged: (String? value) {
        setState(() {
          setName(value);
        });
      },
    );
  }
}
