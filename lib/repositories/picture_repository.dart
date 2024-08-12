import '../models/picture.dart';
import '../services/firestore_service.dart';

class PictureRepository {
  final FirestoreService firestoreService;

  PictureRepository(this.firestoreService);

  Stream<List<Picture>> getPictures() {
    return firestoreService.getPictures();
  }

  Future<void> addPicture(Picture picture) {
    return firestoreService.addPicture(picture);
  }
}
