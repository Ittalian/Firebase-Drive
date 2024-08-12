class Picture {
  final String pictureId;
  final String driveId;
  final String categoryId;
  final String usedAppId;
  final bool favorite;

  Picture({
    required this.pictureId,
    required this.driveId,
    required this.categoryId,
    required this.usedAppId,
    required this.favorite,
  });

  factory Picture.fromMap(Map<String, dynamic> map, String documentId) {
    return Picture(
        pictureId: documentId,
        driveId: map['drive_id'] ?? '',
        categoryId: map['category_id'] ?? '',
        usedAppId: map['used_app_id'] ?? '',
        favorite: map['favorite'] ?? false);
  }

  Map<String, dynamic> toMap() {
    return {
      'drive_id': driveId,
      'category_id': categoryId,
      'used_app_id': usedAppId,
      'favorite': favorite,
    };
  }
}
