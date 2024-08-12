import 'package:firebase_drive/models/used_app.dart';
import 'package:flutter/material.dart';
import 'drop_down_item.dart';

class UsedAppDropDownList extends StatefulWidget {
  final List<UsedApp> menuList;
  const UsedAppDropDownList({super.key, required this.menuList});

  @override
  State<UsedAppDropDownList> createState() => _UsedAppDropDownListState();
}

class _UsedAppDropDownListState extends State<UsedAppDropDownList> {
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
