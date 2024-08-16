import 'package:flutter/material.dart';

class DropdownItem extends StatelessWidget {
  final String value;
  final double fontSize;

  const DropdownItem({super.key, required this.value, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }
}
