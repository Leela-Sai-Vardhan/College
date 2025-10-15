import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String _userId = '';
  String _username = '';
  String _email = '';
  String _profilePicture = '';
  String _phone = '';
  String _address = '';
  DateTime? _dateOfBirth;
  String _branch = '';
  String _department = '';
  String _semester = '';
  String _section = '';
  String _rollNumber = '';
  String _batch = '';
  double _cgpa = 0.0;
  double _attendance = 0.0;
  List<Map<String, dynamic>> _results = [];
  bool _profileCompleted = false;

  String get userId => _userId;
  String get username => _username;
  String get email => _email;
  String get profilePicture => _profilePicture;
  String get phone => _phone;
  String get address => _address;
  DateTime? get dateOfBirth => _dateOfBirth;
  String get branch => _branch;
  String get department => _department;
  String get semester => _semester;
  String get section => _section;
  String get rollNumber => _rollNumber;
  String get batch => _batch;
  double get cgpa => _cgpa;
  double get attendance => _attendance;
  List<Map<String, dynamic>> get results => _results;
  bool get profileCompleted => _profileCompleted;

  void loadUserData(Map<String, dynamic> data) {
    final personalInfo = data['personalInfo'] ?? {};
    _username = personalInfo['username'] ?? '';
    _email = personalInfo['email'] ?? '';
    _profilePicture = personalInfo['profilePicture'] ?? '';
    _phone = personalInfo['phone'] ?? '';
    _address = personalInfo['address'] ?? '';
    if (personalInfo['dateOfBirth'] != null) {
      _dateOfBirth = (personalInfo['dateOfBirth'] as dynamic).toDate();
    }
    final academicInfo = data['academicInfo'] ?? {};
    _rollNumber = academicInfo['rollNumber'] ?? '';
    _branch = academicInfo['branch'] ?? '';
    _department = academicInfo['department'] ?? '';
    _semester = academicInfo['semester'] ?? '';
    _section = academicInfo['section'] ?? '';
    _batch = academicInfo['batch'] ?? '';
    _cgpa = (academicInfo['cgpa'] ?? 0.0).toDouble();
    final performance = data['performance'] ?? {};
    _attendance = (performance['attendance'] ?? 0.0).toDouble();
    _results = List<Map<String, dynamic>>.from(performance['results'] ?? []);
    final metadata = data['metadata'] ?? {};
    _profileCompleted = metadata['profileCompleted'] ?? false;
    _userId = data['userId'] ?? _userId;
    notifyListeners();
  }

  void updateUser({
    required String userId,
    required String username,
    required String email,
    String? profilePicture,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
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
    if (phone != null) _phone = phone;
    if (address != null) _address = address;
    if (dateOfBirth != null) _dateOfBirth = dateOfBirth;
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

  void updatePersonalInfo({
    String? username,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? profilePicture,
  }) {
    if (username != null) _username = username;
    if (phone != null) _phone = phone;
    if (address != null) _address = address;
    if (dateOfBirth != null) _dateOfBirth = dateOfBirth;
    if (profilePicture != null) _profilePicture = profilePicture;
    notifyListeners();
  }

  void updateAcademicInfo({
    String? branch,
    String? department,
    String? semester,
    String? section,
    String? batch,
    double? cgpa,
  }) {
    if (branch != null) _branch = branch;
    if (department != null) _department = department;
    if (semester != null) _semester = semester;
    if (section != null) _section = section;
    if (batch != null) _batch = batch;
    if (cgpa != null) _cgpa = cgpa;
    notifyListeners();
  }

  void addResult(Map<String, dynamic> result) {
    _results.add(result);
    _cgpa = _calculateCGPA();
    notifyListeners();
  }

  double _calculateCGPA() {
    if (_results.isEmpty) return 0.0;
    double totalGPA =
        _results.fold(0, (sum, item) => sum + (item['gpa'] ?? 0.0));
    return totalGPA / _results.length;
  }

  void updateAttendance(double newAttendance) {
    _attendance = newAttendance;
    notifyListeners();
  }

  void markProfileCompleted() {
    _profileCompleted = true;
    notifyListeners();
  }

  int getProfileCompletionPercentage() {
    int filledFields = 0;
    int totalFields = 11;
    if (_username.isNotEmpty) filledFields++;
    if (_email.isNotEmpty) filledFields++;
    if (_phone.isNotEmpty) filledFields++;
    if (_address.isNotEmpty) filledFields++;
    if (_dateOfBirth != null) filledFields++;
    if (_rollNumber.isNotEmpty) filledFields++;
    if (_branch.isNotEmpty) filledFields++;
    if (_semester.isNotEmpty) filledFields++;
    if (_section.isNotEmpty) filledFields++;
    if (_batch.isNotEmpty) filledFields++;
    if (_profilePicture.isNotEmpty) filledFields++;
    return ((filledFields / totalFields) * 100).round();
  }

  void resetUser() {
    _userId = '';
    _username = '';
    _email = '';
    _profilePicture = '';
    _phone = '';
    _address = '';
    _dateOfBirth = null;
    _branch = '';
    _department = '';
    _semester = '';
    _section = '';
    _rollNumber = '';
    _batch = '';
    _cgpa = 0.0;
    _attendance = 0.0;
    _results = [];
    _profileCompleted = false;
    notifyListeners();
  }
}
