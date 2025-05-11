import 'package:equatable/equatable.dart';


class ScannedPatientEntity extends Equatable {
  final int totalCount;
  final List<ScannedPatient> data;


  const ScannedPatientEntity({
    required this.totalCount,
    required this.data,

  });

  @override
  List<Object?> get props => [data, totalCount];
}
class ScannedPatient extends Equatable {
  final String uuid;
  final DateTime registrationDate;
  final String name;
  final String billNo;
  final String tokenNo;
  final String uhid;
  final int paymentStatus;
  final int reportStatus;
  final String barcode;
  final String labourId;
  final int age;
  final String gender;
  final String mobile;
  final String reportUrl;
  final String taluk;
  final String village;
  final String district;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String createdBy;
  final String updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String campaignId;
  final String districtId;

  const ScannedPatient({
    required this.uuid,
    required this.registrationDate,
    required this.name,
    required this.billNo,
    required this.tokenNo,
    required this.uhid,
    required this.paymentStatus,
    required this.reportStatus,
    required this.barcode,
    required this.labourId,
    required this.age,
    required this.gender,
    required this.mobile,
    required this.reportUrl,
    required this.taluk,
    required this.village,
    required this.district,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.campaignId,
    required this.districtId,
  });

  @override
  List<Object?> get props => [
    uuid,
    registrationDate,
    name,
    billNo,
    tokenNo,
    uhid,
    paymentStatus,
    reportStatus,
    barcode,
    labourId,
    age,
    gender,
    mobile,
    reportUrl,
    taluk,
    village,
    district,
    firstName,
    lastName,
    dateOfBirth,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    campaignId,
    districtId,
  ];
}
