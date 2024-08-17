import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_drive/models/picture_category.dart';

class CategoryFirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<PictureCategory>> getCategories() {
    return db.collection('Category').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => PictureCategory.fromMap(doc.data(), doc.id))
        .toList());
  }

  Future<void> addCategory(PictureCategory category) {
    return db.collection('Category').add(category.toMap());
  }
}
