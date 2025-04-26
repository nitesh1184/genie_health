import '../../domain/entity/user.dart';

class UserModel extends User{
  
  UserModel({
    required super.id,
    required super.userName,
    required super.userId,
    required super.password,
    required super.mobile,
    required super.emergencyContactNumber,
    required super.emailId,
    required super.gender,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.ctc,
    required super.isActive,
    required super.dateOfBirth,
    required super.dateOfJoining,
    required super.lastWorkingDay,
    required super.roleId,
});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["ID"],
    userName: json["user_name"],
    userId: json["user_id"],
    password: json["password"],
    mobile: json["mobile"],
    emergencyContactNumber: json["emergency_contact_number"],
    emailId: json["email_id"],
    gender: json["gender"],
    firstName: json["first_name"],
    middleName: json[" middle_name"],
    lastName: json["last_name"],
    ctc: json["ctc"],
    isActive: json["is_active"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    dateOfJoining: DateTime.parse(json["date_of_joining"]),
    lastWorkingDay: DateTime.parse(json["last_working_day"]),
    roleId: json["role_id"],
  );


}