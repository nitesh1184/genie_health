import '../../domain/entities/health_check.dart';

class HealthCheckModel extends HealthCheck {
  const HealthCheckModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required super.uhid,
    required super.barCode,
    required super.paid,
    required super.cleared,
    required super.isUnbilled,
    required super.isVerified,
    required super.completed,
    required super.billNumber,
    required super.token,
    required super.reportDate,
    required super.status,
    required super.labourId,
    required super.campaignId,
    required super.arogyaParametersGroup,
  });

  factory HealthCheckModel.fromJson(Map<String, dynamic> json) =>
      HealthCheckModel(
        id: json["ID"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
        deletedAt:
            json["DeletedAt"] != null
                ? DateTime.parse(json["DeletedAt"])
                : null,
        uhid: json["uhid"],
        barCode: json["bar_code"],
        status: json["status"],
        paid: json["paid"],
        cleared: json["cleared"],
        isUnbilled: json["is_unbilled"],
        isVerified: json["is_verified"],
        completed: json["completed"],
        billNumber: json["bill_number"],
        token: json["token"],
        reportDate: DateTime.parse(json["report_date"]),
        labourId: json["labour_id"],
        campaignId: json["campaign_id"],
        arogyaParametersGroup: List<ArogyaParametersGroup>.from(
          json["ArogyaParametersGroup"].map(
            (x) => ArogyaParametersGroupModel.fromJson(x),
          ),
        ),
      );
}

class ArogyaParametersGroupModel extends ArogyaParametersGroup {
  const ArogyaParametersGroupModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required super.name,
    required super.department,
    required super.uhid,
    required super.barCode,
    required super.gst,
    required super.unitPrice,
    required super.discount,
    required super.reportingSequence,
    required super.status,
    required super.type,
    required super.arogyaParameter,
    required super.reportId,
  });

  factory ArogyaParametersGroupModel.fromJson(Map<String, dynamic> json) => ArogyaParametersGroupModel(
    id: json["ID"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedAt: DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    name: json["Name"],
    department: json["Department"],
    uhid: json["uhid"],
    barCode: json["bar_code"],
    gst: json["GST"],
    unitPrice: json["UnitPrice"],
    discount: json["Discount"],
    reportingSequence: json["ReportingSequence"],
    status: json["status"],
    type: json["type"],
    arogyaParameter: List<ArogyaParameter>.from(json["ArogyaParameter"].map((x) => ArogyaParameterModel.fromJson(x))),
    reportId: json["ReportID"],
  );

}

class ArogyaParameterModel extends ArogyaParameter {
  const ArogyaParameterModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required super.name,
    required super.uhid,
    required super.barCode,
    required super.parameterGroupName,
    required super.type,
    required super.machineCode,
    required super.matchValue,
    required super.fieldType,
    required super.selectOptions,
    required super.unit,
    required super.formula,
    required super.showMatchValueAsRange,
    required super.value,
    required super.comments,
    required super.ranges,
    required super.status,
    required super.interpretation,
    required super.parameterGroupId,
  });

  factory ArogyaParameterModel.fromJson(Map<String, dynamic> json) =>
      ArogyaParameterModel(
        id: json["ID"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
        deletedAt:
            json["DeletedAt"] != null
                ? DateTime.parse(json["DeletedAt"])
                : null,
        name: json["name"],
        uhid: json["uhid"],
        barCode: json["bar_code"],
        parameterGroupName: json["parameter_group_name"],
        type: json["type"],
        machineCode: json["machine_code"],
        matchValue: json["match_value"],
        fieldType: json["field_type"],
        selectOptions: json["select_options"],
        unit: json["unit"],
        formula: json["formula"],
        showMatchValueAsRange: json["show_match_value_as_range"],
        value: json["value"],
        comments: json["comments"],
        ranges: List<ReportRange>.from(
          json["ranges"].map((x) => ReportRangeModel.fromJson(x)),
        ),
        status: json["status"],
        interpretation: json["interpretation"],
        parameterGroupId: json["parameter_group_id"],
      );
}

class ReportRangeModel extends ReportRange {
  const ReportRangeModel({
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

  factory ReportRangeModel.fromJson(Map<String, dynamic> json) =>
      ReportRangeModel(
        id: json["ID"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
        deletedAt:
            json["DeletedAt"] != null
                ? DateTime.parse(json["DeletedAt"])
                : null,
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
