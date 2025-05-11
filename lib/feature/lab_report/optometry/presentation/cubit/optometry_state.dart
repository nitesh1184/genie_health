import 'package:equatable/equatable.dart';

import '../../../common/domain/entities/lab_report_parameter_entity.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';

abstract class OptometryState extends Equatable {
  const OptometryState();

  @override
  List<Object?> get props => [];
}

class OptometryInitial extends OptometryState {}

class OptometrySaving extends OptometryState {}

class OptometrySaveSuccess extends OptometryState {
  final ScreeningSuccessResponse responseData;

  const OptometrySaveSuccess(this.responseData);

  @override
  List<Object> get props => [responseData];
}

class OptometrySaveFailed extends OptometryState {
  final String message;

  const OptometrySaveFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class OptometryLoading extends OptometryState {}

class OptometryLoadSuccess extends OptometryState {
  final LabReportEntity optometryData;

  const OptometryLoadSuccess(this.optometryData);

  @override
  List<Object> get props => [optometryData];

}

class OptometryLoadFailed extends OptometryState {
  final String message;

  const OptometryLoadFailed({required this.message});

  @override
  List<Object?> get props => [message];
}