class SimpleValidator {
  final String? value;
  const SimpleValidator({required this.value});

  validate() {
    if (value! == '') {
      return '入力してください';
    }
    return null;
  }
}
