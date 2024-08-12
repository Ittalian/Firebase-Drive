import 'package:flutter/material.dart';

class DropdownItem extends StatelessWidget {
  final String name;

  const DropdownItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return
      Text(
      name,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
