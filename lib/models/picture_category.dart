class PictureCategory {
  final String categoryId;
  final String name;

  PictureCategory({
    required this.categoryId,
    required this.name,
  });

  factory PictureCategory.fromMap(Map<String, dynamic> map, String categoryId) {
    return PictureCategory(categoryId: categoryId, name: map['name'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'name': name,
    };
  }
}
