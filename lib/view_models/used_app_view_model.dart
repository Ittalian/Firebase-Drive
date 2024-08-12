import 'package:firebase_drive/repositories/used_app_repository.dart';
import 'package:flutter/foundation.dart';
import '../models/used_app.dart';

class UsedAppViewModel extends ChangeNotifier {
  final UsedAppRepository usedAppRepository;

  List<UsedApp> _usedApps = [];
  List<UsedApp> get usedApps => _usedApps;

  UsedAppViewModel(this.usedAppRepository) {
    fetchUsedApps();
  }

  void fetchUsedApps() {
    usedAppRepository.getUsedApps().listen((usedAppList) {
      _usedApps = usedAppList;
      notifyListeners();
    });
  }

  Future<void> addUsedApp(UsedApp usedApp) async {
    await usedAppRepository.addUsedApp(usedApp);
  }
}
