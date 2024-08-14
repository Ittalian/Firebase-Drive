import 'package:flutter/material.dart';

class DropdownItem extends StatelessWidget {
  final String name;
  final double fontSize;

  const DropdownItem({super.key, required this.name, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }
}
