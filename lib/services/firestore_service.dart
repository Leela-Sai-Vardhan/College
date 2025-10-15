import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Check if user profile exists
  Future<bool> userExists(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      return doc.exists;
    } catch (e) {
      print('Error checking user existence: $e');
      return false;
    }
  }

  // Create initial user profile (on first login)
  Future<void> createUserProfile({
    required String userId,
    required String email,
    required String rollNumber,
    String? displayName,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'personalInfo': {
          'username': displayName ?? 'Student',
          'email': email,
          'profilePicture': '',
          'phone': '',
          'dateOfBirth': null,
          'address': '',
        },
        'academicInfo': {
          'rollNumber': rollNumber,
          'branch': '',
          'department': '',
          'semester': '',
          'section': '',
          'batch': '',
          'cgpa': 0.0,
        },
        'performance': {
          'attendance': 0.0,
          'results': [],
        },
        'metadata': {
          'createdAt': FieldValue.serverTimestamp(),
          'lastUpdated': FieldValue.serverTimestamp(),
          'profileCompleted': false,
        }
      });
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  // Fetch complete user data
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  // Update personal information
  Future<void> updatePersonalInfo(
      String userId, Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> updateData = {};
      data.forEach((key, value) {
        updateData['personalInfo.$key'] = value;
      });
      updateData['metadata.lastUpdated'] = FieldValue.serverTimestamp();

      await _firestore.collection('users').doc(userId).update(updateData);
    } catch (e) {
      throw Exception('Failed to update personal info: $e');
    }
  }

  // Update academic information
  Future<void> updateAcademicInfo(
      String userId, Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> updateData = {};
      data.forEach((key, value) {
        updateData['academicInfo.$key'] = value;
      });
      updateData['metadata.lastUpdated'] = FieldValue.serverTimestamp();

      await _firestore.collection('users').doc(userId).update(updateData);
    } catch (e) {
      throw Exception('Failed to update academic info: $e');
    }
  }

  // Mark profile as completed
  Future<void> markProfileCompleted(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'metadata.profileCompleted': true,
        'metadata.lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to mark profile completed: $e');
    }
  }

  // Update attendance
  Future<void> updateAttendance(String userId, double attendance) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'performance.attendance': attendance,
        'metadata.lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update attendance: $e');
    }
  }

  // Add semester result
  Future<void> addResult(String userId, Map<String, dynamic> result) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'performance.results': FieldValue.arrayUnion([result]),
        'metadata.lastUpdated': FieldValue.serverTimestamp(),
      });

      // Recalculate CGPA
      await _recalculateCGPA(userId);
    } catch (e) {
      throw Exception('Failed to add result: $e');
    }
  }

  // Recalculate CGPA based on results
  Future<void> _recalculateCGPA(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List results = data['performance']['results'] ?? [];

        if (results.isEmpty) return;

        double totalGPA = 0.0;
        for (var result in results) {
          totalGPA += result['gpa'] ?? 0.0;
        }
        double cgpa = totalGPA / results.length;

        await _firestore.collection('users').doc(userId).update({
          'academicInfo.cgpa': cgpa,
        });
      }
    } catch (e) {
      print('Error recalculating CGPA: $e');
    }
  }

  // Upload profile picture to Firebase Storage
  Future<String> uploadProfilePicture({
    required String userId,
    required String filePath,
  }) async {
    File file = File(filePath);
    try {
      TaskSnapshot snapshot = await _storage
          .ref()
          .child('profile_pictures/$userId.jpg')
          .putFile(file);

      String downloadURL = await snapshot.ref.getDownloadURL();

      // Update Firestore with new profile picture URL
      await updatePersonalInfo(userId, {'profilePicture': downloadURL});

      return downloadURL;
    } catch (e) {
      throw Exception('Failed to upload profile picture: $e');
    }
  }

  // Check if profile is completed
  Future<bool> isProfileCompleted(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['metadata']['profileCompleted'] ?? false;
      }
      return false;
    } catch (e) {
      print('Error checking profile completion: $e');
      return false;
    }
  }

  // Update user details (legacy method - keeping for backward compatibility)
  Future<void> updateUserDetails(
      String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update(data);
    } catch (e) {
      throw Exception('Failed to update user details: $e');
    }
  }
}
