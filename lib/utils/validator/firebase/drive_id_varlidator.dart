class DriveIdValidator {
  final String? value;
  const DriveIdValidator({required this.value});

  validate() {
    final driveIdReg = RegExp(r'^[^ -~｡-ﾟ]');
    if (value!.isEmpty) {
      return '入力して下さい';
    } else if (driveIdReg.hasMatch(value!)) {
      return 'IDは半角英数字です';
    }
    return null;
  }
}
