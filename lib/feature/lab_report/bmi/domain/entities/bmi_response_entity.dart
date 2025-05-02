class BMIResponse {
  String message;
  ParameterGroup parameterGroup;

  BMIResponse({
    required this.message,
    required this.parameterGroup,
  });

}

class ParameterGroup {
  String name;
  String department;
  String barCode;
  List<Parameter> parameters;

  ParameterGroup({
    required this.name,
    required this.department,
    required this.barCode,
    required this.parameters,
  });
}

class Parameter {
  String name;
  String uhid;
  String barCode;
  String parameterGroupName;
  String machineCode;
  String value;
  String unit;
  String comments;

  Parameter({
    required this.name,
    required this.uhid,
    required this.barCode,
    required this.parameterGroupName,
    required this.machineCode,
    required this.value,
    required this.unit,
    required this.comments,
  });
}

