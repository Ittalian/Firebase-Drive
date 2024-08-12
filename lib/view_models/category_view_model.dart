import 'package:firebase_drive/repositories/category_repository.dart';
import 'package:flutter/foundation.dart';
import '../models/picture_category.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository categoryRepository;

  List<PictureCategory> _categories = [];
  List<PictureCategory> get categories => _categories;

  CategoryViewModel(this.categoryRepository) {
    fetchCategories();
  }

  void fetchCategories() {
    categoryRepository.getCategories().listen((categoryList) {
      _categories = categoryList;
      notifyListeners();
    });
  }
}
