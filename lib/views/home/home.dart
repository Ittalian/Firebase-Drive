import 'package:firebase_drive/routes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String driveButtonText = 'ドライブに保存';
    String firebaseButtonText = 'Firebaseに保存';
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/home_background.jpg'),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      onPressed: () {}, label: Text(driveButtonText))),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.firebasePage,
                          arguments: false,
                        );
                      },
                      label: Text(firebaseButtonText))),
              const Padding(padding: EdgeInsets.only(bottom: 140)),
            ],
          ),
        ));
  }
}
