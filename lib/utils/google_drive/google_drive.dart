import 'dart:developer' as developer;
import 'dart:io' as io;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:http/http.dart';


final googleSignIn = GoogleSignIn(scopes: [DriveApi.driveScope]);

GoogleSignInAccount? account;
Client? client;
DriveApi? drive;

signIn() async {
  account = await googleSignIn.signIn();
  client = await googleSignIn.authenticatedClient();
  drive = DriveApi(client!);
  googleSignIn.isSignedIn();
}

signOut() {
  googleSignIn.disconnect();
}

upload(String path, String fileName) async {
  var txtFile = io.File(path);
  txtFile.writeAsStringSync("アップロードのテストです");

  developer.log("check");
  var list = (await drive?.files.list())?.files;
  String id = "";
  list?.forEach((element) {
    if (element.name == fileName) {
      id = element.id ?? "";
      developer.log("${element.name} match $id");
    }
  });

  var file = File(
    name: fileName,
    modifiedTime: DateTime.now().toUtc(),
  );
  var media = Media(txtFile.openRead(), txtFile.lengthSync());

  if ("" == id) {
    drive?.files
        .create(file, uploadMedia: media)
        .then((file) => developer.log("create success"))
        .catchError(
            (error) => developer.log("create error : $error", error: error));
  } else {
    drive?.files.update(file, id, uploadMedia: media).then((file) {
      file.parents?.forEach((element) {
        developer.log("element : ${element.characters.string}");
      });
      developer.log("upload success");
    }).catchError;
  }
}
