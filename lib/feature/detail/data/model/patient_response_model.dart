import '../../domain/entity/patient_model.dart';

class PatientResponseModel extends Patient {
  const PatientResponseModel({
    required super.id,
    required super.uhid,
    required super.barcode,
    required super.name,
    required super.labourId,
    required super.age,
    required super.gender,
    required super.mobile,
    required super.district,
    required super.taluk,
    required super.camp,
    required super.labTestStatus,
    required super.reportUrl,
  });

  factory PatientResponseModel.fromJson(Map<String, dynamic> json) =>
      PatientResponseModel(
        id: json['ID'],
        uhid: json['Uhid'],
        barcode: json['Barcode'],
        name: json['Name'],
        labourId: json['LabourId'],
        age: json['Age'],
        gender: json['Gender'],
        mobile: json['Mobile'],
        district: json['District'],
        taluk: json['Taluk'],
        camp: json['Camp'],
        labTestStatus: json['LabTestStatus'],
        reportUrl: json['ReportUrl'],
      );
}
