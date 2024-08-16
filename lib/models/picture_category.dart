class PictureCategory {
  final String categoryId;
  final String name;
  final String value;

  PictureCategory({
    required this.categoryId,
    required this.name,
    required this.value,
  });

  factory PictureCategory.fromMap(Map<String, dynamic> map, String categoryId) {
    return PictureCategory(
        categoryId: categoryId, name: map['name'] ?? '', value: map['value'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'name': name,
      'value': value,
    };
  }
}
