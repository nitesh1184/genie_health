import '../../domain/entities/lab_report_parameter_entity.dart';


class LabReportModel extends LabReportEntity {
  LabReportModel({
    required super.name,
    required super.department,
    required super.barCode,
    required super.parameters,
  });

  factory LabReportModel.fromJson(Map<String, dynamic> json) {
    return LabReportModel(
      name: json['name'] ?? '',
      department: json['department'] ?? '',
      barCode: json['bar_code'] ?? '',
      parameters: (json['parameters'] as List?)
          ?.map((e) => LabReportParameterEntityModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class LabReportParameterEntityModel extends LabReportParameterEntity {
  LabReportParameterEntityModel({
    required super.name,
    required super.uhid,
    required super.barCode,
    required super.parameterGroupName,
    required super.machineCode,
    required super.value,
    required super.unit,
    required super.comments,
  });

  factory LabReportParameterEntityModel.fromJson(Map<String, dynamic> json) {
    return LabReportParameterEntityModel(
      name: json['name'] ?? '',
      uhid: json['uhid'] ?? '',
      barCode: json['bar_code'] ?? '',
      parameterGroupName: json['parameter_group_name'] ?? '',
      machineCode: json['machine_code'] ?? '',
      value: json['value'] ?? '',
      unit: json['unit'] ?? '',
      comments: json['comments'] ?? '',
    );
  }
}