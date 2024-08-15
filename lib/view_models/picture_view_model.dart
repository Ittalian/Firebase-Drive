import 'package:flutter/foundation.dart';
import '../models/picture.dart';
import 'package:firebase_drive/repositories/picture_repository.dart';

class PictureViewModel extends ChangeNotifier {
  final PictureRepository pictureRepository;

  List<Picture> _pictures = [];
  List<Picture> get pictures => _pictures;

  PictureViewModel(this.pictureRepository) {
    fetchPictures();
  }

  void fetchPictures() {
    pictureRepository.getPictures().listen((pictureList) {
      _pictures = pictureList;
      notifyListeners();
    });
  }

  Future<void> addPicture(Picture picture) async {
    await pictureRepository.addPicture(picture);
    print(picture.pictureId);
  }
}
