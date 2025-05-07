import 'package:equatable/equatable.dart';

import '../../../common/domain/entities/lab_report_parameter_entity.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';

abstract class OximeterState extends Equatable {
  const OximeterState();

  @override
  List<Object?> get props => [];
}

class OximeterInitial extends OximeterState {}

class OximeterSaving extends OximeterState {}

class OximeterSaveSuccess extends OximeterState {
  final ScreeningSuccessResponse responseData;

  const OximeterSaveSuccess(this.responseData);

  @override
  List<Object> get props => [responseData];
}

class OximeterSaveFailed extends OximeterState {
  final String message;

  const OximeterSaveFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class OximeterLoading extends OximeterState {}

class OximeterLoadSuccess extends OximeterState {
  final LabReportEntity oximeterData;

  const OximeterLoadSuccess(this.oximeterData);

  @override
  List<Object> get props => [oximeterData];

}

class OximeterLoadFailed extends OximeterState {
  final String message;

  const OximeterLoadFailed({required this.message});

  @override
  List<Object?> get props => [message];
}