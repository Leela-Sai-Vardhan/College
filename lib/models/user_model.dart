import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  // Basic User Information
  String _userId = '';
  String _username = '';
  String _email = '';
  String _profilePicture = '';

  // Academic Data
  String _branch = '';
  double _cgpa = 0.0;
  double _attendance = 0.0;
  List<Map<String, dynamic>> _results = [];

  // Getters
  String get userId => _userId;
  String get username => _username;
  String get email => _email;
  String get profilePicture => _profilePicture;
  String get branch => _branch;
  double get cgpa => _cgpa;
  double get attendance => _attendance;
  List<Map<String, dynamic>> get results => _results;

  // Update User Data
  void updateUser({
    required String userId,
    required String username,
    required String email,
    String? profilePicture,
    String? branch,
    double? cgpa,
    double? attendance,
  }) {
    _userId = userId;
    _username = username;
    _email = email;

    if (profilePicture != null) {
      _profilePicture = profilePicture;
    }
    if (branch != null) {
      _branch = branch;
    }
    if (cgpa != null) {
      _cgpa = cgpa;
    }
    if (attendance != null) {
      _attendance = attendance;
    }
    notifyListeners();
  }

  // Add a result
  void addResult({required String type, required double value}) {
    _results.add({'type': type, 'value': value});
    _cgpa = _calculateCGPA(); // Recalculate CGPA when a new result is added
    notifyListeners();
  }

  // Calculate CGPA
  double _calculateCGPA() {
    if (_results.isEmpty) return 0.0;

    double totalScore = _results.fold(0, (sum, item) => sum + item['value']);
    return totalScore / _results.length;
  }

  // Update Attendance
  void updateAttendance(double newAttendance) {
    _attendance = newAttendance;
    notifyListeners();
  }
}
