import 'package:firebase_drive/models/used_app.dart';
import 'package:firebase_drive/services/used_app/used_app_firestore_service.dart';

class UsedAppRepository {
  final UsedAppFirestoreService firestoreService;

  UsedAppRepository(this.firestoreService);

  Stream<List<UsedApp>> getUsedApps() {
    return firestoreService.getUsedApps();
  }

  Future<void> addUsedApp(UsedApp usedApp) {
    return firestoreService.addUsedApp(usedApp);
  }
}
