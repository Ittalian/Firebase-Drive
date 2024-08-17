import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_drive/models/used_app.dart';

class UsedAppFirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<UsedApp>> getUsedApps() {
    return db.collection('UsedApp').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => UsedApp.fromMap(doc.data(), doc.id))
        .toList());
  }

  Future<void> addUsedApp(UsedApp usedApp) {
    return db.collection('UsedApp').add(usedApp.toMap());
  }
}
