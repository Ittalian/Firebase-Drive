class UsedApp {
  final String? usedAppId;
  final String name;

  UsedApp({
    this.usedAppId,
    required this.name,
  });

  factory UsedApp.fromMap(Map<String, dynamic> map, String usedAppId) {
    return UsedApp(usedAppId: usedAppId, name: map['name'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
