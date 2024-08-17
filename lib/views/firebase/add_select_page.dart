import 'package:firebase_drive/routes.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/add_select/add_select_page.dart' as add_select_constants;

class AddSelectPage extends StatelessWidget {
  final String image;
  const AddSelectPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.firebasePage,
                          arguments: '',
                        );
                      },
                      label: const Text(add_select_constants.addPictureText))),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.addPage,
                          arguments: true,
                        );
                      },
                      label: const Text(add_select_constants.addCategoryText))),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.addPage,
                          arguments: false,
                        );
                      },
                      label: const Text(add_select_constants.addUsedAppText))),
              const Padding(padding: EdgeInsets.only(bottom: 140)),
            ],
          ),
        ));
  }
}
