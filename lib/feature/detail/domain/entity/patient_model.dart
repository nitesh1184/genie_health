import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final String uuid;
  final DateTime registrationDate;
  final ResponseType name;
  final ResponseType billNo;
  final ResponseType tokenNo;
  final ResponseType uhid;
  final Age paymentStatus;
  final Age reportStatus;
  final ResponseType barcode;
  final ResponseType labourId;
  final Age age;
  final ResponseType gender;
  final ResponseType mobile;
  final ResponseType reportUrl;
  final CreatedType createdBy;
  final CreatedType updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String campaignId;

  const Patient({
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
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.campaignId,
  });

  @override
  List<Object> get props => [
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
  createdBy,
  updatedBy,
  createdAt,
  updatedAt,
  campaignId,
  ];
}


class Age {
  int int16;
  bool valid;
  Age({required this.int16, required this.valid});
}

class ResponseType {
  String string;
  bool valid;

  ResponseType({required this.string, required this.valid});
}

class CreatedType {
  String uuid;
  ResponseType name;
  ResponseType userId;
  ResponseType userType;

  CreatedType({
    required this.uuid,
    required this.name,
    required this.userId,
    required this.userType,
  });
}
