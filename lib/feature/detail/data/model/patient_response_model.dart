import '../../domain/entity/patient_model.dart';

class PatientModel extends Patient {
  const PatientModel({
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
    required super.createdBy,
    required super.updatedBy,
    required super.createdAt,
    required super.updatedAt,
    required super.campaignId,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      uuid: json['uuid'],
      registrationDate: DateTime.parse(json['registration_date']),
      name: ResponseTypeModel.fromJson(json['name']),
      billNo: ResponseTypeModel.fromJson(json['bill_no']),
      tokenNo: ResponseTypeModel.fromJson(json['token_no']),
      uhid: ResponseTypeModel.fromJson(json['uhid']),
      paymentStatus: AgeModel.fromJson(json['payment_status']),
      reportStatus: AgeModel.fromJson(json['report_status']),
      barcode: ResponseTypeModel.fromJson(json['barcode']),
      labourId: ResponseTypeModel.fromJson(json['labour_id']),
      age: AgeModel.fromJson(json['age']),
      gender: ResponseTypeModel.fromJson(json['gender']),
      mobile: ResponseTypeModel.fromJson(json['mobile']),
      reportUrl: ResponseTypeModel.fromJson(json['report_url']),
      createdBy: CreatedTypeModel.fromJson(json['createdBy']),
      updatedBy: CreatedTypeModel.fromJson(json['updatedBy']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      campaignId: json['campaign_id'],
    );
  }
}

class AgeModel extends Age {
  AgeModel({required super.int16, required super.valid});

  factory AgeModel.fromJson(Map<String, dynamic> json) {
    return AgeModel(int16: json['Int16'], valid: json['Valid']);
  }
}

class ResponseTypeModel extends ResponseType {
  ResponseTypeModel({required super.string, required super.valid});

  factory ResponseTypeModel.fromJson(Map<String, dynamic> json) {
    return ResponseTypeModel(string: json['String'], valid: json['Valid']);
  }
}

class CreatedTypeModel extends CreatedType {
  CreatedTypeModel({
    required super.uuid,
    required super.name,
    required super.userId,
    required super.userType,
  });

  factory CreatedTypeModel.fromJson(Map<String, dynamic> json) {
    return CreatedTypeModel(
      uuid: json['uuid'],
      name: ResponseTypeModel.fromJson(json['name']),
      userId: ResponseTypeModel.fromJson(json['userId']),
      userType: ResponseTypeModel.fromJson(json['userType']),
    );
  }
}
