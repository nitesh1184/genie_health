import 'package:equatable/equatable.dart';

class ThermometerEntity extends Equatable {
  final String name;
  final String department;
  final String barCode;
  final List<ThermoParameter> parameters;

  const ThermometerEntity({
    required this.name,
    required this.department,
    required this.barCode,
    required this.parameters,
  });

  @override
  List<Object> get props => [name, department, barCode, parameters];
}

class ThermoParameter extends Equatable {
  final String name;
  final String uhid;
  final String barCode;
  final String parameterGroupName;
  final String machineCode;
  final String value;
  final String unit;
  final String comments;
  final List<Range> ranges;

  const ThermoParameter({
    required this.name,
    required this.uhid,
    required this.barCode,
    required this.parameterGroupName,
    required this.machineCode,
    required this.value,
    required this.unit,
    required this.comments,
    required this.ranges,
  });

  @override
  List<Object> get props => [
    name,
    uhid,
    barCode,
    parameterGroupName,
    machineCode,
    value,
    unit,
    comments,
    ranges,
  ];
}

class Range extends Equatable {

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;
  final String minValue;
  final String maxValue;
  final String gender;
  final String minAge;
  final String maxAge;
  final String inRangeInterpretation;
  final String unit;
  final String parameterId;

  const Range({
    required this.id,
  required this.createdAt,
   required this.updatedAt,
    required this.deletedAt,
    required this.minValue,
    required this.maxValue,
    required this.gender,
    required this.minAge,
    required this.maxAge,
    required this.inRangeInterpretation,
    required this.unit,
    required this.parameterId,
  });
  @override
  List<Object> get props => [
  id,
  createdAt,
  updatedAt,
  deletedAt,
  minValue,
  maxValue,
  gender,
  minAge,
  maxAge,
  inRangeInterpretation,
  unit,
  parameterId,
  ];
}
