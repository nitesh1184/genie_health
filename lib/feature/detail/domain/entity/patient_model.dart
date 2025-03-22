import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final int id;
  final String uhid;
  final String barcode;
  final String name;
  final String labourId;
  final int age;
  final String gender;
  final String mobile;
  final String district;
  final String taluk;
  final String camp;
  final int labTestStatus;
  final String reportUrl;

  const Patient({
    required this.id,
    required this.uhid,
    required this.barcode,
    required this.name,
    required this.labourId,
    required this.age,
    required this.gender,
    required this.mobile,
    required this.district,
    required this.taluk,
    required this.camp,
    required this.labTestStatus,
    required this.reportUrl,
  });

  @override
  List<Object> get props => [
    id,
    uhid,
    barcode,
    name,
    labourId,
    age,
    gender,
    mobile,
    district,
    taluk,
    camp,
    labTestStatus,
    reportUrl,
  ];
}
