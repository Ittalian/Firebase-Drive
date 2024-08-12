import 'package:firebase_drive/models/used_app.dart';
import 'package:firebase_drive/services/firestore_service.dart';

class UsedAppRepository {
  final FirestoreService firestoreService;

  UsedAppRepository(this.firestoreService);

  Stream<List<UsedApp>> getUsedApps() {
    return firestoreService.getUsedApps();
  }

  Future<void> addUsedApp(UsedApp usedApp) {
    return firestoreService.addUsedApp(usedApp);
  }
}
