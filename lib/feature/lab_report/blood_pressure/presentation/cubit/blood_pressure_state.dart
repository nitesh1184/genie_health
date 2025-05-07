import 'package:equatable/equatable.dart';

import '../../../common/domain/entities/lab_report_parameter_entity.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';

abstract class BloodPressureState extends Equatable {
  const BloodPressureState();

  @override
  List<Object?> get props => [];
}

class BloodPressureInitial extends BloodPressureState {}

class BloodPressureSaving extends BloodPressureState {}

class BloodPressureSaveSuccess extends BloodPressureState {
  final ScreeningSuccessResponse responseData;

  const BloodPressureSaveSuccess(this.responseData);

  @override
  List<Object> get props => [responseData];
}

class BloodPressureSaveFailed extends BloodPressureState {
  final String message;

  const BloodPressureSaveFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class BloodPressureLoading extends BloodPressureState {}

class BloodPressureLoadSuccess extends BloodPressureState {
  final LabReportEntity bloodPressureData;

  const BloodPressureLoadSuccess(this.bloodPressureData);

  @override
  List<Object> get props => [bloodPressureData];

}

class BloodPressureLoadFailed extends BloodPressureState {
  final String message;

  const BloodPressureLoadFailed({required this.message});

  @override
  List<Object?> get props => [message];
}