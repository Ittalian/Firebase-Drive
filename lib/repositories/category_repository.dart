import 'package:firebase_drive/services/firestore_service.dart';
import '../models/picture_category.dart';

class CategoryRepository {
  final FirestoreService firestoreService;

  CategoryRepository(this.firestoreService);

  Stream<List<PictureCategory>> getCategories() {
    return firestoreService.getCategories();
  }

  Future<void> addCategory(PictureCategory category) {
    return firestoreService.addCategory(category);
  }
}
