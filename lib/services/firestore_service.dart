import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Update user details in Firestore
  Future<void> updateUserDetails(
      String userId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(data);
  }

  // Upload profile picture to Firebase Storage
  Future<String> uploadProfilePicture(
      {required String userId, required String filePath}) async {
    File file = File(filePath);
    try {
      TaskSnapshot snapshot = await _storage
          .ref()
          .child('profile_pictures/$userId.jpg')
          .putFile(file);

      // Get the download URL of the uploaded file
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload profile picture: $e');
    }
  }
}
