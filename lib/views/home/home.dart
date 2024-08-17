import 'package:firebase_drive/routes.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/home/home.dart' as home_constants;

class Home extends StatefulWidget {
  final String image;
  const Home({super.key, required this.image});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.image),
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
                        Navigator.pushNamed(context, AppRoutes.drivePage);
                      },
                      label: const Text(home_constants.driveButtonText))),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.addSelectPage,
                        );
                      },
                      label: const Text(home_constants.firebaseButtonText))),
              const Padding(padding: EdgeInsets.only(bottom: 140)),
            ],
          ),
        )));
  }
}
