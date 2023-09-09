import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseStorageService {
  Future<String> uploadFile({
    required File file,
  });
  factory FirebaseStorageService() => _FirebaseStorageService();
}

class _FirebaseStorageService implements FirebaseStorageService {
  @override
  Future<String> uploadFile({required File file}) async {
    String imageUrl;
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('card_images')
          .child('${DateTime.now()}.png');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      rethrow;
    }
  }
}