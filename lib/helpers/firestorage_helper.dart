import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  FirebaseStorageHelper._();

  static FirebaseStorageHelper firebaseStorageHelper =
      FirebaseStorageHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(File file,[folderName ='profiles']) async {
    //1-make a refrence for this file in firebase storage
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = 'images/$folderName/$fileName';
    Reference reference = firebaseStorage.ref(path);

    //2- upload the file to the defined reference
    await reference.putFile(file);

    //3 get the file url
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }
}
