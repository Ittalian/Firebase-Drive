import 'package:firebase_drive/services/picture/picture_firestore_service.dart';
import '../models/picture.dart';

class PictureRepository {
  final PictureFirestoreService firestoreService;

  PictureRepository(this.firestoreService);

  Stream<List<Picture>> getPictures() {
    return firestoreService.getPictures();
  }

  Future<void> addPicture(Picture picture) {
    return firestoreService.addPicture(picture);
  }
}
