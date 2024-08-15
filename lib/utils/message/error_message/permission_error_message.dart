import 'package:firebase_drive/utils/message/message.dart';

class PermissionErrorMessage extends Message {
  const PermissionErrorMessage(String errorText) : super(message: errorText);
}
