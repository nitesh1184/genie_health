import '../../domain/entity/previously_scanned_patient.dart';

class ScannedPatientListModel extends ScannedPatientList{
  const ScannedPatientListModel({
    required super.uuid,
    required super.registrationDate,
    required super.name,
    required super.billNo,
    required super.tokenNo,
    required super.uhid,
    required super.paymentStatus,
    required super.reportStatus,
    required super.barcode,
    required super.labourId,
    required super.age,
    required super.gender,
    required super.mobile,
    required super.reportUrl,
    required super.taluk,
    required super.firstName,
    required super.lastName,
    required super.dateOfBirth,
    required super.createdBy,
    required super.updatedBy,
    required super.createdAt,
    required super.updatedAt,
    required super.campaignId,
    required super.districtId,
});

  factory ScannedPatientListModel.fromJson(Map<String, dynamic> json) {
    return ScannedPatientListModel(
      uuid: json["uuid"],
      registrationDate: DateTime.parse(json["registration_date"]),
      name: json["name"],
      billNo: json["bill_no"],
      tokenNo: json["token_no"],
      uhid: json["uhid"],
      paymentStatus: json["payment_status"],
      reportStatus: json["report_status"],
      barcode: json["barcode"],
      labourId: json["labour_id"],
      age: json["age"],
      gender: json["gender"],
      mobile: json["mobile"],
      reportUrl: json["report_url"],
      taluk: json["taluk"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      dateOfBirth: DateTime.parse(json["date_of_birth"]),
      createdBy: json["created_by"],
      updatedBy: json["updated_by"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      campaignId: json["campaign_id"],
      districtId: json["district_id"],
    );
  }
}