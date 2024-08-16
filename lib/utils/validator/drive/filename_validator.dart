class FilenameValidator {
  final String? value;
  const FilenameValidator({required this.value});

  validate() {
    if (value!.isEmpty) {
      return '入力して下さい';
    }
    return null;
  }
}
