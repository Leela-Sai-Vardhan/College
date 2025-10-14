import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  // Basic User Information
  String _userId = '';
  String _username = '';
  String _email = '';
  String _profilePicture = '';

  // Academic Data
  String _branch = '';
  String _department = '';
  String _semester = '';
  String _section = '';
  String _rollNumber = '';
  String _batch = '';
  double _cgpa = 0.0;
  double _attendance = 0.0;
  final List<Map<String, dynamic>> _results = [];

  // ---------------- Getters ----------------
  String get userId => _userId;
  String get username => _username;
  String get email => _email;
  String get profilePicture => _profilePicture;
  String get branch => _branch;
  String get department => _department;
  String get semester => _semester;
  String get section => _section;
  String get rollNumber => _rollNumber;
  String get batch => _batch;
  double get cgpa => _cgpa;
  double get attendance => _attendance;
  List<Map<String, dynamic>> get results => _results;

  // ---------------- Update User Data ----------------
  void updateUser({
    required String userId,
    required String username,
    required String email,
    String? profilePicture,
    String? branch,
    String? department,
    String? semester,
    String? section,
    String? rollNumber,
    String? batch,
    double? cgpa,
    double? attendance,
  }) {
    _userId = userId;
    _username = username;
    _email = email;

    if (profilePicture != null) _profilePicture = profilePicture;
    if (branch != null) _branch = branch;
    if (department != null) _department = department;
    if (semester != null) _semester = semester;
    if (section != null) _section = section;
    if (rollNumber != null) _rollNumber = rollNumber;
    if (batch != null) _batch = batch;
    if (cgpa != null) _cgpa = cgpa;
    if (attendance != null) _attendance = attendance;

    notifyListeners();
  }

  // ---------------- Add Result ----------------
  void addResult({required String type, required double value}) {
    _results.add({'type': type, 'value': value});
    _cgpa = _calculateCGPA(); // Recalculate CGPA when a new result is added
    notifyListeners();
  }

  // ---------------- Calculate CGPA ----------------
  double _calculateCGPA() {
    if (_results.isEmpty) return 0.0;

    double totalScore = _results.fold(0, (sum, item) => sum + item['value']);
    return totalScore / _results.length;
  }

  // ---------------- Update Attendance ----------------
  void updateAttendance(double newAttendance) {
    _attendance = newAttendance;
    notifyListeners();
  }
}
