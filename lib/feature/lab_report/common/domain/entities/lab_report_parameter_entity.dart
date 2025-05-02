class LabReportEntity {
  final String name;
  final String department;
  final String barCode;
  final List<LabReportParameterEntity> parameters;

  LabReportEntity({
    required this.name,
    required this.department,
    required this.barCode,
    required this.parameters,
  });
}

class LabReportParameterEntity {
  final String name;
  final String value;
  final String unit;
  final String uhid;
  final String barCode;
  final String parameterGroupName;
  final String machineCode;
  final String comments;

  LabReportParameterEntity({
    required this.name,
    required this.value,
    required this.unit,
    required this.uhid,
    required this.barCode,
    required this.parameterGroupName,
    required this.machineCode,
    required this.comments,
  });
}