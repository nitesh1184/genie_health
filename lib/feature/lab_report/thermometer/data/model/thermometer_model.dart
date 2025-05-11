import '../../domain/entity/thermometer_entity.dart';

class ThermometerModel extends ThermometerEntity {
  const ThermometerModel({
    required super.name,
    required super.department,
    required super.barCode,
    required super.parameters,
  });

  factory ThermometerModel.fromJson(Map<String, dynamic> json) => ThermometerModel(
    name: json["name"],
    department: json["department"],
    barCode: json["bar_code"],
    parameters: List<ThermoParameter>.from(
      json["parameters"].map((x) => ThermoParameterModel.fromJson(x)),
    ),
  );
}

class ThermoParameterModel extends ThermoParameter {
  const ThermoParameterModel({
    required super.name,
    required super.uhid,
    required super.barCode,
    required super.parameterGroupName,
    required super.machineCode,
    required super.value,
    required super.unit,
    required super.comments,
    required super.ranges,
  });

  factory ThermoParameterModel.fromJson(Map<String, dynamic> json) =>
      ThermoParameterModel(
        name: json["name"],
        uhid: json["uhid"],
        barCode: json["bar_code"],
        parameterGroupName: json["parameter_group_name"],
        machineCode: json["machine_code"],
        value: json["value"],
        unit: json["unit"],
        comments: json["comments"],
        ranges: List<Range>.from(
          json["ranges"].map((x) => RangeModel.fromJson(x)),
        ),
      );
}

class RangeModel extends Range {
  const RangeModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required super.minValue,
    required super.maxValue,
    required super.gender,
    required super.minAge,
    required super.maxAge,
    required super.inRangeInterpretation,
    required super.unit,
    required super.parameterId,
  });

  factory RangeModel.fromJson(Map<String, dynamic> json) => RangeModel(
    id: json["ID"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedAt: DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    minValue: json["min_value"],
    maxValue: json["max_value"],
    gender: json["gender"],
    minAge: json["min_age"],
    maxAge: json["max_age"],
    inRangeInterpretation: json["in_range_interpretation"],
    unit: json["unit"],
    parameterId: json["parameter_id"],
  );
}
