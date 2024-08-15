import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:firebase_drive/utils/google_drive/google_drive.dart' as drive;
import 'package:firebase_drive/utils/message/error_message/permission_error_message.dart';
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
  File file = File('/storage/emulated/0/Download/IMG_5839.jpg');

  @override
  void initState() {
    super.initState();
  }

  Future<void> getDownloadFile() async {
    String errorText = 'アクセスが許可されていません';
    String fileErrorText = 'ファイルエラーです';
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final status = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;
    if (status.isGranted) {
      await Permission.storage.request();
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
        File sourceFile = File(fileList.first.path);
        setState(() {
          file = sourceFile;
        });
      } catch (e) {
        PermissionErrorMessage(errorText).informAction(context);
      }
    } else {
      PermissionErrorMessage(fileErrorText).informAction(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/drive_background.jpg'),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                      // await getDownloadFile();
                      await drive.signIn();
                      await drive.upload(file.path, 'sample.jpg');
                    },
                    label:
                        Text(saveText, style: const TextStyle(fontSize: 20)))),
            const Padding(padding: EdgeInsets.only(top: 50)),
          ]),
        ));
  }
}
