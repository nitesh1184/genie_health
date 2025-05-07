import 'package:equatable/equatable.dart';

import '../../../common/domain/entities/lab_report_parameter_entity.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';

abstract class SpirometerState extends Equatable {
  const SpirometerState();

  @override
  List<Object?> get props => [];
}

class SpirometerInitial extends SpirometerState {}

class SpirometerSaving extends SpirometerState {}

class SpirometerSaveSuccess extends SpirometerState {
  final ScreeningSuccessResponse responseData;

  const SpirometerSaveSuccess(this.responseData);

  @override
  List<Object> get props => [responseData];
}

class SpirometerSaveFailed extends SpirometerState {
  final String message;

  const SpirometerSaveFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class SpirometerLoading extends SpirometerState {}

class SpirometerLoadSuccess extends SpirometerState {
  final LabReportEntity spirometerData;

  const SpirometerLoadSuccess(this.spirometerData);

  @override
  List<Object> get props => [spirometerData];

}

class SpirometerLoadFailed extends SpirometerState {
  final String message;

  const SpirometerLoadFailed({required this.message});

  @override
  List<Object?> get props => [message];
}