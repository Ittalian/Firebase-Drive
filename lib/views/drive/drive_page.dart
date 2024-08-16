import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:firebase_drive/routes.dart';
import 'package:firebase_drive/utils/google_drive/google_drive.dart';
import 'package:firebase_drive/utils/message/error_message/permission_error_message.dart';
import 'package:firebase_drive/utils/validator/drive/filename_validator.dart';
import 'package:firebase_drive/widgets/textform_field/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DrivePage extends StatefulWidget {
  const DrivePage({super.key});

  @override
  State<DrivePage> createState() => _DrivePageState();
}

class _DrivePageState extends State<DrivePage> {
  String saveText = 'アップロード';
  String selectFileText = 'ファイルを選択する';
  final TextEditingController fileNameController = TextEditingController();
  String fileName = '';
  bool isFileFound = false;
  File sourceFile = File('');
  String errorText = 'アクセスが許可されていません';
  String fileErrorText = 'ファイルエラーです';
  String fileNotFoundErrorText = 'ファイルが見つかりません';

  @override
  void initState() {
    super.initState();
  }

  String getDriveFileName() {
    DateTime now = DateTime.now();
    String formattedDateTime = "${now.year}${now.month}${(now.day)}"
        "${(now.hour)}${(now.minute)}${(now.second)}${now.microsecond}";
    return '$formattedDateTime.jpg';
  }

  Future<void> getDownloadFile() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final status = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;
    if (status.isGranted) {
      try {
        String downloadsPath =
            await ExternalPath.getExternalStoragePublicDirectory(
                ExternalPath.DIRECTORY_DOWNLOADS);
        Directory downloadsDir = Directory(downloadsPath);

        List<FileSystemEntity> fileList = downloadsDir.listSync().where((file) {
          String filePath = file.path.toLowerCase();
          return FileSystemEntity.isFileSync(filePath) &&
              (filePath.endsWith('.jpg'));
        }).toList();
        for (var file in fileList) {
          if (file.path == '/storage/emulated/0/Download/$fileName.jpg') {
            setState(() {
              sourceFile = File(file.path);
            });
            isFileFound = true;
            break;
          }
        }
        if (!isFileFound) {
          PermissionErrorMessage(fileNotFoundErrorText).informAction(context);
        }
      } catch (e) {
        PermissionErrorMessage(errorText).informAction(context);
      }
    } else {
      PermissionErrorMessage(fileErrorText).informAction(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GoogleDrive googleDrive = GoogleDrive(context: context);
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/drive_background.jpg'),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
                color: Colors.white,
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                margin: const EdgeInsets.fromLTRB(35, 0, 35, 20),
                child: CustomTextformfield(
                  controller: fileNameController,
                  labelText: 'ファイル名',
                  onChanged: (value) {
                    setState(() {
                      fileName = value;
                    });
                  },
                  validator: (value) =>
                      FilenameValidator(value: value).validate(),
                )),
            Container(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                    icon: const Icon(Icons.file_copy_outlined),
                    onPressed: () {},
                    label: Text(selectFileText,
                        style: const TextStyle(fontSize: 20)))),
            Container(
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                    icon: const Icon(Icons.upload_file),
                    onPressed: () async {
                      String fileName = getDriveFileName();
                      await getDownloadFile();
                      await googleDrive.signIn();
                      String driveId =
                          await googleDrive.upload(sourceFile.path, fileName);
                      Navigator.pushNamed(context, AppRoutes.firebasePage,
                          arguments: driveId);
                    },
                    label:
                        Text(saveText, style: const TextStyle(fontSize: 20)))),
            const Padding(padding: EdgeInsets.only(top: 50)),
          ]),
        ));
  }
}
