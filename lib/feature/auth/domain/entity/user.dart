class User {
  int id;
  String userName;
  String userId;
  String password;
  String mobile;
  String emergencyContactNumber;
  String emailId;
  String gender;
  String firstName;
  String middleName;
  String lastName;
  String ctc;
  bool isActive;
  DateTime dateOfBirth;
  DateTime dateOfJoining;
  DateTime lastWorkingDay;
  String roleId;

  User({
    required this.id,
    required this.userName,
    required this.userId,
    required this.password,
    required this.mobile,
    required this.emergencyContactNumber,
    required this.emailId,
    required this.gender,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.ctc,
    required this.isActive,
    required this.dateOfBirth,
    required this.dateOfJoining,
    required this.lastWorkingDay,
    required this.roleId,
});
}