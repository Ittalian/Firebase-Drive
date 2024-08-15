class CategoryValidator {
  final String? value;
  const CategoryValidator({required this.value});

  validate() {
    if (value! == '') {
      return '入力してください';
    }
    return null;
  }
}
