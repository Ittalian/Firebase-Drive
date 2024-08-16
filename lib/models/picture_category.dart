class PictureCategory {
  final String categoryId;
  final String value;

  PictureCategory({
    required this.categoryId,
    required this.value,
  });

  factory PictureCategory.fromMap(Map<String, dynamic> map, String categoryId) {
    return PictureCategory(
        categoryId: categoryId, value: map['value'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'value': value,
    };
  }
}
