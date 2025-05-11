import 'package:equatable/equatable.dart';

class HealthCheck extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String uhid;
  final String barCode;
  final bool paid;
  final bool cleared;
  final bool isUnbilled;
  final bool isVerified;
  final bool completed;
  final String billNumber;
  final int token;
  final DateTime reportDate;
  final String status;
  final String labourId;
  final String campaignId;
  final List<ArogyaParametersGroup> arogyaParametersGroup;

  const HealthCheck({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.uhid,
    required this.barCode,
    required this.paid,
    required this.cleared,
    required this.isUnbilled,
    required this.isVerified,
    required this.completed,
    required this.billNumber,
    required this.token,
    required this.reportDate,
    required this.status,
    required this.labourId,
    required this.campaignId,
    required this.arogyaParametersGroup,

  });

  @override
  List<Object?> get props => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    uhid,
    barCode,
    paid,
    cleared,
    isUnbilled,
    isVerified,
    completed,
    billNumber,
    token,
    reportDate,
    status,
    labourId,
    campaignId,
    arogyaParametersGroup,
  ];
}

class ArogyaParametersGroup extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String name;
  final String department;
  final String uhid;
  final String barCode;
  final String gst;
  final String unitPrice;
  final String discount;
  final int reportingSequence;
  final String status;
  final String type;
  final List<ArogyaParameter> arogyaParameter;
  final String reportId;

  const ArogyaParametersGroup({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.department,
    required this.uhid,
    required this.barCode,
    required this.gst,
    required this.unitPrice,
    required this.discount,
    required this.reportingSequence,
    required this.status,
    required this.type,
    required this.arogyaParameter,
    required this.reportId,
  });

  @override
  List<Object?> get props => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    uhid,
    barCode,
    name,
    department,
    gst,
    unitPrice,
    discount,
    reportingSequence,
    status,
    type,
    arogyaParameter,
    reportId,
  ];
}

class ArogyaParameter extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String name;
  final String uhid;
  final String barCode;
  final String parameterGroupName;
  final String type;
  final String machineCode;
  final String matchValue;
  final String fieldType;
  final String selectOptions;
  final String unit;
  final String formula;
  final bool showMatchValueAsRange;
  final String value;
  final String comments;
  final List<ReportRange> ranges;
  final String status;
  final String interpretation;
  final String parameterGroupId;

  const ArogyaParameter({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.uhid,
    required this.barCode,
    required this.parameterGroupName,
    required this.type,
    required this.machineCode,
    required this.matchValue,
    required this.fieldType,
    required this.selectOptions,
    required this.unit,
    required this.formula,
    required this.showMatchValueAsRange,
    required this.value,
    required this.comments,
    required this.ranges,
    required this.status,
    required this.interpretation,
    required this.parameterGroupId,
  });

  @override
  List<Object?> get props =>
      [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        name,
        uhid,
        barCode,
        parameterGroupName,
        type,
        machineCode,
        matchValue,
        fieldType,
        selectOptions,
        unit,
        formula,
        showMatchValueAsRange,
        value,
        comments,
        ranges,
        status,
        interpretation,
        parameterGroupId
      ];
}

class ReportRange extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String minValue;
  final String maxValue;
  final String gender;
  final String minAge;
  final String maxAge;
  final String inRangeInterpretation;
  final String unit;
  final String parameterId;

  const ReportRange({
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
    List<Object?> get props =>
      [
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