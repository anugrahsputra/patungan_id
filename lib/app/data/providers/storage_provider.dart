import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class StorageProvider {
  Future<String> uploadProfilePic(XFile file, Function(double)? onProgress);
  Future<String> defaultPicUrl(String imgNumber);
}

class StorageProviderImpl implements StorageProvider {
  final FirebaseStorage storage;

  StorageProviderImpl({required this.storage});

  @override
  Future<String> defaultPicUrl(String imgNumber) async {
    String url = await storage
        .ref("default_avatar/default($imgNumber).svg")
        .getDownloadURL();
    return url;
  }

  @override
  Future<String> uploadProfilePic(
      XFile file, Function(double p1)? onProgress) async {
    final storageRef = storage.ref('profile_image/${file.name}');
    final uploadTask = storageRef.putFile(File(file.path));

    uploadTask.snapshotEvents.listen((event) {
      final progress = event.bytesTransferred / event.totalBytes;
      onProgress?.call(progress);
    });

    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
