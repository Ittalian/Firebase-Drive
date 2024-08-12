import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_drive/models/used_app.dart';
import '../models/picture.dart';
import 'package:firebase_drive/models/picture_category.dart';

class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  //Pictureテーブル
  Stream<List<Picture>> getPictures() {
    return db.collection('Picture').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Picture.fromMap(doc.data(), doc.id))
        .toList());
  }

  Future<void> addPicture(Picture picture) {
    return db.collection('Picture').add(picture.toMap());
  }

  // UsedAppテーブル
  Stream<List<UsedApp>> getUsedApps() {
    return db.collection('UsedApp').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => UsedApp.fromMap(doc.data(), doc.id))
        .toList());
  }

  Future<void> addUsedApp(UsedApp usedApp) {
    return db.collection('UsedApp').add(usedApp.toMap());
  }

  // Categoryテーブル
  Stream<List<PictureCategory>> getCategories() {
    return db.collection('Category').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => PictureCategory.fromMap(doc.data(), doc.id))
        .toList());
  }

  Future<void> addCategory(PictureCategory category) {
    return db.collection('Category').add(category.toMap());
  }
}
