import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class MediaService {
  static const AvatarsFolderName = 'avatars';
  static const UsersFolderName = 'users';
  static const GalleryFolderName = 'gallery';
  static const VideosFolderName = 'videos';

  final avatarStorage = FirebaseStorage.instance.ref(AvatarsFolderName);
  final userStorage = FirebaseStorage.instance.ref(UsersFolderName);
  final uuid = Uuid();

  Future<String> uploadAvatar(String userId, Uint8List avatarData) async {
    final avatarReference = avatarStorage.child(userId);
    await avatarReference.putData(avatarData);
    return await avatarReference.getDownloadURL();
  }

  Future<List<String>> uploadImages(String userId, List<String> imageFilesPaths) async {
    final galleryRef = _getUserGalleyReference(userId);

    final futures = imageFilesPaths.map((imagePath) async {
      var imageRef = galleryRef.child(uuid.v1());
      await imageRef.putFile(File(imagePath));
      return await imageRef.getDownloadURL();
    });

    return Future.wait(futures);
  }

  Future<void> deleteImages(List<String> imageUrls) async {
    final futures = imageUrls.map((imageUrl) async {
      final imageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      await imageRef.delete();
    });

    await Future.wait(futures);
  }

  Future<String> uploadVideo(String userId, String videoFilePath) async {
    final videoRef = _getUserVideosReference(userId).child(uuid.v1());
    await videoRef.putFile(File(videoFilePath));
    return await videoRef.getDownloadURL();
  }

  Future<void> deleteVideo(String videoUrl) async {
    final videoRef = FirebaseStorage.instance.refFromURL(videoUrl);
    await videoRef.delete();
  }

  Reference _getUserGalleyReference(String userId) {
    return userStorage.child(userId).child(GalleryFolderName);
  }

  Reference _getUserVideosReference(String userId) {
    return userStorage.child(userId).child(VideosFolderName);
  }
}