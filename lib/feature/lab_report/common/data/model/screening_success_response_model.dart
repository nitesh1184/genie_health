

import '../../domain/entities/screening_success_response_entity.dart';

class ScreeningSuccessResponseModel extends ScreeningSuccessResponse {
  ScreeningSuccessResponseModel({required super.message, required super.parameterGroup});

  factory ScreeningSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    return ScreeningSuccessResponseModel(
      message: json['message'] ?? '',
      parameterGroup: ParameterGroupModel.fromJson(json["paramter_group"]),
    );
  }
}

class ParameterGroupModel extends ParameterGroup {
  ParameterGroupModel({
    required super.name,
    required super.barCode,
    required super.department,
    required super.parameters,
  });
  factory ParameterGroupModel.fromJson(Map<String, dynamic> json) =>
      ParameterGroupModel(
        name: json["name"],
        department: json["department"],
        barCode: json["bar_code"],
        parameters: List<Parameter>.from(
          json["parameters"].map((x) => ParameterModel.fromJson(x)),
        ),
      );
}

class ParameterModel extends Parameter {
  ParameterModel({
    required super.name,
    required super.uhid,
    required super.barCode,
    required super.parameterGroupName,
    required super.machineCode,
    required super.value,
    required super.unit,
    required super.comments,
  });

  factory ParameterModel.fromJson(Map<String, dynamic> json) => ParameterModel(
    name: json["name"],
    uhid: json["uhid"],
    barCode: json["bar_code"],
    parameterGroupName: json["parameter_group_name"],
    machineCode: json["machine_code"],
    value: json["value"],
    unit: json["unit"],
    comments: json["comments"],
  );
}
