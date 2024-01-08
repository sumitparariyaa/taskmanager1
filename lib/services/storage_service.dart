import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../constants.dart';


class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfilePicture(String userId, File image) async {
    try {
      String filePath = '${Constants.storagePath}$userId.jpg';
      await _storage.ref(filePath).putFile(image);
      String downloadUrl = await _storage.ref(filePath).getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return "";
    }
  }
}
