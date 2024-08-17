import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_drive/models/picture.dart';

class PictureFirestoreService {
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
}
