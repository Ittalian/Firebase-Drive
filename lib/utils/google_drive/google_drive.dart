import 'dart:io' as io;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_drive/utils/message/error_message/permission_error_message.dart';
import 'package:firebase_drive/utils/message/save_message/save_message.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:http/http.dart';
import '../constants/drive/google_drive.dart' as google_drive;

final googleSignIn = GoogleSignIn(scopes: [DriveApi.driveScope]);

class GoogleDrive {
  final BuildContext context;
  GoogleDrive({required this.context});

  GoogleSignInAccount? account;
  Client? client;
  DriveApi? drive;

  signIn() async {
    account = await googleSignIn.signIn();
    client = await googleSignIn.authenticatedClient();
    drive = DriveApi(client!);
  }

  signOut() {
    googleSignIn.disconnect();
  }

  Future<void> setFilePublic(String fileId) async {
    try {
      var permission = Permission()
        ..type = "anyone"
        ..role = "reader";

      await drive?.permissions.create(permission, fileId);
    } catch (e) {
      const PermissionErrorMessage(google_drive.accessRightErrorText).informAction(context);
    }
  }

  Future<String> upload(String path, String fileName) async {
    var txtFile = io.File(path);
    var mimType = 'image/jpeg';

    String? folderId = await getOrCreateFolderId(google_drive.folderName);
    String? subFolderId =
        await getOrCreateFolderId(google_drive.subFolderName, parentFolderId: folderId);

    var list = (await drive?.files.list())?.files;
    String id = "";
    list?.forEach((element) {
      if (element.name == fileName) {
        id = element.id ?? "";
      }
    });

    if (fileName.endsWith('.jpg')) {
      mimType = 'image/png';
    }

    var file = File(
        name: fileName,
        modifiedTime: DateTime.now().toUtc(),
        mimeType: mimType,
        parents: [subFolderId!]);
    var media = Media(txtFile.openRead(), txtFile.lengthSync());

    await drive?.files.create(file, uploadMedia: media).then((file) {
      setFilePublic(file.id!);
      id = file.id!;
    });
    const Savemessage(google_drive.createText).informAction(context);
    return id;
  }

  Future<String?> getOrCreateFolderId(String folderName,
      {String? parentFolderId}) async {
    try {
      var query =
          "'${parentFolderId ?? 'root'}' in parents and name = '$folderName' and mimeType = 'application/vnd.google-apps.folder' and trashed = false";
      var fileList = await drive?.files.list(q: query);

      if (fileList != null && fileList.files!.isNotEmpty) {
        return fileList.files!.first.id;
      }

      var folder = File()
        ..name = folderName
        ..mimeType = 'application/vnd.google-apps.folder'
        ..parents = parentFolderId != null ? [parentFolderId] : null;
      var createdFolder = await drive?.files.create(folder);

      return createdFolder?.id;
    } catch (e) {
      const PermissionErrorMessage(google_drive.getPathErrorText);
      return null;
    }
  }
}
