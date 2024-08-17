import 'package:firebase_drive/routes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String image;
  const Home({super.key, required this.image});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String driveButtonText = 'ドライブに保存';
    String firebaseButtonText = 'Firebaseに保存';
    return Container(
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
                      label: Text(driveButtonText))),
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
                      label: Text(firebaseButtonText))),
              const Padding(padding: EdgeInsets.only(bottom: 140)),
            ],
          ),
        ));
  }
}
